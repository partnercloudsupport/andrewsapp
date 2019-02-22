import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/employee.dart';

class EmployeeService {
  EmployeeService({
    @required this.firestore,
    @required this.firebaseAuth,
  });

  EmployeeService.instance()
      : firestore = Firestore.instance,
        firebaseAuth = FirebaseAuth.instance;

  final Firestore firestore;
  final FirebaseAuth firebaseAuth;

  // Future<Employee> currentEmployee() {
  //   return firebaseAuth.currentEmployee();
  // }

  Future<bool> createEmployee(String id, Map<String, String> formData) async {
    try {
      await firestore
          .collection('employees')
          .document(id)
          .setData(_newEmployeeData(formData));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Employee> getById(String id) async {
    final DocumentSnapshot snapshot =
        await firestore.collection('employees').document(id).get();

    if (snapshot.exists) {
      return EmployeeSerializer().fromMap(snapshot.data);
    } else {
      return null;
    }
  }

  Map<String, dynamic> _newEmployeeData(Map<String, String> formData) {
    return <String, dynamic>{}
      ..addAll(formData)
      ..addAll(<String, dynamic>{
        'agreedToTermsAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
  }
}
