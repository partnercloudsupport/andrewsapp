import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/employee_service.dart';
import '../services/device_service.dart';
import 'user.dart';
import 'employee.dart';
import 'device.dart';

enum Status {
  Unauthenticated,
  Unregistered,
  Authenticated,
}

class CurrentUserModel extends Model {
  CurrentUserModel({
    @required this.firestore,
    @required this.firebaseAuth,
    @required this.userService,
  });

  CurrentUserModel.instance()
      : firestore = Firestore.instance,
        firebaseAuth = FirebaseAuth.instance,
        userService = UserService.instance(),
        employeeService = EmployeeService.instance(),
        deviceService = DeviceService.instance(),
        authService = AuthService.instance() {
    firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status _status = Status.Unauthenticated;
  Firestore firestore;
  FirebaseAuth firebaseAuth;
  UserService userService;
  EmployeeService employeeService;
  DeviceService deviceService;
  User _user;
  Employee _employee;
  Device _device;
  FirebaseUser _firebaseUser;
  AuthService authService;

  static CurrentUserModel of(BuildContext context) =>
      ScopedModel.of<CurrentUserModel>(context);

  User get user => _user;
  Employee get employee => _employee;
  Device get device => _device;
  Status get status => _status;
  FirebaseUser get firebaseUser => _firebaseUser;

  Future<void> signIn(Map _formData) {
    return authService.signInWithGoogle(_formData);
  }

  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  Future<void> register(Map<String, String> formData) async {
    await userService.createUser(_firebaseUser.uid, formData);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _firebaseUser = null;
      _user = null;
      _employee = null;
      _device = null;
      _status = Status.Unauthenticated;
    } else {
      if (firebaseUser.uid != _firebaseUser?.uid) {
        _firebaseUser = firebaseUser;
      }
      _status = Status.Unregistered;
      if (firebaseUser.uid != _user?.id) {
        _user = await userService.getById(_firebaseUser.uid);
      }
      if (_user != null) {
        _status = Status.Authenticated;
      }
    }

    notifyListeners();
    _listenToUserChanges();
  }

  void _onUserDocumentChange(DocumentSnapshot snapshot) async {
    if (snapshot.exists) {
      _user = User.fromDocumentSnapshot(snapshot.documentID, snapshot.data);
      _employee = await employeeService.getById(snapshot.data['employeeId']);
      await deviceService.addEmployee(snapshot.data['employeeId']);

      _device = await deviceService.getById();

      _status = Status.Authenticated;
    } else {
      _user = null;
      _status = Status.Unregistered;
    }
    notifyListeners();
  }

  void _listenToUserChanges() {
    if (_firebaseUser == null) {
      return;
    }
    // TODO(abraham): Does this need any cleanup if uid changes?
    firestore
        .collection('users')
        .document(_firebaseUser.uid)
        .snapshots()
        .listen(_onUserDocumentChange);
  }
}
