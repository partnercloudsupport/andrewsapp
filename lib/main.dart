import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/current_user_model.dart';
import 'model/device_model.dart';
import 'package:flutter/material.dart';
import 'package:taskist/employees/page_employees.dart';
import 'package:taskist/root_page.dart';
import 'package:taskist/shop/page_orders.dart';
import 'package:taskist/home/home_page.dart';
import 'package:taskist/dashboard/dashboard.dart';
import 'package:taskist/employees/widgets/employee_detail.dart';
import 'package:taskist/common/page_settings.dart';
import 'package:scoped_model/scoped_model.dart';
import 'theme.dart';

void main() {
//   LocationSensorConfig config = LocationSensorConfig();
//   config.debug = true;
//   config.label = 'asdf';
//   config.dbHost = 'http://ashdevtools.com/test';
//   config.deviceId = "testDevice";

// // init sensor
//   var sensor = LocationSensor.init(config);

//   void method() {
//     /// start
//     sensor.enable();

//     ///
//     sensor.start();
//     // /// set observer
//     // sensor.onLocationChanged(LocationData data){
//     //   setState((){
//     //     // Your code here
//     //   });
//     // };
//     // sensor.onLocationChanged.listen(LocationData data){
//     //   setState((){
//     //     // Your code here
//     //   });
//     // };
//     /// stop
//     // sensor.stop();

//     /// sync
//     sensor.sync(force: true);

//     // make a sensor care by the following code
//     var card = new LocationCard(sensor: sensor);
//     // NEXT: Add the card instance into a target Widget.
  // }

  runApp(MyApp(
    deviceModel: DeviceModel(),
    currentUserModel: CurrentUserModel.instance(),
  ));

  // SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  final DeviceModel deviceModel;
  final CurrentUserModel currentUserModel;

  const MyApp({
    Key key,
    @required this.deviceModel,
    @required this.currentUserModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CurrentUserModel>(
        model: CurrentUserModel.instance(),
        child: ScopedModel<DeviceModel>(
          model: deviceModel,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Birb',
            theme: buildThemeData(),
            home: const DashboardPage(title: 'Birb'),
            routes: {
              // '/LoginPage': (context) => LoginPage(),
              '/RugPage': (context) => RugPage(),
              '/Dashboard': (context) => Dashboard(),
              '/EmployeeList': (context) => EmployeeList(),
              '/EmployeeDetail': (context) => EmployeeDetailsPage(),
              '/Settings': (context) => SettingsPage(),
            },
          ),
        ));
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:taskist/employees/page_employees.dart';
// import 'package:taskist/root_page.dart';
// import 'package:taskist/shop/page_orders.dart';
// import 'package:taskist/dashboard/dashboard.dart';
// import 'package:taskist/model/current_user_model.dart';
// import 'package:taskist/employees/widgets/employee_detail.dart';
// import 'package:taskist/common/page_settings.dart';
// import 'package:flutter_stetho/flutter_stetho.dart';
// import 'package:scoped_model/scoped_model.dart';

// Future<Null> main() async {
//   Stetho.initialize();
//   // var employeeRepo = const EmployeesRepositoryFlutter(
//   //   fileStorage: const FileStorage(
//   //     'scoped_model_todos',
//   //     getApplicationDocumentsDirectory,
//   //   ),
//   // );
//   runApp(new TaskistApp());
// }
// // SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);

// class TaskistApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<CurrentEmployeeModel>(
//         model: CurrentEmployeeModel.instance(),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: true,
//           showSemanticsDebugger: false,
//           routes: {
//             // '/LoginPage': (context) => LoginPage(),
//             '/RugPage': (context) => RugPage(),
//             '/Dashboard': (context) => Dashboard(),
//             '/EmployeeList': (context) => EmployeeList(),
//             '/EmployeeDetail': (context) => EmployeeDetailsPage(),
//             '/Settings': (context) => SettingsPage(),
//           },
//           title: "Andrews App",
//           home: HomePage(),
//           theme: new ThemeData(primarySwatch: Colors.blue),
//         ));
//   }
// }
