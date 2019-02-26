import 'package:flutter/material.dart';
import './diagonal_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taskist/model/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms/sms.dart';
import 'package:call_number/call_number.dart';
import 'package:sms/contact.dart';

FirebaseAuth auth = FirebaseAuth.instance;
SmsQuery query = new SmsQuery();

class EmployeeDetailHeaderFB extends StatelessWidget {
  // static const BACKGROUND_IMAGE = 'assets/images/login-screen-background.png';
  static const BACKGROUND_IMAGE = 'assets/images/andrewsbw.png';
// /home/ash/andrews_taskist/assets/login-screen-background.png
  EmployeeDetailHeaderFB(this.employee);

  final Employee employee;

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // return new Image.asset(
    //   BACKGROUND_IMAGE,
    //   width: screenWidth,
    //   colorBlendMode: BlendMode.darken,
    //   height: 280.0,
    //   fit: BoxFit.cover,
    // );

    return new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 150.0,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB8999f4),
    );
  }

  void _initSMS() async {
    UserProfileProvider provider = new UserProfileProvider();
    UserProfile profile = await provider.getUserProfile();
    print(profile.fullName);

    SmsSender sender = new SmsSender();
    String address = employee.cell_phone;
    SmsMessage message = new SmsMessage(address, 'Hello flutter!');
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }

  _initCall() async {
    await new CallNumber().callNumber('+91' + employee.cell_phone);
  }

  Widget _buildAvatar(deviceSize) => Container(
      height: deviceSize.height * 0.25,
      child: FittedBox(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(width: 20),
                              IconButton(
                                icon: Icon(Icons.chat),
                                color: Colors.white,
                                iconSize: 16,
                                onPressed: () {
                                  _initSMS();
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(40.0)),
                                  border: new Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(employee.avatarSmall),

                                  // "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
                                  foregroundColor: Colors.white,
                                  radius: 32.0,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.call),
                                color: Colors.white,
                                iconSize: 16,
                                onPressed: () {
                                  _initCall();
                                },
                              ),
                              Container(width: 20),
                            ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          employee.firstname,
                          style: new TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          employee.lastname,
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.grey.shade500),
                        )
                      ],
                    ),
                    // ProfileTile(
                    //   title: employee['name'],
                    //   subtitle: '',
                    // ),
                  ]))));

  // Widget _buildFollowerInfo(TextTheme textTheme) {
  //   var followerStyle =
  //       textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

  //   return new Padding(
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: new Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         // new Text('90 Following', style: followerStyle),
  //         // new Text(
  //         //   ' | ',
  //         //   style: followerStyle.copyWith(
  //         //       fontSize: 20.0, fontWeight: FontWeight.normal),
  //         // ),
  //         // new Text('100 Followers', style: followerStyle),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildActionButtons(ThemeData theme) {
  //   String clockString;

  //   (employee.clockedIn) ? clockString = 'CLOCK OUT' : clockString = 'CLOCK IN';

  //   return new Padding(
  //     padding: const EdgeInsets.only(
  //       top: 2.0,
  //       left: 16.0,
  //       right: 16.0,
  //     ),
  //     child: new Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _createClockButton(
  //           clockString,
  //           textColor: Colors.white,
  //           backgroundColor: Colors.green,
  //         ),
  //         _createClockButton(
  //           "UNAVAIL",
  //           backgroundColor: theme.accentColor,
  //         ),
  //         // new DecoratedBox(
  //         //   decoration: new BoxDecoration(
  //         //     border: new Border.all(color: Colors.white30),
  //         //     borderRadius: new BorderRadius.circular(30.0),
  //         //   ),
  //         //   child: _createPillButton(
  //         //     'FOLLOW',
  //         //     textColor: Colors.white70,
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _createCheckOutButton(
  //   String text, {
  //   Color backgroundColor = Colors.transparent,
  //   Color textColor = Colors.white70,
  // }) {
  //   return new ClipRRect(
  //     // borderRadius: new BorderRadius.circular(30.0),
  //     borderRadius: new BorderRadius.vertical(),
  //     child: new MaterialButton(
  //       minWidth: 140.0,
  //       color: backgroundColor,
  //       textColor: textColor,
  //       onPressed: () {},
  //       child: new Text(text),
  //     ),
  //   );
  // }

  // void _punchClock() async {
  //   // print(currentStatus);
  //   http.Response _clockResponse;

  //   if (employee.clockedIn) {
  //     _clockResponse = await http.put(
  //         'https://www.humanity.com/api/v2/employees/${employee.id}/clockout?access_token=b490958e4890f89ae444334283874c487aab419f');
  //   } else {
  //     _clockResponse = await http.post(
  //         'https://www.humanity.com/api/v2/employees/${employee.id}/clockin?access_token=b490958e4890f89ae444334283874c487aab419f');
  //   }
  //   // print(_clockResponse.body);
  //   var decodedResponse =
  //       json.decode(_clockResponse.body).cast<String, dynamic>();

  //   print(decodedResponse['data']['out_timestamp']);

  //   DocumentReference employeeRef =
  //       Firestore.instance.document('employees/' + employee.id);

  //   if (decodedResponse['data']['out_timestamp'] == '0') {
  //     // employee['clockedIn'] = false;
  //     Firestore.instance.runTransaction((Transaction tx) async {
  //       DocumentSnapshot postSnapshot = await tx.get(employeeRef);
  //       if (postSnapshot.exists) {
  //         await tx.update(employeeRef, <String, dynamic>{'clockedIn': false});
  //       }
  //     });
  //   } else {
  //     Firestore.instance.runTransaction((Transaction tx) async {
  //       DocumentSnapshot postSnapshot = await tx.get(employeeRef);
  //       if (postSnapshot.exists) {
  //         await tx.update(employeeRef, <String, dynamic>{'clockedIn': true});
  //       }
  //     });
  //     // this.currentStatus = new CurrentStatus(
  //     //     is_on_break: 'false',
  //     //     clockin_time: decodedResponse['data']['in_time']['time'],
  //     //     clockin_date: decodedResponse['data']['in_time']['day']);
  //   }
  //   // var status = decodedResponse['data']
  //   //     .cast<Map<String, dynamic>>()
  //   //     // .map((obj) => Object.fromMap(obj))
  //   //     .toList()
  //   //     .cast<Object>();
  //   // print(status);
  //   // var data = decodedJsonEmployees['data']
  //   //     .cast<Map<String, dynamic>>()
  //   //     // .map((obj) => Object.fromMap(obj))
  //   //     .toList()
  //   //     .cast<Object>();

  //   // print(data);
  // }

  // Widget _createClockButton(
  //   String text, {
  //   Color backgroundColor = Colors.transparent,
  //   Color textColor = Colors.white70,
  // }) {
  //   return new ClipRRect(
  //     // borderRadius: new BorderRadius.circular(30.0),
  //     borderRadius: new BorderRadius.vertical(),
  //     child: new MaterialButton(
  //       minWidth: 140.0,
  //       color: backgroundColor,
  //       textColor: textColor,
  //       onPressed: () {
  //         _punchClock();
  //       },
  //       child: new Text(text),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var deviceSize;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    deviceSize = MediaQuery.of(context).size;
    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.1,
          child: new Column(
            children: <Widget>[
              _buildAvatar(deviceSize),
              // _buildFollowerInfo(textTheme),
              // _buildActionButtons(theme),
            ],
          ),
        ),
        new Positioned(
          top: 24.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}
