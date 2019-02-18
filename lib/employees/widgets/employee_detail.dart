import 'package:flutter/material.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/employees/widgets/employee_footer.dart';
import 'package:taskist/employees/widgets/employeeButtonRow.dart';
import 'package:taskist/employees/widgets/employee_detail_headerFB.dart';
import 'package:taskist/employees/widgets/employeeDetailBodyFB.dart';

class EmployeeDetailsPage extends StatefulWidget {
  EmployeeDetailsPage({
    this.employee,
  });

  final Employee employee;
  // final Object avatarTag;

  @override
  _EmployeeDetailsPageState createState() => new _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF9E9E9E),
          const Color(0xFFFAFAFA),
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          // decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new EmployeeDetailHeaderFB(
                widget.employee,
                // avatarTag: widget.avatarTag,
              ),
              EmployeeButtonRow(),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new EmployeeDetailBodyFB(widget.employee),
              ),
              new EmployeeDetailFooter(widget.employee),
            ],
          ),
        ),
      ),
    );
  }
}
// class Style {
//   static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
//   static final smallTextStyle = commonTextStyle.copyWith(
//     fontSize: 9.0,
//   );
//   static final commonTextStyle = baseTextStyle.copyWith(
//       color: const Color(0xffb6b2df),
//       fontSize: 14.0,
//       fontWeight: FontWeight.w400);
//   static final titleTextStyle = baseTextStyle.copyWith(
//       color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.w600);
//   static final headerTextStyle = baseTextStyle.copyWith(
//       color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.w400);
// }

// class EmployeeDetail extends StatefulWidget {
//   // final Device device;
//   final Employee employee;

//   EmployeeDetail({Key key, this.employee}) : super(key: key);

//   @override
//   _EmployeeDetailState createState() => new _EmployeeDetailState();
// }

// class _EmployeeDetailState extends State<EmployeeDetail> {
//   Employee employee;
//   Device device;
//   int _clockButtonState = 0;
//   bool _clockedIn;
//   @override
//   void initState() {
//     super.initState();
//     _clockedIn = widget.employee.clockedIn;

//     this.employee = widget.employee;
//     // this.device = widget.device;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body:
//       new Container(
//         constraints: new BoxConstraints.loose(),
//         // color: Colors.green.shade900,
//         child: new Stack(children: <Widget>[
//           _getBackground(),
//           _getGradient(),
//           _getContent(),
//           _getToolbar(context),

//           // new Container(
//           //   padding: new EdgeInsets.fromLTRB(32.0, 600.0, 0.0, 32.0),
//           //   child: new Center(
//           //       child: Column(
//           //           mainAxisAlignment: MainAxisAlignment.start,
//           //           crossAxisAlignment: CrossAxisAlignment.stretch,
//           //           children: <Widget>[
//           //         new Text(
//           //           'TIME SHEETS',
//           //           style: Style.headerTextStyle,
//           //         ),
//           //         Expanded(
//           //           child: StreamBuilder<List<Timesheet>>(
//           //             stream: dbService.getTimesheets(constraints: [
//           //               new QueryConstraint(
//           //                   field: "empId", isEqualTo: employee.id)
//           //             ]),
//           //             builder: (context, snapShot) {
//           //               if (!snapShot.hasData || snapShot.data.isEmpty) {
//           //                 return Center(child: Text('No Data'));
//           //               } else {
//           //                 return ListView.separated(
//           //                     separatorBuilder: (context, index) => Divider(
//           //                           color: Colors.black,
//           //                         ),
//           //                     itemCount: snapShot.data.length,
//           //                     itemBuilder: (context, index) {
//           //                       var item = snapShot.data[index];
//           //                       // return EmployeeCard(item);
//           //                       return ListTile(
//           //                         leading: const Icon(Icons.access_time),
//           //                         title: Text(
//           //                             '${item.prettyInDay}, ${item.prettyInTime}'),
//           //                         subtitle: Text(
//           //                             '${item.prettyOutDay}, ${item.prettyOutTime}'),
//           //                       );
//           //                     });
//           //               }
//           //             },
//           //           ),
//           //         ),
//           //       ])),
//           // )
//         ]),
//       ),
//     );
//   }

// // TabBarView(
// //   children: [
// //     Icon(Icons.directions_car),
// //     Icon(Icons.directions_transit),
// //     Icon(Icons.directions_bike),
// //   ],
// // );
//   Container _getBackground() {
//     return new Container(
//       child: Opacity(
//         opacity: .5,
//         child: new Image.asset(
//           'assets/images/profile_header_background2.png',
//           fit: BoxFit.cover,
//           height: 300.0,
//         ),
//       ),
//       constraints: new BoxConstraints.expand(height: 300.0),
//     );
//   }

//   Container _getGradient() {
//     return new Container(
//       margin: new EdgeInsets.only(top: 190.0),
//       height: 110.0,
//       // decoration: new BoxDecoration(
//       //   gradient: new LinearGradient(
//       //     // colors: UIData.kitGradientsGreen,
//       //     colors: <Color>[Colors.green.shade100, Colors.green.shade900],
//       //     stops: [0.0, 0.9],
//       //     begin: const FractionalOffset(0.0, 0.0),
//       //     end: const FractionalOffset(0.0, 1.0),
//       //   ),
//       // ),
//     );
//   }

//   Container _getContent() {
//     String clockString;
//     (employee.clockedIn == null) ? employee.clockedIn = false : null;
//     (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
//     String deviceString = 'unavailable';
//     if (device != null) {
//       (device.owner == employee.id)
//           ? deviceString = 'CHECK IN'
//           : deviceString = 'CHECKOUT DEVICE';
//     }

