// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:taskist/employees/dbService.dart';
// import '../common/deviceApi.dart';
// import '../model/employee.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/auth_service.dart';
// import 'package:taskist/model/current_user_model.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key key, @required this.auth}) : super(key: key);
//   final AuthService auth;

//   @override
//   _RegisterFormState createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<LoginPage> {
// // class LoginPage extends StatelessWidget {
//   // LoginPage(this.database);
//   // final Database database;
//   AuthService auth;
//   @override
//   void initState() {
//     String id = DateTime.now().toString();
//     super.initState();
//     auth = widget.auth;
//   }

//   final Map<String, String> _formData = <String, String>{
//     'nickname': '',
//     'fullName': '',
//     'photoUrl': '',
//   };

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   FirebaseUser _firebaseUser;
//   bool _agreedToTOS = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Scoped model'),
//           elevation: 1.0,
//         ),
//         body: new Column(children: <Widget>[
//           Container(),
//           FloatingActionButton.extended(
//             onPressed: () => _scan(context),
//             // icon: Image.asset('assets/google_g_logo.png', height: 24.0),
//             label: const Text('Sign in with Google'),
//           )
//         ]));
//   }

//   Future<void> _scan(context) async {
//     DatabaseService serv = new DatabaseService();
//     serv.getEmployee("employeeId");
//     Employee employee = await serv.getEmployee('1444044');
//     // Employee employee = Employee.of(context);

//     Devices devs = new Devices();
//     var snipeId = '2';
//     var updatedDevice;
//     var device = await devs.getDeviceFromSnipe();
//     if (device['assigned_to'] == null) {
//       var checkout =
//           await devs.checkOutDevice(snipeId, device['id'].toString());
//     } else {
//       var checkin = await devs.checkInDevice(device['id'].toString());
//       var cout = await devs.checkOutDevice(snipeId, device['id'].toString());
//       print(cout);
//     }
//     if (device['assigned_to'] == null) {
//       return false;
//     }
//     if (device['assigned_to']['id'] == int.parse(snipeId)) {
//       updatedDevice = await devs.setDeviceOwner(employee.id);
//     }
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     await _prefs.setString('deviceOwner', employee.id);
//     List<String> l = await _prefs.getStringList('deviceEmployeeList');
//     if (l != null) {
//       l.add(employee.id);
//     } else {
//       List<String> l = new List<String>();
//       l.add(employee.id);
//     }
//     _handleSignIn(context);
//     await _prefs.setStringList('deviceEmployeeList', l);

//     _formData['fullName'] = employee.name;
//     _formData['photoUrl'] = employee.avatar.small;
//     _formData['nickname'] = employee.name;
//     return true;
//   }

//   bool _submittable() {
//     return _agreedToTOS;
//   }

//   String _initialNickname() {
//     return 'fixme';
//   }

//   bool _existingUser() {
//     return true;
//   }

//   Future<void> _handleSignIn(BuildContext context) async {
//     final CurrentEmployeeModel currentUserModel =
//         CurrentEmployeeModel.of(context);
//     await currentUserModel.signIn();
//     if (currentUserModel.status == Status.Authenticated) {
//       final Employee user = currentUserModel.employee;
//       _showSnackBar(context, 'Welcome ${user.name}');
//     }
//   }

//   void _showSnackBar(BuildContext context, String msg) {
//     final SnackBar snackBar = SnackBar(content: Text(msg));

//     Scaffold.of(context).showSnackBar(snackBar);
//   }

//   void _setAgreedToTOS(bool newValue) {
//     setState(() {
//       _agreedToTOS = newValue;
//     });
//   }
// }
