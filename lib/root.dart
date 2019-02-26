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
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './routes.dart';
// import './constants/theme.dart';
// import './utils/time_util.dart';
// import './config/application.dart';
import './model/main_state_model.dart';
import './dashboard/dashboard_page.dart';

void main() async {
  int themeIndex = await getTheme();
  runApp(App());
}

Future<int> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return 0;
}

class App extends StatefulWidget {
  App();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  dynamic subscription;
  MainStateModel mainStateModel;
  static EventBus eventBus;

  @override
  void initState() {
    super.initState();
    mainStateModel = MainStateModel();
    eventBus = new EventBus();
    // final Router router = Router();
    // Routes.configureRoutes(router);
    // Application.router = router;
    // TimeUtil.initLocaleLanguage();
    initListener();
  }

  initListener() {
    subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      String networkResult = "";
      switch (result) {
        case ConnectivityResult.mobile:
          networkResult = "当前处于移动网络";
          break;
        case ConnectivityResult.wifi:
          networkResult = "当前处于wifi网络";
          break;
        case ConnectivityResult.none:
          networkResult = "当前没有网络连接！";
          break;
        default:
          break;
      }
      //   Fluttertoast.showToast(
      //       msg: networkResult,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       timeInSecForIos: 1,
      //       // backgroundColor: themeList[mainStateModel.themeIndex != null
      //       //     ? mainStateModel.themeIndex
      //       //     : widget.themeIndex],
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStateModel>(
        model: mainStateModel,
        child: ScopedModelDescendant<MainStateModel>(
          builder: (context, child, model) {
            return MaterialApp(
              debugShowCheckedModeBanner: false, // 去除 DEBUG 标签
              // theme: ThemeData(
              //     platform: TargetPlatform.iOS,
              //     primaryColor: themeList[model.themeIndex != null
              //         ? model.themeIndex
              //         : widget.themeIndex]),
              home: DashboardPage(),
              // onGenerateRoute: Application.router.generator,
            );
          },
        ));
  }
}

// class MyApp extends StatelessWidget {
//   final DeviceModel deviceModel;
//   final CurrentUserModel currentUserModel;
//   final bool development;
//   const MyApp({
//     Key key,
//     @required this.deviceModel,
//     @required this.development,
//     @required this.currentUserModel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<CurrentUserModel>(
//         model: CurrentUserModel.instance(),
//         child: ScopedModel<DeviceModel>(
//           model: deviceModel,
//           child: MaterialApp(
//             theme: buildThemeData(),
//             debugShowCheckedModeBanner: false,
//             title: 'Birb',
//             // theme: buildThemeData(),
//             home: Feed(),
//             routes: {
//               '/MapView': (context) => MapView(),
//               '/RugPage': (context) => RugPage(),
//               '/Dashboard': (context) => DashboardPage(),
//               '/EmployeeList': (context) => EmployeeList(),
//               // '/Assets': (context) => AssetList(),
//               '/EmployeeDetail': (context) => EmployeeDetailsPage(),
//               '/Settings': (context) => SettingsPage(),
//             },
//           ),
//         ));
//   }
// }
