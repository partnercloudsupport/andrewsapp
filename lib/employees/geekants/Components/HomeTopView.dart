import 'package:flutter/material.dart';
import 'MonthView.dart';
import 'Profile_Notification.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import './profile_buttonRow.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageBackground extends StatelessWidget {
  final Employee employee;
  final Device device;
  final DecorationImage backgroundImage;
  Function launchUrl;

  final DecorationImage profileImage;
  final VoidCallback selectbackward;
  final VoidCallback selectforward;
  final String month;
  final Animation<double> containerGrowAnimation;
  ImageBackground(
      {this.backgroundImage,
      @required this.employee,
      @required this.device,
      this.containerGrowAnimation,
      this.profileImage,
      this.launchUrl,
      this.month,
      this.selectbackward,
      this.selectforward});
// tel:<phone number>, e.g. tel:+1 555 010 999

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;
    return (new Container(
        width: screenSize.width,
        height: screenSize.height / 2.5,
        decoration: new BoxDecoration(image: backgroundImage),
        child: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(110, 101, 103, .9),
              const Color.fromRGBO(51, 51, 63, .9),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
          )),
          child: isLandscape
              ? new ListView(
                  children: <Widget>[
                    new Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text(
                          "Good Morning!",
                          style: new TextStyle(
                              fontSize: 30.0,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        new ProfileNotification(
                          containerGrowAnimation: containerGrowAnimation,
                          profileImage: new DecorationImage(
                              image: NetworkImage(this.employee.avatar.large)),
                        ),
                        // new MonthView(
                        //   month: month,
                        //   selectbackward: selectbackward,
                        //   selectforward: selectforward,
                        // )
                      ],
                    )
                  ],
                )
              : new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(
                      "Good Morning, " + employee.firstname + '!',
                      style: new TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new IconButton(
                              onPressed: () =>
                                  print(canLaunch("sms:9035301197")),
                              icon: Icon(
                                Icons.phone,
                                size: 44,
                                color: Colors.white,
                              )),
                          Container(width: 20),
                          new ProfileNotification(
                            containerGrowAnimation: containerGrowAnimation,
                            profileImage: new DecorationImage(
                                image:
                                    NetworkImage(this.employee.avatar.large)),
                          ),
                          Container(width: 20),
                          new IconButton(
                              onPressed: () => print('asdf'),
                              icon: Icon(
                                Icons.sms,
                                size: 44,
                                color: Colors.white,
                              )),
                        ]),
                    ProfileButtonRow(employee: employee, device: device),
                    // new MonthView(
                    //   month: month,
                    //   selectbackward: selectbackward,
                    //   selectforward: selectforward,
                    // )
                  ],
                ),
        )));
  }
}
