// import 'dart:async';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:taskist/employees/employee_detail_pageFB.dart';
// import 'package:taskist/model/employee.dart';
// import 'package:taskist/employees/device.dart';
// import 'package:taskist/common/assetsApi.dart';
// import 'package:taskist/employees/currentStatus.dart';
// import 'package:device_info/device_info.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'employee_provider.dart';
// import 'employee_bloc.dart';
// import '../tests/common/common_scaffold.dart';

// Assets assets = new Assets();

// final DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

// class AssetsActivity extends StatefulWidget {
//   @override
//   _EmployeesListPageState createState() => new _EmployeesListPageState();
// }

// class _EmployeesListPageState extends State<AssetsActivity> {
//   List<Employee> _employees = [];
//   Device device;
//   List<CurrentStatus> _onlineNow = [];
//   // CurrentDevice currentDevice = new CurrentDevice();
//   String deviceId;
//   final _scaffoldState = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _loadEmployees();
//     _loadDevice();
//   }

//   Future<void> _loadDevice() async {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     this.device = await assets.getHardwareByAndroidId(androidInfo.androidId);
//   }

//   Future<void> _loadEmployees() async {
//     http.Response _employeesResponse =
//         // await http.get('https://randomuser.me/api/?results=25');
//         await http.get(
//             'https://www.humanity.com/api/v2/employees?access_token=b490958e4890f89ae444334283874c487aab419f');

//     http.Response _clockedInResponse =
//         // await http.get('https://randomuser.me/api/?results=25');
//         await http.get(
//             'https://www.humanity.com/api/v2/dashboard/onnow?access_token=b490958e4890f89ae444334283874c487aab419f');

//     List<Employee> _emps = Employee.allFromResponse(_employeesResponse.body);

//     _onlineNow = CurrentStatus.allFromResponse(_clockedInResponse.body);

//     setState(() {
//       _employees = _emps;
//       _onlineNow = _onlineNow;
//       // _employees = Employee.allFromResponse(_employeesResponse.body);
//       // _clockedIn = Employee.allFromResponse(_clockedInResponse.body);
//     });
//   }

//   Widget _buildEmployeeListTile(BuildContext context, int index) {
//     var employee = _employees[index];
//     var currentStatus;
// // no need of the file extension, the name will do fine.

//     return new ListTile(
//       onTap: () => _navigateToEmployeeDetails(employee, device),
//       leading: new Hero(
//         tag: index,
//         child: new CircleAvatar(
//           backgroundImage: new NetworkImage(employee.avatar),
//           // child: Text(employee.clockStatus),
//         ),
//       ),
//       title: new Text(
//         employee.name,
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       subtitle: new Text(employee.email),
//       trailing: (employee.clockedIn)
//           ? new IconTheme(
//               data: new IconThemeData(color: Colors.green),
//               child: new Icon(Icons.access_time))
//           : null,
//     );
//   }

//   void _navigateToEmployeeDetails(Employee employee, Device device) {
//     // Navigator.of(context).push(
//     //   new MaterialPageRoute(
//     //     builder: (c) {
//     //       return new EmployeeDetailsPage(employee, currentStatus,
//     //           avatarTag: avatarTag);
//     //     },
//     //   ),
//     // );
//   }

//   // void _navigateToEmployeeDetailsFB(DocumentSnapshot employee) {
//   //   Navigator.of(context).push(
//   //     new MaterialPageRoute(
//   //       builder: (c) {
//   //         return new EmployeeDetailsPageFB(employee);
//   //       },
//   //     ),
//   //   );
//   // }

//   Widget buildItem(BuildContext context, Employee employee) {
//     return Container(
//       child: FlatButton(
//         child: Row(
//           children: <Widget>[
//             Material(
//               child: CachedNetworkImage(
//                 placeholder: Container(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 1.0,
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(Color(0xfff5a623)),
//                   ),
//                   width: 50.0,
//                   height: 50.0,
//                   padding: EdgeInsets.all(15.0),
//                 ),
//                 imageUrl: employee.avatar,
//                 width: 50.0,
//                 height: 50.0,
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(25.0)),
//               clipBehavior: Clip.hardEdge,
//             ),
//             Flexible(
//               child: Container(
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       child: Text(
//                         // document['name'],
//                         employee.name,
//                         style: TextStyle(color: Color(0xff203152)),
//                       ),
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
//                     ),
//                     // Container(
//                     //   child: Text(
//                     //     'About me: ${document['aboutMe'] ?? 'Not available'}',
//                     //     style: TextStyle(color: Color(0xff203152)),
//                     //   ),
//                     //   alignment: Alignment.centerLeft,
//                     //   margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                     // )
//                   ],
//                 ),
//                 margin: EdgeInsets.only(left: 20.0),
//               ),
//             ),
//             Flexible(
//                 child: Container(
//                     // child: (document['clockedIn'])
//                     child: (employee.clockedIn)
//                         ? new IconTheme(
//                             data: new IconThemeData(color: Colors.green),
//                             child: new Icon(Icons.access_time))
//                         : null,
//                     margin: EdgeInsets.only(left: 120.0))),
//             Flexible(
//                 child: Container(
//                     // child: (document['deviceOwner'])
//                     child: (employee.clockedIn)
//                         ? new IconTheme(
//                             data: new IconThemeData(color: Colors.black),
//                             child: new Icon(Icons.star))
//                         : null,
//                     margin: EdgeInsets.only(left: 60.0)))
//           ],
//         ),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) =>
//                       // EmployeeDetailsPageFB(document, deviceId)));
//                       EmployeeDetailsPageFB(employee, this.device)));
//         },
//         color: Color(0xffE8E8E8),
//         padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//       ),
//       margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
//     );
//   }

//   Widget _buildList(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance.collection('employees').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return new Text('Loading...');
//             default:
//               return new Container(
//                 child: StreamBuilder(
//                   stream:
//                       Firestore.instance.collection('employees').snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.green),
//                         ),
//                       );
//                     } else {
//                       return ListView.builder(
//                         padding: EdgeInsets.all(10.0),
//                         itemBuilder: (context, index) =>
//                             // buildItem(context, Employee.fromMap(snapshot.data.documents[index]))
//                             // buildItem(context, snapshot.data.documents[index]),
//                             buildItem(
//                                 context,
//                                 Employee.fromDocument(
//                                     snapshot.data.documents[index])),
//                         itemCount: snapshot.data.documents.length,
//                       );
//                     }
//                   },
//                 ),
//               );
//           }
//         });
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   Widget content;

//   //   return new Scaffold(
//   //     appBar: new AppBar(title: new Text('Employees')),
//   //     body: _buildList(context),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     EmployeeBloc productBloc = EmployeeBloc();
//     return EmployeeProvider(
//       // productBloc: productBloc,
//       child: CommonScaffold(
//         backGroundColor: Colors.grey.shade100,
//         actionFirstIcon: null,
//         appTitle: "Employee List",
//         showFAB: true,
//         scaffoldKey: _scaffoldState,
//         showDrawer: false,
//         centerDocked: true,
//         floatingIcon: Icons.add,
//         bodyData: _buildList(context),
//         // bodyData: _buildList(productBloc.productItems),
//         showBottomNav: true,
//       ),
//     );
//   }
// }