//     final _overviewTitle = "Overview".toUpperCase();
//     return new Container(
//       child: new ListView(
//         padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
//         children: <Widget>[
//           new EmployeeCard(
//             employee,
//             device,
//             horizontal: false,
//           ),
//           new Container(
//             padding: new EdgeInsets.symmetric(horizontal: 32.0),
//             child: new Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: _createClockButton(
//                         clockString,
//                         textColor: Colors.green.shade900,
//                         backgroundColor:
//                             (employee.clockedIn) ? Colors.red : Colors.green,
//                       ),
//                     ),
//                     Container(width: 20),
//                     Expanded(
//                       child: _createCheckOutButton(
//                         deviceString,
//                         backgroundColor: Colors.blue.shade900,
//                       ),
//                     ),
//                   ],
//                 ),
//                 new Container(
//                   padding: new EdgeInsets.symmetric(vertical: 12.0),
//                 ),
//                 new Text(
//                   'Employee Details',
//                   style: Style.headerTextStyle,
//                 ),
//                 new Separator(),
//                 _contentTable(),
//                 EmployeeDetailFooter(employee),

//                 // (employee.address != null && employee.address != "")
//                 //     ? new Text(employee.getPretty(),
//                 //         style: Style.commonTextStyle)
//                 //     : new Text('Address: N/A', style: Style.commonTextStyle)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container _getToolbar(BuildContext context) {
//     return new Container(
//       margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: new BackButton(color: Colors.green),
//     );
//   }

//   Widget _createCheckOutButton(
//     String text, {
//     Color backgroundColor = Colors.transparent,
//     Color textColor = Colors.green,
//   }) {
//     return new ClipRRect(
//       // borderRadius: new BorderRadius.circular(30.0),
//       borderRadius: new BorderRadius.vertical(),
//       child: new MaterialButton(
//         minWidth: 140.0,
//         color: backgroundColor,
//         textColor: textColor,
//         onPressed: () {
//           // (employee.id == this.widget.device.assignedTo['id'])
//           //     ? _checkInDevice()
//           //     : _changeDeviceOwner();
//         },
//         child: new Text(text),
//       ),
//     );
//   }

//   _clockEmployee() async {
//     String clockString;
//     (employee.clockedIn == null) ? employee.clockedIn = false : null;
//     (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
//     setState(() {
//       _clockButtonState = 1;
//     });
//     // final ts = createNewTimesheet(employee, device);
//     await dbService.punchClock(employee, device);
//     setState(() {
//       _clockButtonState = 0;
//     });

//     setState(() {
//       _clockedIn = !_clockedIn;
//     });
//     clockString;
//     employee.clockedIn = !employee.clockedIn;
//     (employee.clockedIn == null) ? employee.clockedIn = false : null;
//     (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';

//     _createClockButton(clockString);
//   }

//   // void animateClockButton() {
//   //   setState(() {
//   //     _clockButtonState = 1;
//   //   });

//   //   Timer(Duration(milliseconds: 3300), () {
//   //     setState(() {
//   //       _clockButtonState = 2;
//   //     });
//   //   });
//   // }

//   Widget _createClockButton(
//     String clockString, {
//     Color backgroundColor = Colors.transparent,
//     Color textColor = Colors.green,
//   }) {
//     // if (employee.clockedIn && employee.currentDeviceId == widget.device.serial) {
//     if (_clockButtonState == 0) {
//       return new ClipRRect(
//         // borderRadius: new BorderRadius.circular(30.0),
//         borderRadius: new BorderRadius.vertical(),
//         child: new MaterialButton(
//           minWidth: 140.0,
//           color: backgroundColor,
//           textColor: textColor,
//           onPressed: () {
//             // _punchClock();
//             _clockEmployee();
//             // (employee.clockedIn != null)
//             //     ? (employee.clockedIn)
//             //         ? _clockoutEmployee()
//             //         : _clockInEmployee()
//             //     : _clockInEmployee();
//           },
//           child: new Text(clockString),
//         ),
//       );
//     } else if (_clockButtonState == 1) {
//       return CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//       );
//     } else {
//       return Icon(Icons.check, color: Colors.green);
//     }
//   }

//   final DatabaseService dbService = new DatabaseService();

//   Widget _contentTable() {
//     return Table(
//       // border: TableBorder.all(width: 2.0, color: Colors.green),
//       defaultColumnWidth: FixedColumnWidth(280),
//       defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
// // Full Name:	Ash Downing
// // ID:	0001
// // Username:	andrewsgroup
// // Mobile:	903-530-1197 Un-confirmed
// // Home:	903-530-9999
// // Email:	ash@andrewscarpetcleaning.com
// // Birthday:	March 6

//       children: [
//         TableRow(children: [
//           TableCell(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Text('Full Name:',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//                 new Text(employee.name,
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ],
//             ),
//           ),
//         ]),
//         TableRow(children: [
//           TableCell(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Text('Mobile:',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//                 new Text(employee.cell_phone,
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ],
//             ),
//           ),
//         ]),
//         TableRow(children: [
//           TableCell(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Text('ID:',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//                 new Text(employee.id,
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ],
//             ),
//           ),
//         ]),
//         TableRow(children: [
//           TableCell(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Text('Email:',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//                 new Text((employee.email != null) ? employee.email : 'N/A',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ],
//             ),
//           ),
//         ]),
//         TableRow(children: [
//           TableCell(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Text('Birthday:',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//                 new Text(employee.getPrettyBirthDay(),
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ],
//             ),
//           ),
//         ]),
//       ],
//     );
//   }
// }
