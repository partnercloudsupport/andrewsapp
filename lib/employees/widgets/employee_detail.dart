import 'package:flutter/material.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:firestore_helpers/firestore_helpers.dart';

import 'employeeCard.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
import '../dbService.dart';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
//https://www.humanity.com/api/v2/employees?access_token=b490958e4890f89ae444334283874c487aab419f
//https://www.humanity.com/api/v2/timeclocks?access_token=e297a1ccc192d9b56dd1b290bfe7237fa13fa03e&employee=1956050&start_date=01/01/2019
// Future<List<Timesheet>> fetchTimesheets(http.Client client) async {
//   //https://www.humanity.com/api/v2/timeclocks?access_token=e297a1ccc192d9b56dd1b290bfe7237fa13fa03e&employee=1956050&start_date=01/01/2019
// var base = 'https://www.humanity.com/api/v2/timeclocks?access_token=';
// var token = 'e297a1ccc192d9b56dd1b290bfe7237fa13fa03e';
// var employee = '1956050';
// var start_date = '01/01/2019';
//   final response = await client.get(base+token+'&employee='+employee+'&start_date='+start_date);
//  print(response);
//   return compute(parseTimesheets, response.body);
// }
 
// List<Timesheet> parseTimesheets(String responseBody) {

//   // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//       final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//  print(parsed);
//   return parsed.map<Timesheet>((json) => Timesheet.fromJson(json)).toList();
// }


class Style {
  static final baseTextStyle = const TextStyle(
    fontFamily: 'Poppins'
  );
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
    fontSize: 14.0,
      fontWeight: FontWeight.w400
  );
  static final titleTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w600
  );
  static final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400
  );
}
class EmployeeDetailPage extends StatelessWidget {

  final Employee employee;
  final Device device;

  EmployeeDetailPage(this.employee, this.device);

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
    
      body: new Container(
        constraints: new BoxConstraints.expand(),
        // color: new Color(0xFF736AB7),
        color: new Color(0xFF736AB7),
        child: new Stack (
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
            // timeSheetList(employee.id),
            
             new Container(
              padding: new EdgeInsets.fromLTRB(32.0, 450.0, 0.0, 32.0),
     
      child: new     Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              new Text('TIME SHEETS',
                        style: Style.headerTextStyle,),
            Expanded(
              child: StreamBuilder<List<Timesheet>>(
                stream: dbService.getTimesheets(constraints: [new QueryConstraint(field: "empId", isEqualTo: employee.id)]),
                builder: (context, snapShot) {
                  if (!snapShot.hasData || snapShot.data.isEmpty) {
                    return Center(child: Text('No Data'));
                  } else {
                    return ListView.separated(
  separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
                        itemCount: snapShot.data.length,
                        itemBuilder: (context, index) {
                          var item = snapShot.data[index];
                          // return EmployeeCard(item);
                          return ListTile(
                              leading: const Icon(Icons.access_time),

                            title: Text(
                                '${item.prettyInDay}, ${item.prettyInTime}'),
                            subtitle: Text('${item.prettyOutDay}, ${item.prettyOutTime}'),
                          );
                        });
                  }
                },
              ),
            ),
      
            ]  )
         
        ),)
          ]    
      
      ),
     ),
    
     );
  }
// TabBarView(
//   children: [
//     Icon(Icons.directions_car),
//     Icon(Icons.directions_transit),
//     Icon(Icons.directions_bike),
//   ],
// );
  Container _getBackground () {
    return new Container(
            child: new Image.asset('assets/images/profile_header_background2.png',
              fit: BoxFit.cover,
              height: 300.0,
            ),
            constraints: new BoxConstraints.expand(height: 295.0),
          );
  }

  Container _getGradient() {
    return new Container(
            margin: new EdgeInsets.only(top: 190.0),
            height: 110.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: <Color>[
                  new Color(0x00736AB7),
                  new Color(0xFF736AB7)
                ],
                stops: [0.0, 0.9],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              ),
            ),
          );
  }

  Container _getContent() {

      String clockString;
     (employee.clockedIn == null)? employee.clockedIn = false: null;
    (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';
    String deviceString ='unavailable';
    if(device != null){
    (device.owner == employee.id)
        ? deviceString = 'CHECK IN'
        : deviceString = 'TAKE OWNERSHIP';}

    final _overviewTitle = "Overview".toUpperCase();
    return new Container(
            child: new ListView(
              padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
              children: <Widget>[
                new EmployeeCard(employee, device,
                  horizontal: false,
                ),
                new Container(
                  padding: new EdgeInsets.symmetric(horizontal: 32.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Row(
  children: <Widget>[
    Expanded(
      child:    _createClockButton(
            clockString,
            textColor: Colors.white,
            backgroundColor: (employee.clockedIn) ? Colors.red : Colors.green,
          ),
    ),
   Container(width: 20),
    
    Expanded(
      child:     _createCheckOutButton(
            deviceString,
            backgroundColor: Colors.blue.shade900,
          ),
    ),
  ],),
                   
                      new Text(_overviewTitle,
                        style: Style.headerTextStyle,),
                      new Separator(),
                      new Text(
                          employee.id, style: Style.commonTextStyle),
                             
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
            margin: new EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .padding
                    .top),
            child: new BackButton(color: Colors.green),
          );
  }

 Widget _createCheckOutButton(
    String text, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
  }) {
    return new ClipRRect(
      // borderRadius: new BorderRadius.circular(30.0),
      borderRadius: new BorderRadius.vertical(),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {
          // (employee.id == this.widget.device.assignedTo['id'])
          //     ? _checkInDevice()
          //     : _changeDeviceOwner();
        },
        child: new Text(text),
      ),
    );
  }

  Widget _createClockButton(
    String clockString, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
  }) {
    // if (employee.clockedIn && employee.currentDeviceId == widget.device.serial) {
    if (true) {
      return new ClipRRect(
        // borderRadius: new BorderRadius.circular(30.0),
        borderRadius: new BorderRadius.vertical(),
        child: new MaterialButton(
          minWidth: 140.0,
          color: backgroundColor,
          textColor: textColor,
          onPressed: () {
            // _punchClock();
          },
          child: new Text(clockString),
        ),
      );
    } else {
    }
  }

//   Widget timeSheetList() {
//  return  FutureBuilder<List<Timesheet>>(
//         future: fetchTimesheets(http.Client()),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
 
//           return snapshot.hasData
//               ? ListViewTimesheets(timesheets: snapshot.data)
//               : Center(child: CircularProgressIndicator());
//         },
      
//     );
//   }

  final DatabaseService dbService = new DatabaseService();
  // // getEvents(constraints: [new QueryConstraint(field: "creatorId", isEqualTo: _currentUser.id)]);

  // Widget timeSheetList(employeeId) {
  //  StreamBuilder<List<Timesheet>>(
  //               stream: dbService.getTimesheets(constraints: [new QueryConstraint(field: "empId", isEqualTo: employeeId)]),
  //               builder: (context, snapShot) {
  //                 if (!snapShot.hasData || snapShot.data.isEmpty) {
  //                   return Center(child: Text('No Data'));
  //                 } else {
  //                   return ListView.builder(
  //                       itemCount: snapShot.data.length,
  //                       itemBuilder: (context, index) {
  //                         var item = snapShot.data[index];
  //                         // return TimesheetCard(item);
  //                         return ListTile(
  //                           title: Text(
  //                               '${item.startTimestamp}   (end:${item.endTimestamp})'),
  //                           subtitle: Text('distance: ${item.id}'),
  //                         );
  //                       });
  //                 }
  //               });
      
  // }
}