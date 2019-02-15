import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseService {
  final empCollection = Firestore.instance.collection("employees");
  final timeSheetCollection = Firestore.instance.collection("timesheets");

  Future<String> getHumanityToken() async {
    // var data = new Map<String, dynamic>();
    // data['client_id'] = '0cbaa9173943569cad4c0b8267981147bac0cf5d';
    // data['client_secret'] = 'be6a34d0830ab6fb3db837958d50faace249e0d1';
    // data['grant_type'] = 'password';
    // data['username'] = 'ash@andrewscarpetcleaning.com';
    // data['password'] = 'sugarlips42';

    var _clockResponse =
        await http.post('https://www.humanity.com/oauth2/token.php', body: {
      'client_id': "0cbaa9173943569cad4c0b8267981147bac0cf5d",
      "client_secret": "be6a34d0830ab6fb3db837958d50faace249e0d1",
      "grant_type": "password",
      "username": "ash@andrewscarpetcleaning.com",
      "password": "sugarlips42"
    });
    print(_clockResponse.body);
    var result = json.decode(_clockResponse.body);
    return result['access_token'];
  }

  Future<String> uploadTimesheet(Timesheet sheet) async {
    DocumentReference docRef =
        await timeSheetCollection.add(TimesheetSerializer().toMap(sheet));
    return docRef.documentID;
  }

  Future<void> updateTimesheet(sheetId) async {
    DateTime now = new DateTime.now();
    final DocumentReference sheetRef =
        Firestore.instance.document('timesheets/' + sheetId);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot sheetSnapshot = await tx.get(sheetRef);
      if (sheetSnapshot.exists) {
        await tx.update(sheetRef, <String, dynamic>{
          'status': '0',
          'outTimestamp': now.millisecondsSinceEpoch,
          'outDay': now.day,
          'outHour': now.hour
        });
      }
    });
  }

  Future<void> updateEmployee(employee, updatedStatus, docId) async {
    final DocumentReference employeeRef =
        Firestore.instance.document('employees/' + employee.fbemployeeid);
    await Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot empSnapshot = await tx.get(employeeRef);
      if (empSnapshot.exists) {
        await tx.update(employeeRef, <String, dynamic>{
          'clockedIn': updatedStatus,
          'currentTimesheetId': docId
        });
        EmployeeSerializer().fromMap(empSnapshot.data);
        // Navigator.pop(context);
        // _toggleClockedIn();
        // _buildActionButtons(Theme.of(context));
      }
    });
  }

  Stream<List<Employee>> getEmployees({List<QueryConstraint> constraints}) {
    try {
      Query query =
          buildQuery(collection: empCollection, constraints: constraints);
      return getDataFromQuery(
        query: query,
        // mapper: (doc) => EmployeeSerializer().fromMap(doc.data),
        mapper: (eventDoc) {
          var emp = EmployeeSerializer().fromMap(eventDoc.data);
          emp.fbemployeeid = eventDoc.documentID;
          (emp.clockedIn == null) ? emp.clockedIn == false : null;
          return emp;
        },
        orderComparer: (emp1, emp2) =>
            emp1.clockTimestamp.compareTo(emp2.clockTimestamp),
      );
    } on Exception catch (ex) {
      print(ex);
    }
    return null;
  }

// getEvents(constraints: [new QueryConstraint(field: "creatorId", isEqualTo: _currentUser.id)]);
  Stream<List<Timesheet>> getTimesheets({List<QueryConstraint> constraints}) {
    try {
      Query query =
          buildQuery(collection: timeSheetCollection, constraints: constraints);

      return getDataFromQuery(
        query: query,

        mapper: (eventDoc) {
          var sheet = TimesheetSerializer().fromMap(eventDoc.data);
          sheet.id = eventDoc.documentID;
          return sheet;
        },
        orderComparer: (sheet1, sheet2) =>
            sheet1.inTimestamp.compareTo(sheet2.inTimestamp),
        //  clientSidefilters: (Timesheet sheet) => sheet.employeeId == '123';
      );
    } on Exception catch (ex) {
      print(ex);
    }
    return null;
  }

  // print(data);

  Future<bool> punchClock(Employee employee, Device device) async {
    bool result = false;
    String token = await getHumanityToken();
    http.Response _clockResponse;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    if (employee.clockedIn) {
      _clockResponse = await http.put(
          'https://www.humanity.com/api/v2/employees/${employee.id}/clockout?access_token=' +
              token);
    } else {
      _clockResponse = await http.post(
          'https://www.humanity.com/api/v2/employees/${employee.id}/clockin?access_token=' +
              token);
    }

    var decodedResponse =
        json.decode(_clockResponse.body).cast<String, dynamic>();

    bool updatedStatus;

    if (decodedResponse['status'] == 13) {
      (employee.clockedIn) ? updatedStatus = false : updatedStatus = true;
    } else {
      (decodedResponse['data']['out_timestamp'] == '0')
          ? updatedStatus = true
          : updatedStatus = false;
    }

    var docId;
    if (updatedStatus) {
      var ts = createNewTimesheet(employee, device);
      docId = await uploadTimesheet(ts);
    } else {
      await updateTimesheet(employee.currentTimesheetId);
      docId = "0";
    }
    await updateEmployee(employee, updatedStatus, docId);

    return result;
  }
}

//  void _punchClock() async {
//     // print(currentStatus);
//     http.Response _clockResponse;

//     // if (employee.clockedIn) {
//     //   _clockResponse = await http.put(
//     //       'https://www.humanity.com/api/v2/employees/${employee.id}/clockout?access_token=b490958e4890f89ae444334283874c487aab419f');
//     // } else {
//     //   _clockResponse = await http.post(
//     //       'https://www.humanity.com/api/v2/employees/${employee.id}/clockin?access_token=b490958e4890f89ae444334283874c487aab419f');
//     // }
//     // print(_clockResponse.body);
//     var decodedResponse =
//         json.decode(_clockResponse.body).cast<String, dynamic>();

//     print(decodedResponse['data']['out_timestamp']);

//     DocumentReference employeeRef =
//         Firestore.instance.document('employees/' + employee.id);

//     if (decodedResponse['data']['out_timestamp'] == '0') {
//       // employee['clockedIn'] = false;
//       Firestore.instance.runTransaction((Transaction tx) async {
//         DocumentSnapshot postSnapshot = await tx.get(employeeRef);
//         if (postSnapshot.exists) {
//           await tx.update(employeeRef, <String, dynamic>{'clockedIn': false});
//         }
//       });
//     } else {
//       Firestore.instance.runTransaction((Transaction tx) async {
//         DocumentSnapshot postSnapshot = await tx.get(employeeRef);
//         if (postSnapshot.exists) {
//           await tx.update(employeeRef, <String, dynamic>{'clockedIn': true});
//         }
//       });
//       // this.currentStatus = new CurrentStatus(
//       //     is_on_break: 'false',
//       //     clockin_time: decodedResponse['data']['in_time']['time'],
//       //     clockin_date: decodedResponse['data']['in_time']['day']);
//     }
//     // var status = decodedResponse['data']
//     //     .cast<Map<String, dynamic>>()
//     //     // .map((obj) => Object.fromMap(obj))
//     //     .toList()
//     //     .cast<Object>();
//     // print(status);
//     // var data = decodedJsonEmployees['data']
//     //     .cast<Map<String, dynamic>>()
//     //     // .map((obj) => Object.fromMap(obj))
//     //     .toList()
//     //     .cast<Object>();
//  }
