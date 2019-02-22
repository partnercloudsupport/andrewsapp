import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskist/employees/dbService.dart';
import '../common/deviceApi.dart';
import '../model/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskist/model/current_user_model.dart';
import '../model/current_user_model.dart';
import 'package:taskist/model/current_user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskist/employees/dbService.dart';
import '../common/deviceApi.dart';
import '../model/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'package:taskist/model/current_user_model.dart';

class SiginForm extends StatefulWidget {
  const SiginForm({Key key}) : super(key: key);

  @override
  _SiginFormState createState() => _SiginFormState();
}

class _SiginFormState extends State<SiginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  FirebaseUser _firebaseUser;
  // TODO(abraham): refactor _formData to use a class.
  final Map<String, String> _formData = <String, String>{
    'email': '',
    'password': '',
    'employeeId': ''
  };

  @override
  Widget build(BuildContext context) {
    _firebaseUser = CurrentUserModel.of(context).firebaseUser;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Nickname is required';
              }
            },
            initialValue: 'asdf@asdf.com',
            onSaved: (String value) => _formData['email'] = value,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            // initialValue: _firebaseUser.displayName,asdfasdf
            initialValue: 'asdfasdf',
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password is required';
              }
            },
            onSaved: (String value) => _formData['password'] = value,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Siginin'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  String _initialNickname() {
    return '';
    // return _firebaseUser.displayName.split(' ').first;
  }

  // Future<void> _handleSignIn(BuildContext context) async {
  //   final CurrentEmployeeModel currentUserModel =
  //       CurrentEmployeeModel.of(context);
  //   await currentUserModel.signIn();
  //   if (currentUserModel.status == Status.Authenticated) {
  //     final Employee user = currentUserModel.employee;
  //     _showSnackBar(context, 'Welcome ${user.name}');
  //   }
  // }
  Future<void> _submit() async {
    DatabaseService serv = new DatabaseService();

    serv.getEmployee("employeeId");
    Employee employee = await serv.getEmployee('1444044');
    // Employee employee = Employee.of(context);

    Devices devs = new Devices();
    var snipeId = '2';
    var updatedDevice;
    var device = await devs.getDeviceFromSnipe();
    if (device['assigned_to'] == null) {
      var checkout =
          await devs.checkOutDevice(snipeId, device['id'].toString());
    } else {
      var checkin = await devs.checkInDevice(device['id'].toString());
      var cout = await devs.checkOutDevice(snipeId, device['id'].toString());
      print(cout);
    }
    if (device['assigned_to'] == null) {
      return false;
    }
    if (device['assigned_to']['id'] == int.parse(snipeId)) {
      updatedDevice = await devs.setDeviceOwner(employee.id);
    }
    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    // await _prefs.setString('deviceOwner', employee.id);
    // List<String> l = await _prefs.getStringList('deviceEmployeeList');
    // if (l != null) {
    //   l.add(employee.id);
    // } else {
    //   List<String> l = new List<String>();
    //   l.add(employee.id);
    // }
    // _handleSignIn(context);
    // await _prefs.setStringList('deviceEmployeeList', l);

    _formData['fullName'] = employee.name;
    _formData['photoUrl'] = employee.avatar.small;
    _formData['nickname'] = employee.name;
    return true;

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // _formData['email'] = _formData
      // _formData['password'] = 'asdfasdf';
      _formData['employeeId'] = '1444044';

      try {
        await CurrentUserModel.of(context).signIn(_formData);
      } catch (e) {
        _showSnackBar(context, 'Incorrect Login');
      }
    }
  }

  void _showSnackBar(BuildContext context, String msg) {
    final SnackBar snackBar = SnackBar(content: Text(msg));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
