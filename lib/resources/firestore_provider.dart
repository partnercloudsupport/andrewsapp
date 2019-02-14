import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  Future<int> authenticateUser(String email, String password) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<void> registerUser(String email, String password) async {
    return _firestore.collection("users").document(email).setData(
        {'email': email, 'password': password, 'timesheetAdded': false});
  }

  Future<void> uploadTimesheet(
      String title, String documentId, String timesheet) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").document(documentId).get();
    Map<String, String> timesheets = doc.data["timesheets"] != null
        ? doc.data["timesheets"].cast<String, String>()
        : null;
    if (timesheets != null) {
      timesheets[title] = timesheet;
    } else {
      timesheets = Map();
      timesheets[title] = timesheet;
    }
    return _firestore.collection("users").document(documentId).setData(
        {'timesheets': timesheets, 'timesheetAdded': true},
        merge: true);
  }

  Stream<DocumentSnapshot> myTimesheetList(String documentId) {
    return _firestore.collection("users").document(documentId).snapshots();
  }

  Stream<QuerySnapshot> othersTimesheetList() {
    return _firestore
        .collection("users")
        .where('timesheetAdded', isEqualTo: true)
        .snapshots();
  }

  void removeTimesheet(String title, String documentId) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").document(documentId).get();
    Map<String, String> timesheets =
        doc.data["timesheets"].cast<String, String>();
    timesheets.remove(title);
    if (timesheets.isNotEmpty) {
      _firestore
          .collection("users")
          .document(documentId)
          .updateData({"timesheets": timesheets});
    } else {
      _firestore.collection("users").document(documentId).updateData(
          {'timesheets': FieldValue.delete(), 'timesheetAdded': false});
    }
  }
}
