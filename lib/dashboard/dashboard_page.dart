import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../common/base_scaffold.dart';
import '../model/current_user_model.dart';
import '../model/device_model.dart';
import '../common/sign_in_page.dart';
import 'dashboard_view.dart';

import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key, this.title}) : super(key: key);

  static const String routeName = '/';
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DashboardPage> {
  String _platformVersion = 'Unknown';
  bool locationStarted = false;
  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // final deviceModel =
    //     ScopedModel.of<DeviceModel>(context, rebuildOnChange: true);
    // deviceModel.initPlatformState();

    // final model =
    //     ScopedModel.of<CurrentUserModel>(context, rebuildOnChange: true);
    // (model.employee != null)
    //     ? (deviceModel.owner == null)
    //         ? deviceModel.setOwner(model.employee.id)
    //         : null
    //     : null;

    // initPlatformState();

    // _locationSubscription =
    //     _location.onLocationChanged().listen((LocationData result) {
    //   setState(() {
    //     _currentLocation = result;
    //   });
    // });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // initPlatformState() async {
  //   LocationData location;
  //   // Platform messages may fail, so we use a try/catch PlatformException.

  //   try {
  //     _permission = await _location.hasPermission();
  //     location = await _location.getLocation();

  //     error = null;
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       error = 'Permission denied';
  //     } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
  //       error =
  //           'Permission denied - please ask the user to enable it from the app settings';
  //     }

  //     location = null;
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   //if (!mounted) return;

  //   setState(() {
  //     _startLocation = location;
  //   });
  // }

  Widget _home(BuildContext context, CurrentUserModel model) {
    return ScopedModelDescendant<DeviceModel>(
        builder: (
      BuildContext context,
      Widget child,
      DeviceModel deviceModel,
    ) =>
            model.user == null
                ? const SignInPage()
                : BaseScaffold(
                    showBottomNav: true,
                    // body: PostsList(_loadPosts(context)),
                    deviceModel: deviceModel,
                    showFAB: true,
                    alerts: false,
                    centerDocked: true,
                    appTitle: '_currentLocation',
                    currentEmployee: model.employee,
                    bodyData: Dashboard(),
                    // floatingActionButton: _floatingActionButton(),
                  ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceModel =
        ScopedModel.of<DeviceModel>(context, rebuildOnChange: true);
    (!locationStarted) ? deviceModel.initLocation() : null;
    locationStarted = true;
    // deviceModel.initPlatformState();

    final model =
        ScopedModel.of<CurrentUserModel>(context, rebuildOnChange: true);
    (model.employee != null)
        ? (deviceModel.owner == null)
            ? deviceModel.setOwner(model.employee.id)
            : null
        : null;

    return ScopedModelDescendant<CurrentUserModel>(
      builder: (
        BuildContext context,
        Widget child,
        CurrentUserModel model,
      ) =>
          model.user == null ? const SignInPage() : _home(context, model),
    );
  }

  Widget _floatingActionButton() {
    return ScopedModelDescendant<CurrentUserModel>(
      builder: (
        BuildContext context,
        Widget child,
        CurrentUserModel model,
      ) =>
          model.user == null ? const SignInPage() : Container(),
    );
  }
}
