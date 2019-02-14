import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:background_fetch/background_fetch.dart';

import './app.dart';
import 'map_view.dart';
import 'event_list.dart';
import 'dialog.dart' as util;
import 'shared_events.dart';

// For pretty-printing location JSON
JsonEncoder encoder = new JsonEncoder.withIndent("     ");

/// The main home-screen of the AdvancedApp.  Builds the Scaffold of the App.
///
class HomeView extends StatefulWidget {
  @override
  State createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with TickerProviderStateMixin<HomeView> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TabController _tabController;

  bool _isMoving;
  bool _enabled;
  String _motionActivity;
  String _odometer;

  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _isMoving = false;
    _enabled = false;
    _motionActivity = 'UNKNOWN';
    _odometer = '0';

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabChange);

    initPlatformState();
  }

  Future<Null> initPlatformState() async {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true), () async {
      print('[BackgroundFetch] received event');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int count = 0;
      if (prefs.get("fetch-count") != null) {
        count = prefs.getInt("fetch-count");
      }
      prefs.setInt("fetch-count", ++count);
      print('[BackgroundFetch] count: $count');

      BackgroundFetch.finish();
    });

    // 1.  Listen to events (See docs for all 12 available events).
    bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    bg.BackgroundGeolocation.onActivityChange(_onActivityChange);
    bg.BackgroundGeolocation.onProviderChange(_onProviderChange);
    bg.BackgroundGeolocation.onHttp(_onHttp);
    bg.BackgroundGeolocation.onConnectivityChange(_onConnectivityChange);
    bg.BackgroundGeolocation.onHeartbeat(_onHeartbeat);
    bg.BackgroundGeolocation.onGeofence(_onGeofence);
    bg.BackgroundGeolocation.onGeofencesChange(_onGeofencesChange);
    bg.BackgroundGeolocation.onSchedule(_onSchedule);
    bg.BackgroundGeolocation.onPowerSaveChange(_onPowerSaveChange);
    bg.BackgroundGeolocation.onEnabledChange(_onEnabledChange);

    // Fetch username and devivceParams for posting to tracker.transistorsoft.com
    final SharedPreferences prefs = await _prefs;

    String username = prefs.getString("username");
    Map deviceParams = await bg.Config.deviceParams;

    // 2.  Configure the plugin
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_NAVIGATION,
            distanceFilter: 10.0,
            stopOnTerminate: false,
            startOnBoot: true,
            foregroundService: true,
            enableHeadless: true,
            stopTimeout: 1,
            debug: true,
            autoSync: true,
            url: 'http://tracker.transistorsoft.com/locations/$username',
            params: deviceParams,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      setState(() {
        _enabled = state.enabled;
        _isMoving = state.isMoving;
      });
    }).catchError((error) {
      print('[ready] ERROR: $error');
    });

    // Fetch currently selected tab.
    int tabIndex = prefs.getInt("tabIndex");

    // Which tab to view?  MapView || EventList.   Must wait until after build before switching tab or bad things happen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tabIndex != null) {
        _tabController.animateTo(tabIndex);
      }
    });
  }

  void _onClickEnable(enabled) {
    bg.BackgroundGeolocation.playSound(util.Dialog.getSoundId("BUTTON_CLICK"));

    if (enabled) {
      bg.BackgroundGeolocation.start().then((bg.State state) {
        print('[start] success $state');
        setState(() {
          _enabled = state.enabled;
          _isMoving = state.isMoving;
        });
      });
    } else {
      bg.BackgroundGeolocation.stop().then((bg.State state) {
        print('[stop] success: $state');
        // Reset odometer.
        setState(() {
          _enabled = state.enabled;
          _isMoving = state.isMoving;
        });
      });
    }
  }

  // Manually toggle the tracking state:  moving vs stationary
  void _onClickChangePace() {
    setState(() {
      _isMoving = !_isMoving;
    });
    print("[onClickChangePace] -> $_isMoving");

    bg.BackgroundGeolocation.changePace(_isMoving).then((bool isMoving) {
      print('[changePace] success $isMoving');
    }).catchError((e) {
      print('[changePace] ERROR: ' + e.code.toString());
    });
  }

  // Manually fetch the current position.
  void _onClickGetCurrentPosition() {
    bg.BackgroundGeolocation.getCurrentPosition(
            persist: false, // <-- do not persist this location
            desiredAccuracy: 0, // <-- desire best possible accuracy
            timeout: 30000, // <-- wait 30s before giving up.
            samples: 3 // <-- sample 3 location before selecting best.
            )
        .then((bg.Location location) {
      print('[getCurrentPosition] - $location');
    }).catchError((error) {
      print('[getCurrentPosition] ERROR: $error');
    });
  }

  // Go back to HomeApp
  void _onClickHome() {
    bg.BackgroundGeolocation.playSound(util.Dialog.getSoundId("CLOSE"));
    bg.BackgroundGeolocation.stop();
    bg.BackgroundGeolocation.removeListeners();
    // runApp(HomeApp());
  }

  ////
  // Event handlers
  //

  void _onLocation(bg.Location location) {
    print('[${bg.Event.LOCATION}] - $location');

    setState(() {
      events.insert(0,
          Event(bg.Event.LOCATION, location, location.toString(compact: true)));
      _odometer = (location.odometer / 1000.0).toStringAsFixed(1);
    });
  }

  void _onLocationError(bg.LocationError error) {
    print('[${bg.Event.LOCATION}] ERROR - $error');
    setState(() {
      events.insert(
          0, Event(bg.Event.LOCATION + " error", error, error.toString()));
    });
  }

  void _onMotionChange(bg.Location location) {
    print('[${bg.Event.MOTIONCHANGE}] - $location');
    setState(() {
      events.insert(
          0,
          Event(bg.Event.MOTIONCHANGE, location,
              location.toString(compact: true)));
      _isMoving = location.isMoving;
    });
  }

  void _onActivityChange(bg.ActivityChangeEvent event) {
    print('[${bg.Event.ACTIVITYCHANGE}] - $event');
    setState(() {
      events.insert(0, Event(bg.Event.ACTIVITYCHANGE, event, event.toString()));
      _motionActivity = event.activity;
    });
  }

  void _onProviderChange(bg.ProviderChangeEvent event) {
    print('[${bg.Event.PROVIDERCHANGE}] - $event');
    setState(() {
      events.insert(0, Event(bg.Event.PROVIDERCHANGE, event, event.toString()));
    });
  }

  void _onHttp(bg.HttpEvent event) {
    print('[${bg.Event.HTTP}] - $event');

    setState(() {
      events.insert(0, Event(bg.Event.HTTP, event, event.toString()));
    });
  }

  void _onConnectivityChange(bg.ConnectivityChangeEvent event) {
    print('[${bg.Event.CONNECTIVITYCHANGE}] - $event');
    setState(() {
      events.insert(
          0, Event(bg.Event.CONNECTIVITYCHANGE, event, event.toString()));
    });
  }

  void _onHeartbeat(bg.HeartbeatEvent event) {
    print('[${bg.Event.HEARTBEAT}] - $event');
    setState(() {
      events.insert(
          0,
          Event(bg.Event.HEARTBEAT, event,
              event.location.toString(compact: false)));
    });
  }

  void _onGeofence(bg.GeofenceEvent event) {
    print('[${bg.Event.GEOFENCE}] - $event');
    setState(() {
      events.insert(
          0, Event(bg.Event.GEOFENCE, event, event.toString(compact: false)));
    });
  }

  void _onGeofencesChange(bg.GeofencesChangeEvent event) {
    print('[${bg.Event.GEOFENCESCHANGE}] - $event');
    setState(() {
      events.insert(
          0,
          Event(
              bg.Event.GEOFENCESCHANGE, event, event.toString(compact: false)));
    });
  }

  void _onSchedule(bg.State state) {
    print('[${bg.Event.SCHEDULE}] - $state');
    setState(() {
      events.insert(
          0, Event(bg.Event.SCHEDULE, state, "enabled: ${state.enabled}"));
    });
  }

  void _onEnabledChange(bool enabled) {
    print('[${bg.Event.ENABLEDCHANGE}] - $enabled');
    setState(() {
      events.clear();
      events.insert(
          0,
          Event(bg.Event.ENABLEDCHANGE, enabled,
              '[EnabledChangeEvent enabled: $enabled]'));
    });
  }

  void _onPowerSaveChange(bool enabled) {
    print('[${bg.Event.POWERSAVECHANGE}] - $enabled');
    setState(() {
      events.insert(
          0,
          Event(bg.Event.POWERSAVECHANGE, enabled,
              'Power-saving enabled: $enabled'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('BG Geo'),
          centerTitle: true,
          leading: IconButton(
              onPressed: _onClickHome,
              icon: Icon(Icons.home, color: Colors.black)),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          brightness: Brightness.light,
          actions: <Widget>[
            Switch(value: _enabled, onChanged: _onClickEnable),
          ],
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              tabs: [Tab(icon: Icon(Icons.map)), Tab(icon: Icon(Icons.list))])),
      //body: body,
      body: SharedEvents(
          events: events,
          child: TabBarView(
              controller: _tabController,
              children: [MapView(), EventList()],
              physics: new NeverScrollableScrollPhysics())),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.gps_fixed),
                      onPressed: _onClickGetCurrentPosition,
                    ),
                    Text('$_motionActivity · $_odometer km'),
                    MaterialButton(
                        minWidth: 50.0,
                        child: Icon(
                            (_isMoving) ? Icons.pause : Icons.play_arrow,
                            color: Colors.white),
                        color: (_isMoving) ? Colors.red : Colors.green,
                        onPressed: _onClickChangePace)
                  ]))),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() async {
    if (!_tabController.indexIsChanging) {
      return;
    }
    final SharedPreferences prefs = await _prefs;
    prefs.setInt("tabIndex", _tabController.index);
  }
}
