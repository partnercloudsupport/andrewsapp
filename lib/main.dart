import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskist/rugs/page_done.dart';
import 'package:taskist/employees/page_employees.dart';

import 'package:taskist/rugs/page_task.dart';
import 'package:taskist/root_page.dart';
import 'package:taskist/tests/shopping_details/shopping_details_page.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser _currentUser;

Future<Null> main() async {
  _currentUser = await currentUser();
  runApp(new TaskistApp());
}

Future<FirebaseUser> currentUser() async {
  final user = await _auth.currentUser();
  return user;
}

// class HomePage extends StatefulWidget {
//   final FirebaseUser user;

//   HomePage({Key key, this.user}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _HomePageState();
// }

class TaskistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      showSemanticsDebugger: false,
      routes: {
    // When we navigate to the "/" route, build the FirstScreen Widget
    '/': (context) => RootPage( user: _currentUser),
    // When we navigate to the "/second" route, build the SecondScreen Widget
    // '/EmployeeList': (context) => EmployeeList( user: _currentUser),
  },
      title: "Andrews App",
      // home: RootPage(
      //   user: _currentUser,
      // ),
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   int _currentIndex = 1;

//   final List<Widget> _children = [
//     // Tests(),
//     // EmployeesListPage(),
//     // EmployeesListPage(
//     //     // user: _currentUser,
//     //     ),
//     // EmployeesListPage(
//     //     // user: _currentUser,
//     //     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // bottomNavigationBar: BottomNavigationBar(
//       //   onTap: onTabTapped,
//       //   currentIndex: _currentIndex,
//       //   fixedColor: Colors.deepPurple,
//       //   items: <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.tablets), title: new Text("")),
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.calendarCheck),
//       //         title: new Text("")),
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.calendar), title: new Text("")),
//       //     BottomNavigationBarItem(
//       //         icon: new Icon(FontAwesomeIcons.slidersH), title: new Text(""))
//       //   ],
//       // ),
//       body: _children[_currentIndex],
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }