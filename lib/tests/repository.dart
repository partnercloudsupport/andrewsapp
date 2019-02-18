import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_provider.dart';
// import 'mlkit_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  // final _mlkitProvider = MLkitProvider();

  Future<int> authenticateUser(String email, String password) =>
      _firestoreProvider.authenticateUser(email, password);

  Future<void> registerUser(String email, String password) =>
      _firestoreProvider.registerUser(email, password);

// Future<String> extractText(var image) => _mlkitProvider.getImage(image);

  Future<void> uploadTimesheet(String email, String title, String Timesheet) =>
      _firestoreProvider.uploadTimesheet(title, email, Timesheet);

  Stream<DocumentSnapshot> myTimesheetList(String email) =>
      _firestoreProvider.myTimesheetList(email);

  Stream<QuerySnapshot> othersTimesheetList() =>
      _firestoreProvider.othersTimesheetList();

  void removeTimesheet(String title, email) =>
      _firestoreProvider.removeTimesheet(title, email);
}
