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
BaseOptions options = new BaseOptions(
    baseUrl: "http://47.219.174.153:8085/api/v1",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImNjMmU5OTQxOTk5ZjFkYjQ1MzA5ZmVlOTAyNDU2N2Y1NTY5MTk0ZDM1NGU2MDUzZTljNDA2ZjM0MzlkODc0YWFjMTdjYmZlMmZkM2FkNjFjIn0.eyJhdWQiOiIzIiwianRpIjoiY2MyZTk5NDE5OTlmMWRiNDUzMDlmZWU5MDI0NTY3ZjU1NjkxOTRkMzU0ZTYwNTNlOWM0MDZmMzQzOWQ4NzRhYWMxN2NiZmUyZmQzYWQ2MWMiLCJpYXQiOjE1NTEwNTM2MzgsIm5iZiI6MTU1MTA1MzYzOCwiZXhwIjoxNTgyNTg5NjM4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.w0qiAvMMalP-pJ7oQYxHvihh9AXzgtQSBZnsDYvl2gZAKU3k4g2ti-LWQpYPvgv0Cg0NZhKX4BXuAavI9ufdY4-2oJfk0F-h7JUBDiKq89euVYHmlxLRi_UDT18YSqLhB2jfl5anyn-VsFOzmIKu4RCgYIiar3v6Dd3RA4QIr3Bsy3WdH9SH1-_4FYwNydWB7ljyzKrxR4sJoll_HwcSISNyoaI8eHs9x18QUUChvTU1NeCg3I0o7FPr_DCqKewgFEPo9iUGVnOxQYH1xiRTQMFJDn_67KbdXs6ytB5RZRZPUgWsT_QjEwllZffriYvFdt4JcFKkK0I0-XMu9EXKSXrkif1zPYn0hKRFGif1bRPbyZtE3GKBiLLpv1Y4aSDRfVqa0-yVjxJD2bU1rEo_BqyOXp4GeK8MClytILnD9_UucSZe3-ewaMZZWWgMvOTzlApuDlvEDBAezSf2wEWsfp9STlASIBDtNLybH-SvbubCsGWhCQ2Pqivw3AeLc1EZoWPSLYDPu0Fc2akQKTC68NswvygcIWd5GW_DtNCDuPkv8GIhA2ElL42z0cpyNnERnAfa6jL4djnaTsCyAQO5QzWB-szUiYkkjGomx1U3dhaa4cY6Lx6lQ1QFBDi0ZWCQJCh2Ku3W9sGjTuR7uXU5G4qEHm1l-FLP2igxhA_SDjQ'
    });

// Dio snipeit = new Dio(options);
Dio snipeit = new Dio(options);

Device parseDevice(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  // Map resopnse = new Map<String, dynamic>();

  return parsed.map<Device>((json) => fromMap(json)).toList();
}

