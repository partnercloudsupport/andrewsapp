import 'package:flutter/material.dart';
import 'uidata.dart';

class MyAboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      // applicationIcon: FlutterLogo(
      //   colors: Colors.yellow,
      // ),
    applicationIcon: Image.asset('assets/icon.png', scale: 3,),
      icon:  Image.asset('assets/icon.png', scale: 6,),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed by Ash Downing",
        ),
        Text(
          "for Andrews Company",
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: "0.0.87",
      applicationLegalese: "Apache License 2.0",
    );
  }
}
