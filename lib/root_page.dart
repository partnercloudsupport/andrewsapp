import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskist/model/menu.dart';
import 'package:taskist/common/login_page.dart';
import 'package:taskist/common/base_scaffold.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/shop/page_orders.dart';
import 'package:taskist/dashboard/dashboard.dart';
import 'package:taskist/employees/page_employees.dart';
// import 'package:taskist/employees/geekants/Screens/Login/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
const TRACKER_HOST = 'http://tracker.transistorsoft.com/locations/';
FirebaseUser _currentUser;
Employee currentEmployee;
Menu menu = new Menu();

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  // final BaseAuth auth;
  RootPage({Key key, this.currentEmployee}) : super(key: key);
  final Employee currentEmployee;
  factory RootPage.forDesignTime() {
    return new RootPage();
  }
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  FirebaseUser _currentUser;
  bool loggedIn = false;
  LoginPage loginPage;
  Dashboard dashboard;
  Employee currentEmployee;
  Widget currentPage;
  // this will check status
  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("username") != null) {
        loggedIn = true;
      } else {
        loggedIn = false;
      }
    });
  }

  Future<Null> logoutUser() async {
    //logout user
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await _auth.signOut();
    prefs.clear();
    prefs.commit();
    this.setState(() {
      /*
     updating the value of loggedIn to false so it will 
     automatically trigger the screen to display loginScaffold.
  */
      loggedIn = false;
    });
  }

  // // Device device;
  // setUser() async {
  //   var user = await _auth.currentUser();
  //   (user != null)
  //       ? this._currentUser = user
  //       : Navigator.of(context).push(
  //           new PageRouteBuilder(pageBuilder: (_, __, ___) => new LoginPage()));
  // }

  @override
  void initState() {
    super.initState();
    loginPage = LoginPage(this.callback);

    currentPage = loginPage;
    // setUser();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }

  // Widget _getLandingPage() {
  //   return StreamBuilder<FirebaseUser>(
  //     stream: FirebaseAuth.instance.onAuthStateChanged,
  //     builder: (BuildContext context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Dashboard();
  //       } else {
  //         return LoginPage();
  //       }
  //     },
  //   );
  // }

  // void _onLoggedIn() {
  //   _auth.currentUser().then((user) {
  //     setState(() {
  //       _userId = user.uid.toString();
  //     });
  //   });
  //   setState(() {
  //     authStatus = AuthStatus.LOGGED_IN;
  //   });
  // }

  // void _onSignedOut() {
  //   setState(() {
  //     authStatus = AuthStatus.NOT_LOGGED_IN;
  //     _userId = "";
  //   });
  // }

  // Widget _buildWaitingScreen() {
  //   return Scaffold(
  //     body: Container(
  //       alignment: Alignment.center,
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }

  void callback(Employee employee, Widget nextPage) {
    setState(() {
      this.currentEmployee = employee;
      this.currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        currentEmployee: currentEmployee,
        showBottomNav: false,
        bodyData: currentPage);
    // bodyData: Container(alignment: Alignment.center, child: Dashboard()));
    // child: (_currentUser == null) ? LoginPage() : Dashboard()));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return new MaterialApp(
  //       title: "SimpleBlogApp",
  //       // home: loggedIn ? _buildHomeScreen() : LoginPage());
  // }
  // @override
  // Widget build(BuildContext context) {
  //   if (_auth.currentUser() == null) {
  //     return LoginPage();
  //   } else {
  //     return _buildHomeScreen();
  //   }
  // }
}

// class HomePage extends StatefulWidget {
//   final FirebaseUser currentUser;
//   final Device device;
//   HomePage({Key key, this.currentUser, this.device}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   static FirebaseUser _currentUser;

//   setUser() async {
//     var user = await _auth.currentUser();
//     (user != null)
//         ? _currentUser = user
//         : Navigator.of(context).push(
//             new PageRouteBuilder(pageBuilder: (_, __, ___) => new LoginPage()));
//   }

//   @override
//   void initState() {
//     super.initState();
//     setUser();
//   }

//   callback(newAbc) {
//     setState(() {
//       _currentIndex = newAbc;
//     });
//   }
//   // scan() async {
//   //   final _futureString = await BarcodeScanner.scan();
//   //   final _result = await jsonDecode(_futureString);
//   //   FirebaseUser user = await customLogin(_result.email, _result.password);

//   //   (user is FirebaseUser) ? CircularProgressIndicator() : _buildHomeScreen();
//   //   _onLoggedIn();
//   //   return await widget.auth.signIn(_result.email, _result.password);
//   // }
//   void _onTabTapped(index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   int _currentIndex = 0;

//   int newIndex;

//   final List<Widget> _children = [
//     Dashboard(),
//     RugPage(user: _currentUser),
//     EmployeeList(),
//     // AntsLoginScreen(),
//     // CallSample(),
//     // TaskPage(),
//     // TaskPage(
//     //     // user: _currentUser,
//     //     ),
//     // TaskPage(
//     //     // user: _currentUser,
//     //     )
//   ];
//   Widget _getLandingPage() {
//     return StreamBuilder<FirebaseUser>(
//       stream: FirebaseAuth.instance.onAuthStateChanged,
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data.providerData.length == 1) {
//             // logged in using email and password
//             return snapshot.data.isEmailVerified ? Dashboard() : Dashboard();
//           } else {
//             // logged in using other providers
//             return Dashboard();
//           }
//         } else {
//           return LoginPage();
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: (_currentUser != null) ? _children[_currentIndex] : LoginPage());
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
