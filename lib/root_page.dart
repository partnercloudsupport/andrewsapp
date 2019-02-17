import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskist/common/assetsApi.dart';
import 'package:taskist/model/menu.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/shop/page_orders.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:taskist/employees/page_employees.dart';
import 'package:taskist/employees/geekants/Screens/Login/index.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
const TRACKER_HOST = 'http://tracker.transistorsoft.com/locations/';
FirebaseUser _currentUser;
Menu menu = new Menu();

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  final FirebaseUser user;
  // final BaseAuth auth;

  RootPage({Key key, this.user}) : super(key: key);

  factory RootPage.forDesignTime() {
    return new RootPage();
  }
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  // Device device;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
      if (user == null) {
        scan();
      }
    });
  }

  void _onLoggedIn() {
    _auth.currentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  scan() async {
    final _futureString = await BarcodeScanner.scan();
    final _result = await jsonDecode(_futureString);

    FirebaseUser user = await customLogin(_result.email, _result.password);
    (user is FirebaseUser) ? CircularProgressIndicator() : _buildHomeScreen();
    _onLoggedIn();
    // return await widget.auth.signIn(_result.email, _result.password);
  }

  Widget _buildHomeScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        // return _buildQRScreen();
        return scan();

        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return _buildHomeScreen();
        } else
          return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  final Device device;
  HomePage({Key key, this.user, this.device}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  callback(newAbc) {
    setState(() {
      _currentIndex = newAbc;
    });
  }

  void _onTabTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;

  int newIndex;

  final List<Widget> _children = [
    RugPage(user: _currentUser),
    EmployeeList(),
    AntsLoginScreen(),
    // CallSample(),
    // TaskPage(),
    // TaskPage(
    //     // user: _currentUser,
    //     ),
    // TaskPage(
    //     // user: _currentUser,
    //     )
  ];

  @override
  Widget build(BuildContext context) {
    // return CommonScaffold(
    //     // backGroundColor: Colors.grey.shade100,
    //     backGroundColor: Colors.white,
    //     actionFirstIcon: null,
    //     appTitle: "Product Detail",
    //     showFAB: true,
    //     scaffoldKey: _scaffoldState,
    //     showDrawer: false,
    //     centerDocked: true,
    //     callback: callback(newIndex),
    //     floatingIcon: Icons.add,
    //     // bodyData: bodyData(productBloc.productItems),
    //     bodyData:    RugPage(),
    //     showBottomNav: true,
    //  );
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: onTabTapped,
      //   currentIndex: _currentIndex,
      //   fixedColor: Colors.deepPurple,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: new Icon(FontAwesomeIcons.tablets), title: new Text("")),
      //     BottomNavigationBarItem(
      //         icon: new Icon(FontAwesomeIcons.calendarCheck),
      //         title: new Text("")),
      //     BottomNavigationBarItem(
      //         icon: new Icon(FontAwesomeIcons.calendar), title: new Text("")),
      //     BottomNavigationBarItem(
      //         icon: new Icon(FontAwesomeIcons.slidersH), title: new Text(""))
      //   ],
      // ),
      body: _children[_currentIndex],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
