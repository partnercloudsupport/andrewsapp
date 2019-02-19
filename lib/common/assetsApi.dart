import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../model/device.dart';
import '../model/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

final DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

Future<Device> fetchPost() async {
  final response = await http.get(
    'https://jsonplaceholder.typicode.com/posts/1',
    headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  final responseJson = json.decode(response.body);
  return compute(parseDevice, response.body);
}

Device parseDevice(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  Map resopnse = new Map<String, dynamic>();

  return parsed.map<Device>((json) => fromMap(json)).toList();
}

Future<Device> getDevice() async {
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  DocumentSnapshot result = await Firestore.instance
      .collection('devices')
      .document(androidInfo.androidId)
      .get();
  Device d = fromMap(result.data);
  print(d.androidId);
  return d;
}

BaseOptions options = new BaseOptions(
    baseUrl: "http://47.219.174.153:8085/api/v1",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY3ZTRkYjEzMjU4NzUzM2QxYjZjYjA3Y2U5OGJmNzZjMjhhMzM2Yjk0YzBmMzg0MzRiMTUxOTJlMDA2MDBjNDQ5MjQ3YzU0MjRmMmNmZmM0In0.eyJhdWQiOiIzIiwianRpIjoiNjdlNGRiMTMyNTg3NTMzZDFiNmNiMDdjZTk4YmY3NmMyOGEzMzZiOTRjMGYzODQzNGIxNTE5MmUwMDYwMGM0NDkyNDdjNTQyNGYyY2ZmYzQiLCJpYXQiOjE1NDk4NTM5MDgsIm5iZiI6MTU0OTg1MzkwOCwiZXhwIjoxNTgxMzg5OTA4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.dml5K0kWint7BMjwlFXUEuL0bnGMFUuBGty06kHUgA_Wvq7P9yaITJuFcgSxsDDkg7c9npXUcTMiQBMObPHCPB9EOZD39jsOgCbGoKeZuH5VqbEGK8xP2fcpY4lDyozr3ldTsgctRNrjIlRLP9Y-fqN5jDez_wptymWoYVfNmuR_YV1tiOlTFYj2qbc7UEcbJj7VzPxSJGGFESGuOdXyhONTcR91lw08Judw9cMSkvHAmWueFoCFjM3lM95b07ojlkyVeVRzDbDkag-VPAYd6sIelpOcJamn84wk98id0x2ht422yTPPrCSa6Fpxu132gWONqg-JaazQWfVFr5_ClFftQnR6rXrJS60WSyGzX8_cvpPnX5Bru4vgLa0SD7e7k_azYP3dEjmZF2dkOt7ayyF4iRsq7jlfspczkkrD4y1pfGxKXfpeS2KKwqz74QUKRK98jXClHPCSGeBtxuKemxtUWilW9nt405fyZMFAUHANGTFg86XdIXm_ydpLDpjtp4x-hwBUJwUYJctHObjpd4r1tmyFALTWD47Y5DAz353VH-N3fmixU1wMCHOAR26EHftLTmSFL6hlGBQuORVpP_vmNvEXGJ5Toyrvtf3P4tsrRhN5AVrGc7o7Ea6IfhNvwvZHa7C3Pdw2fqdX5SrHVQWq0ei8LW3tR0A2BUqcCIk',
    });
Dio dio = new Dio(options);

class Assets {
  Future<Device> getHardwareByAndroidId(androidId) async {
    var resp = await dio.get('/hardware/byserial/' + androidId);
    Map data = resp.data['rows'][0];
    Device _thisDevice = fromMap(data);
    print(_thisDevice.androidId);
    return _thisDevice;
  }

  Future<Device> fetchPost() async {
    final response = await http.get(
      'https://jsonplaceholder.typicode.com/posts/1',
      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
    );
    final responseJson = json.decode(response.body);
    return compute(parseDevice, response.body);
  }
}

Future<Employee> customLogin(email, password, userId) async {
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  // final response = await http.post("https://us-central1-andrewsgrowth-app.cloudfunctions.net  ", body:{"email":email,"password":password, "deviceId": androidInfo.androidId});
  //http://localhost:5000/andrewsgrowth-app/us-central1/auth
  //https://ashdevtools.com/auth
  // http://localhost:5000/andrewsgrowth-app/us-central1/sign_in

  final response = await http.post(
      "https://api.ashdevtools.com/andrewsgrowth-app/us-central1/customAuth",
      body: {
        "userId": userId,
        "snipeId": "2",
        "email": email,
        "password": password,
        // "deviceId": androidInfo.androidId,
        "deviceId": androidInfo.androidId,
      });
  print(response.body);
  // var res = json.decode(response.body);
  final int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400) {
    throw new Exception("Error while fetching data");
  }

  FirebaseUser user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  DocumentSnapshot result =
      await Firestore.instance.collection('employees').document(userId).get();
  var employee = EmployeeSerializer().fromMap(result.data);

  return employee;
}
