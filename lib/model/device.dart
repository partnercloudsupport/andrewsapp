import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  Device({
   this.androidId, 
   this.employees,
   this.owner,

  });
  final String androidId;
  final String owner;
  final List<String> employees;

  factory Device.fromDocument(DocumentSnapshot document) {
   
    return new Device(
        androidId: document.documentID,
        employees: document['employees'],
        owner: document['owner']
    );
  }
  factory Device.fromJson(Map<String, dynamic> json) {
   
    return  Device(
        androidId: json['deviceId'] as String,
        owner: json['owner'] as String,
        employees: json['employees'] as List
    );
  }
}
