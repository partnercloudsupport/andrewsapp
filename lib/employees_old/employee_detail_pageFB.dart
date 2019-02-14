// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:taskist/employees/employee_detail_headerFB.dart';
// import 'package:taskist/employees/employee_button_rowFB.dart';
// import 'package:taskist/employees/employee_detail_bodyFB.dart';
// import 'package:taskist/model/employee.dart';
// import 'package:taskist/employees/device.dart';
// import 'package:taskist/employees/employee_detail_footer.dart';

// class EmployeeDetailsPageFB extends StatefulWidget {
//   EmployeeDetailsPageFB(this.employee, this.device);
//   final Employee employee;
//   final Device device;

//   @override
//   _EmployeeDetailsPageState createState() => new _EmployeeDetailsPageState();
// }

// class _EmployeeDetailsPageState extends State<EmployeeDetailsPageFB> {
//   @override
//   Widget build(BuildContext context) {
//     var linearGradient = const BoxDecoration(
//       gradient: const LinearGradient(
//         begin: FractionalOffset.centerRight,
//         end: FractionalOffset.bottomLeft,
//         colors: <Color>[
//           const Color(0xFF413070),
//           const Color(0xFF2B264A),
//         ],
//       ),
//     );

//     return new Scaffold(
//       body: new SingleChildScrollView(
//         child: new Container(
//           decoration: linearGradient,
//           child: new Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               new EmployeeDetailHeaderFB(widget.employee),
//               new EmployeeButtonRowFB(widget.employee, widget.device),
//               new Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: new EmployeeDetailBodyFB(widget.employee),
//               ),
//               new EmployeeShowcase(widget.employee),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
