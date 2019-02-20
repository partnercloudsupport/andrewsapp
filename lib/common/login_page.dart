import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskist/common/assetsApi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../root_page.dart';
import '../common/deviceApi.dart';
import '../model/device.dart';
import '../dashboard/dashboard.dart';
import '../model/employee.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// import '../forms/register_form.dart';

class LoginPage extends StatefulWidget {
  Function callback;

  LoginPage(this.callback);
  // const LoginPage({Key key, this.callback)}) : super(key: key);
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            // _getToolbar(context),
            Container(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Checkout',
                                style: new TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Device',
                                style: new TextStyle(
                                    fontSize: 28.0, color: Colors.grey),
                              )
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text("Please scan your id badge"),
                )
              ]),
            )
          ],
        ),
        floatingActionButton: _siFab(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  _siFab(context) {
    return Padding(
        padding: EdgeInsets.all(86.0),
        child: FloatingActionButton.extended(
            icon: Icon(FontAwesomeIcons.barcode),
            onPressed: () async {
              scan();
            },
            label: new Text('Scan')));
  }

  Widget _wrong() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Scan failure",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  scan() async {
    // var _futureString = await BarcodeScanner.scan();
    // print(_futureString);
    // _futureString = '{"asdf":"asdf"}';

    // final _result = awa?it jsonDecode(_futureString);

    // Future<Null> login(Employee employee) async {
    //   SharedPreferences prefs;
    //   prefs = await SharedPreferences.getInstance();
    //   prefs.setString("username", employee.name);
    //   prefs.setString("userid", employee.id);
    //   prefs.setString("useremail", employee.email);
    //   prefs.setString("userphotourl", employee.avatar.small);
    // }

    // Employee employee =
    //     await customLogin("asdf@asdf.com", "asdfasdf", "X5rXzRsiugC6G22D4BcL");
    // await login(employee);

    // (employee.avatar != null)
    //     ? this.widget.callback(employee, new Dashboard())
    //     : _wrong();
    // ? Navigator.of(context).push(new PageRouteBuilder(
    //     pageBuilder: (_, __, ___) => new RootPage(
    //           currentEmployee: employee,
    //         )))
    // ? Navigator.pop(context, employee)
    // : _wrong();

    // return await widget.auth.signIn(_result.email, _result.password);
    Devices devs = new Devices();
    var device = await devs.getDeviceFromSnipeByAndroidId('d00be0f5253a5ea6');
    var d = await devs.checkInDevice(device['id'].toString());
    print(d);
    // (device['assigned_to']['username'] !== null)?;
    print(device['id']);

    // var d = devs.checkOutDevice('2', device['id'].toString());
    // print(d);
  }
}
