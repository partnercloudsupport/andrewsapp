// // import 'dart:convert';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:taskist/model/menu.dart';
// // import 'package:taskist/model/employee.dart';
// // import 'package:taskist/common/login_page.dart';
// // import 'package:taskist/common/base_scaffold.dart';
// // import 'package:taskist/model/current_user_model.dart';
// // import 'package:taskist/services/auth_service.dart';
// // import 'package:taskist/dashboard/dashboard.dart';
// // import 'package:taskist/common/signin_fab.dart';
// // import 'package:taskist/employees/page_employees.dart';
// // // import 'package:taskist/employees/geekants/Screens/Login/index.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:scoped_model/scoped_model.dart';
// // import 'database.dart';

// // final FirebaseAuth _auth = FirebaseAuth.instance;
// // const TRACKER_HOST = 'http://tracker.transistorsoft.com/locations/';
// // FirebaseUser _currentUser;
// // Employee currentEmployee;
// // Menu menu = new Menu();

// // enum AuthStatus {
// //   NOT_DETERMINED,
// //   NOT_LOGGED_IN,
// //   LOGGED_IN,
// // }

// // class RootPage extends StatefulWidget {
// //   // final BaseAuth auth;
// //   RootPage({Key key, this.currentEmployee}) : super(key: key);
// //   final Employee currentEmployee;
// //   factory RootPage.forDesignTime() {
// //     return new RootPage();
// //   }
// //   @override
// //   State<StatefulWidget> createState() => new _RootPageState();
// // }

// // class _RootPageState extends State<RootPage> {
// //   AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
// //   String _userId = "";
// //   FirebaseUser _currentUser;
// //   bool loggedIn = false;
// //   // EmployeesModel loginPage;
// //   Dashboard dashboard;
// //   Employee currentEmployee;
// //   Widget currentPage;
// //   // this will check status
// //   Future<Null> _function() async {
// //     SharedPreferences prefs;
// //     prefs = await SharedPreferences.getInstance();
// //     this.setState(() {
// //       if (prefs.getString("username") != null) {
// //         loggedIn = true;
// //       } else {
// //         loggedIn = false;
// //       }
// //     });
// //   }

// //   var database = AppFirestore();

// //   Future<Null> logoutUser() async {
// //     //logout user
// //     SharedPreferences prefs;
// //     prefs = await SharedPreferences.getInstance();
// //     await _auth.signOut();
// //     prefs.clear();
// //     prefs.commit();
// //     this.setState(() {
// //       loggedIn = false;
// //     });
// //   }

// //   void callback(Employee employee, Widget nextPage) {
// //     setState(() {
// //       this.currentEmployee = employee;
// //       this.currentPage = nextPage;
// //     });
// //   }

// //   Widget _floatingActionButton() {
// //     return ScopedModelDescendant<CurrentEmployeeModel>(
// //       builder: (
// //         BuildContext context,
// //         Widget child,
// //         CurrentEmployeeModel model,
// //       ) =>
// //           model.employee == null ? const SignInFab() : Container(),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: ScopedModelDescendant<CurrentEmployeeModel>(
// //       builder: (
// //         BuildContext context,
// //         Widget child,
// //         CurrentEmployeeModel model,
// //       ) =>
// //           model.employee == null ? const SignInFab() : Container(),
// //     ));
// //   }
// // }
// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:taskist/model/menu.dart';
// import 'package:taskist/model/employee.dart';
// import 'package:taskist/common/login_page.dart';
// import 'package:taskist/common/base_scaffold.dart';
// import 'package:taskist/model/current_user_model.dart';
// import 'package:taskist/services/auth_service.dart';
// import 'package:taskist/dashboard/dashboard.dart';
// import 'package:taskist/employees/page_employees.dart';
// // import 'package:taskist/employees/geekants/Screens/Login/index.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'database.dart';
// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';

// import './model/current_user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import './services/auth_service.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key key, this.title}) : super(key: key);

//   static const String routeName = '/';
//   final String title;

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   Widget _home(BuildContext context, CurrentUserModel model) {
// return  BaseScaffold(
//       showBottomNav: true,
//       // body: PostsList(_loadPosts(context)),
//       appTitle: 'birb',
//       bodyData: Dashboard(),
//       // floatingActionButton: _floatingActionButton(),
//     );
//   }

//   Widget _homeold(BuildContext context, CurrentUserModel model) {
// return  Scaffold(
//       // body: PostsList(_loadPosts(context)),
//       // floatingActionButton: _floatingActionButton(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//      return ScopedModelDescendant<CurrentUserModel>(
//       builder: (
//         BuildContext context,
//         Widget child,
//         CurrentUserModel model,
//       ) =>
//           model.user == null ? const SignInPage() : _home(context, model),
//     );

//   }

//   Widget _floatingActionButton() {
//     return ScopedModelDescendant<CurrentUserModel>(
//       builder: (
//         BuildContext context,
//         Widget child,
//         CurrentUserModel model,
//       ) =>
//           model.user == null ? const SignInPage() : Container(),
//     );
//   }

// }
