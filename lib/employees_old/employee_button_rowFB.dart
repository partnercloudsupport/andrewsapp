// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:taskist/employees/currentDevice.dart';
// // import 'package:taskist/employees/auth.dart';
// // import 'package:taskist/employees/flushbar.dart';
// import 'package:taskist/model/employee.dart';
// import 'device.dart';

// // Auth _auth = new Auth();

// class EmployeeButtonRowFB extends StatefulWidget {
//   EmployeeButtonRowFB(this.employee, this.device);
//   final Employee employee;
//   final Device device;

//   @override
//   _EmployeeButtonRowState createState() => new _EmployeeButtonRowState();
// }

// class _EmployeeButtonRowState extends State<EmployeeButtonRowFB> {
//   String barcode = "";
//   Employee employee;
//   Device device;
//   bool _clockedIn;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.employee != null) {
//       employee = widget.employee;
//       _clockedIn = widget.employee.clockedIn;
//     }
//     if (widget.device != null) {
//       device = widget.device;
//     }
//     initDevice();
//   }

//   void initDevice() async {
//     // CurrentDevice cd = new CurrentDevice();
//     // var widget.deviceData = await cd.getDeviceInfo();
//     // _widget.deviceId = widget.deviceData['androidId'];
//     // print('di ' + _widget.deviceId);
//   }

//   void _toggleClockedIn() {
//     setState(() {
//       _clockedIn = !_clockedIn;
//     });
//   }

//   void _punchClock() async {
//     var theme = Theme.of(context);
//     http.Response _clockResponse;
//     if (employee.clockedIn) {
//       _clockResponse = await http.put(
//           'https://www.humanity.com/api/v2/employees/${employee.humanityId}/clockout?access_token=b490958e4890f89ae444334283874c487aab419f');
//     } else {
//       _clockResponse = await http.post(
//           'https://www.humanity.com/api/v2/employees/${employee.humanityId}/clockin?access_token=b490958e4890f89ae444334283874c487aab419f');
//     }
//     final DocumentReference employeeRef =
//         Firestore.instance.document('employees/' + employee.id);
//     var decodedResponse =
//         json.decode(_clockResponse.body).cast<String, dynamic>();
//     bool updatedStatus;
//     if (decodedResponse['status'] == 13) {
//       (employee.clockedIn) ? updatedStatus = false : updatedStatus = true;
//     } else {
//       (decodedResponse['data']['out_timestamp'] == '0')
//           ? updatedStatus = true
//           : updatedStatus = false;
//     }

//     Firestore.instance.runTransaction((Transaction tx) async {
//       DocumentSnapshot empSnapshot = await tx.get(employeeRef);
//       if (empSnapshot.exists) {
//         // await tx
//         //     .update(employeeRef, <String, dynamic>{'clockedIn': updatedStatus});
//         // employee = empSnapshot.toDocument();
//         // // Navigator.pop(context);
//         // _toggleClockedIn();
//         // _buildActionButtons(Theme.of(context));
//       }
//     });
//   }

//   Widget _createClockButton(
//     String clockString, {
//     Color backgroundColor = Colors.transparent,
//     Color textColor = Colors.white70,
//   }) {
//     // if (employee.clockedIn && employee.currentDeviceId == widget.device.serial) {
//     if (true) {
//       return new ClipRRect(
//         // borderRadius: new BorderRadius.circular(30.0),
//         borderRadius: new BorderRadius.vertical(),
//         child: new MaterialButton(
//           minWidth: 140.0,
//           color: backgroundColor,
//           textColor: textColor,
//           onPressed: () {
//             _punchClock();
//             // (widget.device.employeeList.contains(employee.id))
//             //     ? _punchClock()
//             //     : _notifyCurrentDevice();
//           },
//           child: new Text(clockString),
//         ),
//       );
//     } else {
//       // return new ClipRRect(
//       //   // borderRadius: new BorderRadius.circular(30.0),
//       //   borderRadius: new BorderRadius.vertical(),
//       //   child: new MaterialButton(
//       //     minWidth: 140.0,
//       //     color: Colors.grey,
//       //     textColor: Colors.black,
//       //     onPressed: () {},
//       //     child: new Text(clockString),
//       //   ),
//       // );
//     }
//   }

//   _notifyCurrentDevice() {
//     // MyFlushBar f = new MyFlushBar();
//   }

//   _checkInDevice() {
//     print('checking in');
//     // _auth.handleSignOut(context, _widget.deviceId);

//     // Firestore.instance
//     // .collection('employees')
//     // .where("currentDevice", isEqualTo: "flutter")
//     // .snapshots()
//     // .listen((data) =>
//     //     data.documents.forEach((doc) => print(doc["title"])));
//   }

//   _changeDeviceOwner() {
//     print('changing dev');

//     // MyFlushBar f = new MyFlushBar();
//   }

//   Widget _createCheckOutButton(
//     String text, {
//     Color backgroundColor = Colors.transparent,
//     Color textColor = Colors.white70,
//   }) {
//     return new ClipRRect(
//       // borderRadius: new BorderRadius.circular(30.0),
//       borderRadius: new BorderRadius.vertical(),
//       child: new MaterialButton(
//         minWidth: 140.0,
//         color: backgroundColor,
//         textColor: textColor,
//         onPressed: () {
//           (employee.id == this.widget.device.assignedTo['id'])
//               ? _checkInDevice()
//               : _changeDeviceOwner();
//         },
//         child: new Text(text),
//       ),
//     );
//   }

//   Widget _buildActionButtons(ThemeData theme) {
//     String clockString;
//     // var employeeRef =
//     //     Firestore.instance.document('employees/' + employee.id);
//     // Firestore.instance.runTransaction((Transaction tx) async {
//     //   DocumentSnapshot empSnapshot = await tx.get(employeeRef);
//     //   employee = empSnapshot;
//     // });

//     // if (widget.device.employeeList.contains(employee.id)) {
//     (_clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
//     // }
//     String deviceString;

//     (device.assignedTo['id'] == employee.snipeId)
//         ? deviceString = 'CHECK IN'
//         : deviceString = 'TAKE OWNERSHIP';

//     return new Padding(
//       padding: const EdgeInsets.only(
//         top: 2.0,
//         left: 16.0,
//         right: 16.0,
//       ),
//       child: new Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _createClockButton(
//             clockString,
//             textColor: Colors.white,
//             backgroundColor: (_clockedIn) ? Colors.red : Colors.green,
//           ),
//           _createCheckOutButton(
//             deviceString,
//             backgroundColor: theme.accentColor,
//           ),
//           // new DecoratedBox(
//           //   decoration: new BoxDecoration(
//           //     border: new Border.all(color: Colors.white30),
//           //     borderRadius: new BorderRadius.circular(30.0),
//           //   ),
//           //   child: _createPillButton(
//           //     'FOLLOW',
//           //     textColor: Colors.white70,
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return new Stack(
//       children: <Widget>[_buildActionButtons(theme)],
//     );
//   }
// }