class Devices {
  Future<Map> checkOutDevice(
    String snipeId,
    String deviceId,
  ) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var resp;
    try {
      resp = await snipeit.post('/hardware/' + deviceId + '/checkout',
          data: {'assigned_user': snipeId, 'checkout_to_type': 'user'});
    } catch (e) {
      print(e);
    }
    // var jresp = json.decode(resp.data);
    // print(resp.data['status']);
    return resp.data;
  }

  Future<String> checkInDevice(
    String deviceId,
  ) async {
    var resp = await snipeit.post('/hardware/' + deviceId + '/checkin');
    // var jresp = json.decode(resp.data);
    return resp.data['status'];
  }

  Future<Device> getDeviceFromFirebaseByAndroidId() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    DocumentSnapshot result = await Firestore.instance
        .collection('devices')
        .document(androidInfo.androidId)
        .get();
    Device d = fromMap(result.data);
    print(d.androidId);

    return d;
  }

  Future<Map> getDeviceFromSnipe() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    BaseOptions x = new BaseOptions(
        baseUrl: "http://47.219.174.153:8085/api/v1",
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImNjMmU5OTQxOTk5ZjFkYjQ1MzA5ZmVlOTAyNDU2N2Y1NTY5MTk0ZDM1NGU2MDUzZTljNDA2ZjM0MzlkODc0YWFjMTdjYmZlMmZkM2FkNjFjIn0.eyJhdWQiOiIzIiwianRpIjoiY2MyZTk5NDE5OTlmMWRiNDUzMDlmZWU5MDI0NTY3ZjU1NjkxOTRkMzU0ZTYwNTNlOWM0MDZmMzQzOWQ4NzRhYWMxN2NiZmUyZmQzYWQ2MWMiLCJpYXQiOjE1NTEwNTM2MzgsIm5iZiI6MTU1MTA1MzYzOCwiZXhwIjoxNTgyNTg5NjM4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.w0qiAvMMalP-pJ7oQYxHvihh9AXzgtQSBZnsDYvl2gZAKU3k4g2ti-LWQpYPvgv0Cg0NZhKX4BXuAavI9ufdY4-2oJfk0F-h7JUBDiKq89euVYHmlxLRi_UDT18YSqLhB2jfl5anyn-VsFOzmIKu4RCgYIiar3v6Dd3RA4QIr3Bsy3WdH9SH1-_4FYwNydWB7ljyzKrxR4sJoll_HwcSISNyoaI8eHs9x18QUUChvTU1NeCg3I0o7FPr_DCqKewgFEPo9iUGVnOxQYH1xiRTQMFJDn_67KbdXs6ytB5RZRZPUgWsT_QjEwllZffriYvFdt4JcFKkK0I0-XMu9EXKSXrkif1zPYn0hKRFGif1bRPbyZtE3GKBiLLpv1Y4aSDRfVqa0-yVjxJD2bU1rEo_BqyOXp4GeK8MClytILnD9_UucSZe3-ewaMZZWWgMvOTzlApuDlvEDBAezSf2wEWsfp9STlASIBDtNLybH-SvbubCsGWhCQ2Pqivw3AeLc1EZoWPSLYDPu0Fc2akQKTC68NswvygcIWd5GW_DtNCDuPkv8GIhA2ElL42z0cpyNnERnAfa6jL4djnaTsCyAQO5QzWB-szUiYkkjGomx1U3dhaa4cY6Lx6lQ1QFBDi0ZWCQJCh2Ku3W9sGjTuR7uXU5G4qEHm1l-FLP2igxhA_SDjQ'
        });

// Dio snipeit = new Dio(options);
    Dio z = new Dio(x);

    var resp = await z.get('/hardware/byserial/' + androidInfo.androidId);

    print(resp);
    Map data = resp.data['rows'][0];
    // var jdata = json.decode(data);
    print(data['serial']);
    // Device _thisDevice = fromMap(data);
    // print(_thisDevice.androidId);
    // return _thisDevice;
    return data;
  }

  Future<Map> setDeviceOwner(String employeeId) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    DocumentReference result = await Firestore.instance
        .collection('devices')
        .document(androidInfo.androidId);
    await result.updateData({'ownerId': employeeId});
    print(result);
    var data = await result.get();

    // Device d = fromMap(data.data);
    print(data.data['ownerId']);
    return data.data;
  }
}

//  const checkout =
//         );
//         if (checkout.data.status !== "success") {
//           console.log(checkout.data);
//           return false;
//         } else {
//           return true;
//         }
//       }
//        async  checkinDevice(snipeId: string, device: any) {
//         const checkin = await snipeit.post(
//           "/hardware/" + device + "/checkin",
//           {
//             note: 'checkindevice function',
//             location_id: 2
//           }
//         );
//         if (checkin.data.status !== "success") {
//           console.log(checkin.data);
//           return false;
//         } else {
//           return true;
//         }
//       }
//        async  updateDeviceInFirestore(deviceId: string, userId: any) {
//         try {
//           admin.firestore().collection("devices").doc(deviceId).update({
//             "owner": userId,
//             "lastUpdateDate": Date.now()
//           })
//         } catch (err) {
//           return false
//         }
//         return true
//       }

//        async  getDeviceFromFirestore(deviceId: any) {
//         const docRef =  admin.firestore().collection("devices").doc(deviceId);
//         return await docRef.get()
//       }
