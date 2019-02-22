import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/device.dart';
import 'package:device_info/device_info.dart';

final DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

class DeviceService {
  DeviceService({
    @required this.firestore,
    @required this.firebaseAuth,
  });

  DeviceService.instance()
      : firestore = Firestore.instance,
        firebaseAuth = FirebaseAuth.instance;

  final Firestore firestore;
  final FirebaseAuth firebaseAuth;

  DocumentReference _documentReference(String dev) {
    return Firestore.instance.collection('devices').document('${dev}');
  }

  // Future<Device> currentDevice() {
  //   return firebaseAuth.currentDevice();
  // }
  Future<bool> setOwner(String employee) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    try {
      await _documentReference(androidInfo.androidId).setData({
        'owner': employee,
      }, merge: true);
      print('device owner set to ');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addEmployee(String employee) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    try {
      await firestore
          .collection('devices')
          .document(androidInfo.androidId)
          .updateData(<String, FieldValue>{
        "userList": FieldValue.arrayUnion(<String>[employee])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createDevice(String id, Map<String, String> formData) async {
    try {
      await firestore
          .collection('Devices')
          .document(id)
          .setData(_newDeviceData(formData));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Device> getById() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    final DocumentSnapshot snapshot = await firestore
        .collection('Devices')
        .document(androidInfo.androidId)
        .get();

    if (snapshot.exists) {
      return DeviceSerializer().fromMap(snapshot.data);
    } else {
      return null;
    }
  }

  Map<String, dynamic> _newDeviceData(Map<String, String> formData) {
    return <String, dynamic>{}
      ..addAll(formData)
      ..addAll(<String, dynamic>{
        'agreedToTermsAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
  }
}
