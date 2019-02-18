import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taskist/employees/page_employees.dart';
import 'package:taskist/root_page.dart';
import 'package:taskist/shop/page_orders.dart';
import 'package:taskist/dashboard/dashboard.dart';
import 'package:taskist/employees/widgets/employee_detail.dart';
import 'package:taskist/common/page_settings.dart';



Future<Null> main() async {
  runApp(new TaskistApp());
}

class TaskistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      showSemanticsDebugger: false,
      routes: {
        '/home': (context) => RootPage(),
        '/RugPage': (context) => RugPage(),
        '/Dashboard': (context) => Dashboard(),
        '/EmployeeList': (context) => EmployeeList(),
        '/EmployeeDetail': (context) => EmployeeDetailsPage(),
        '/Settings': (context) => SettingsPage(),
      },
      title: "Andrews App",
      home: RootPage(
      ),
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}
