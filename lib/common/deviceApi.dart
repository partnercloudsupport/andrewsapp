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
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ1M2U1YmFhYjQ2MDJmNTJjNDEyNjJkZGFlZWU1YTk2YTk4OTMwNGFjYTczMGE4MjZkZmI2ZDcyYjdhYzA1YTgxM2I2YzA5MzA1NDIxZDQyIn0.eyJhdWQiOiIzIiwianRpIjoiZDUzZTViYWFiNDYwMmY1MmM0MTI2MmRkYWVlZTVhOTZhOTg5MzA0YWNhNzMwYTgyNmRmYjZkNzJiN2FjMDVhODEzYjZjMDkzMDU0MjFkNDIiLCJpYXQiOjE1NDkzMjc0NzcsIm5iZiI6MTU0OTMyNzQ3NywiZXhwIjoxNTgwODYzNDc3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.cy4j4xQ-p380SHktKJ87Bi3BIWUDxOb1jztb5CFSJgfZfDP7TalT2CRp4X8OP9EF1ZsmxwxiLfnqT0D9ZY639rYkOugQqVJfVQsucxF8DmguT8Xyo7GN9JfyAEvd6w1I47W9nPJkEGQ4mffiqYSiKrpHxBU1wh7Pdhxwd18OQtLTvXHtmYXH_csM928O8xzfGzn9AbkptqAs3i0c_t0JraAfjC7U8jTBZMwGUk8GdiU60VVPC_TXk8pcsdCyj1iVEOx1q8brx2KzdyXD6Jn1P7zfLj76O12az0sck7RYuOs38h4HIRj4QOZ5rRepyPiDS8Y5NdCipwxcW22iq9Ue35LCf1_H15pSuedV5UjO3APCLdXrNkAU5SVwI7sxi0OJsUOUPaePgOwdk8QonxycePKGSkbTBSskwNaUn26wci19rqSSiC1Uo5nq_lPNVl1MeNmtAesPzsDn3dUl4eajJfC8nV_AzJyWzHPevn5lNEBEUezeHDyBQ7lxJ_bLGMZUyIZCUZHp-5NY4MbfglYmW9ORPKswZUyN18PiljAGkjnVq1DOpmDhLzRN4OMWD5UKIH3-lcTbFrEmLJQ2o9YhWrDARY0rSdSoIOLL2l3E2chR9wI09ws9VHqySh9VoS1kkpXGIIFyXfE4e9mYrX5NJsP_152fTJU6ondg0dNek-0',
    });

Dio snipeit = new Dio(options);

Device parseDevice(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  // Map resopnse = new Map<String, dynamic>();

  return parsed.map<Device>((json) => fromMap(json)).toList();
}

class Devices {
  Future<Device> checkOutDevice(
    String snipeId,
    String deviceId,
  ) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var resp = await snipeit.post('/hardware/' + deviceId + '/checkout',
        data: {'assigned_user': snipeId, 'checkout_to_type': 'user'});
    // var jresp = json.decode(resp.data);
    // print(resp.data['status']);
    return resp.data;
  }

  Future<String> checkInDevice(
    String deviceId,
  ) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var resp = await snipeit.post('/hardware/' + deviceId + '/checkin');
    // var jresp = json.decode(resp.data);
    print(resp.data['status']);
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

  Future<Map> getDeviceFromSnipeByAndroidId(androidId) async {
    var resp = await snipeit.get('/hardware/byserial/' + androidId);
    Map data = resp.data['rows'][0];
    // var jdata = json.decode(data);
    print(data['serial']);
    // Device _thisDevice = fromMap(data);
    // print(_thisDevice.androidId);
    // return _thisDevice;
    return data;
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
