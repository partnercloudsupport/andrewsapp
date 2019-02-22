import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:latlong/latlong.dart';

import 'dart:async';

import '../services/auth_service.dart';
import '../services/device_service.dart';
import '../services/employee_service.dart';
import 'device.dart';
import 'employee.dart';

enum Status {
  Moving,
  NotMoving,
}

class DeviceModel extends Model {
  DeviceModel({
    @required this.deviceService,
  });

  static String dis(LatLng newLoc) {
    const Distance distance = Distance();
    LatLng store = LatLng(32.311211, -95.263390);
    double meter = distance(store, newLoc);
    double mile = meter * 0.00062137;
    return mile.toStringAsFixed(2);
  }

  DeviceModel.instance() : deviceService = DeviceService.instance() {}

  Status _status = Status.NotMoving;
  DeviceService deviceService;
  Device _device;
  String _owner;
  String _platformVersion = 'Unknown';
  bool initComplete = false;
  static DeviceModel of(BuildContext context) =>
      ScopedModel.of<DeviceModel>(context);

  Device get device => _device;
  String get owner => _owner;
  Status get status => _status;
  // FirebaseDevice get firebaseDevice => _firebaseDevice;
  String error;
  bool subset = false;

  bool currentWidget = true;

  Future<void> setOwner(String employee) async {
    deviceService = new DeviceService();
    bool success = await deviceService.setOwner(employee);
    if (success) {
      _owner = employee;
    }
    _device = new Device();
    _device.currentPosition = GeoPoint(0.0, 0.0);
    notifyListeners();
  }

  GeoPoint getLocation() {
    return _device.currentPosition;
  }

  void initLocation() {
    (!initComplete) ? start() : null;
  }

  void start() {
    _device = new Device();
    // 1.  Listen to events (See docs for all 12 available events).
    print('[location] inited');
    LatLng center = new LatLng(32.317315, -95.247462);

    String _identifier = 'asdf';
    double _radius = 200.0;
    bool _notifyOnEntry = true;
    bool _notifyOnExit = true;
    bool _notifyOnDwell = false;
    int _loiteringDelay = 10000;

    bg.BackgroundGeolocation.addGeofence(bg.Geofence(
        identifier: _identifier,
        radius: _radius,
        latitude: center.latitude,
        longitude: center.longitude,
        notifyOnEntry: _notifyOnEntry,
        notifyOnExit: _notifyOnExit,
        notifyOnDwell: _notifyOnDwell,
        loiteringDelay: _loiteringDelay,
        extras: {
          'radius': _radius,
          'center': {'latitude': center.latitude, 'longitude': center.longitude}
        } // meta-data for tracker.transistorsoft.com
        )).then((bool success) {
      print('[geofence]  added');
    }).catchError((error) {
      print('[addGeofence] ERROR: $error');
    });
    bg.BackgroundGeolocation.onGeofence((geofence) {
      print('[geofence] ' + geofence.identifier + ' ' + geofence.action);
    });

    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      GeoPoint gp =
          new GeoPoint(location.coords.latitude, location.coords.longitude);
      _device.currentPosition = gp;
      _device.distanceToStore =
          dis(new LatLng(location.coords.latitude, location.coords.longitude));

      print('[location] - $location');
      notifyListeners();
    });
    bg.BackgroundGeolocation.onHeartbeat((bg.HeartbeatEvent event) async {
      print(bg.State);
      var l = await bg.BackgroundGeolocation.getCurrentPosition();
      _device.distanceToStore =
          dis(new LatLng(l.coords.latitude, l.coords.longitude));
      _device.currentPosition =
          new GeoPoint(l.coords.latitude, l.coords.longitude);
      print('[location] - $event');
      notifyListeners();
    });
    bg.BackgroundGeolocation.onHttp((bg.HttpEvent event) {
      print('[location] - $event');
      notifyListeners();
    });
    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
      notifyListeners();
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
      notifyListeners();
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 0,
            autoSync: true,
            activityRecognitionInterval: 5000,
            heartbeatInterval: 5,
            locationUpdateInterval: 6000,
            stopOnTerminate: false,
            startOnBoot: true,
            url: 'http://requestbin.fullcontact.com/1mufdvq1',
            params: {
              'deviceId': _device.androidId,
              'owner': _device.ownerId,
              'employeeList': _device.employees
            },
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE,
            reset: true))
        .then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
        print('[location] started');
        initComplete = true;
        notifyListeners();
      }
    });
  }
}
