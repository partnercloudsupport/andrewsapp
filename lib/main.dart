import 'package:flutter/material.dart';
import 'model/current_user_model.dart';
import 'model/device_model.dart';
import 'package:taskist/employees/page_employees.dart';
import 'package:taskist/shop/page_orders.dart';
import 'package:taskist/map/map_view.dart';
import 'package:taskist/dashboard/dashboard_page.dart';
import 'package:taskist/assets/feed.dart';
import 'package:taskist/employees/widgets/employee_detail.dart';
import 'package:taskist/common/page_settings.dart';
import 'theme.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sms/sms.dart';
import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;
import 'root.dart';

void main() {
  SmsReceiver receiver = new SmsReceiver();
  receiver.onSmsReceived.listen((SmsMessage msg) => print(msg.body));
  print(env['DEVELOPMENT']);
  bool development = true;
  // final bool development = env['development'].toLowerCase() == 'true';
  runApp(MyApp(
    // deviceModel: DeviceModel(),
    development: development,
    // currentUserModel: CurrentUserModel.instance(),
  ));

  // SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // final DeviceModel deviceModel;
  // final CurrentUserModel currentUserModel;
  final bool development;
  const MyApp({
    Key key,
    // @required this.deviceModel,
    @required this.development,
    // @required this.currentUserModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CurrentUserModel>(
        model: CurrentUserModel.instance(),
        child: ScopedModel<DeviceModel>(
          model: DeviceModel.instance(),
          child: MaterialApp(
            theme: buildThemeData(),
            debugShowCheckedModeBanner: false,
            title: 'Birb',
            // theme: buildThemeData(),
            home: DashboardPage(),
            routes: {
              '/MapView': (context) => MapView(),
              '/RugPage': (context) => RugPage(),
              '/Dashboard': (context) => DashboardPage(),
              '/EmployeeList': (context) => EmployeeList(),
              '/Assets': (context) => Feed(),
              '/EmployeeDetail': (context) => EmployeeDetailsPage(),
              '/Settings': (context) => SettingsPage(),
            },
          ),
        ));
  }
}
