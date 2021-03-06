import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';

final DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

class DatabaseService {
  final empCollection = Firestore.instance.collection("employees");
  final timeSheetCollection = Firestore.instance.collection("htimesheets");

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
    print(result['access_token']);
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

  Future<void> updateEmployeeTimesheetStatus(
      employee, updatedStatus, docId) async {
    DateTime now = new DateTime.now();
    final DocumentReference employeeRef =
        Firestore.instance.document('employees/' + employee.fbemployeeid);
    await Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot empSnapshot = await tx.get(employeeRef);
      if (empSnapshot.exists) {
        await tx.update(employeeRef, <String, dynamic>{
          'clockedIn': updatedStatus,
          'currentTimesheetId': docId,
          'clockTimestamp': now.millisecondsSinceEpoch
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
          (emp.clockedIn == null) ? emp.clockedIn = false : null;
          (emp.clockTimestamp == null)
              ? emp.clockTimestamp = 9999999999999999
              : null;
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
          print(eventDoc.data['in_timestamp']);
          // DateTime time = new DateTime.fromMicrosecondsSinceEpoch(1550216100);
          var intime = new DateTime.fromMillisecondsSinceEpoch(
              eventDoc.data['in_timestamp'] * 1000);
          var outtime = new DateTime.fromMillisecondsSinceEpoch(
              eventDoc.data['out_timestamp'] * 1000);
          String sintime =
              "${intime.year.toString()}-${intime.month.toString().padLeft(2, '0')}-${intime.day.toString().padLeft(2, '0')}";
          String souttime =
              "${outtime.year.toString()}-${outtime.month.toString().padLeft(2, '0')}-${outtime.day.toString().padLeft(2, '0')}";
          Duration difference = outtime.difference(intime);
          print(difference.inHours);

          sheet.documentID = eventDoc.documentID;
          return sheet;
        },
        // orderComparer: (sheet1, sheet2) =>
        //     sheet1.inTimestamp.compareTo(sheet2.inTimestamp),
        //  clientSidefilters: (Timesheet sheet) => sheet.employeeId == '123';
      );
    } on Exception catch (ex) {
      print(ex);
    }
    return null;
  }

//     Future<Post> fetchPost() async {
//       BaseOptions options = new BaseOptions(
//         baseUrl: "https://api.servicemonster.net/v1",
//         connectTimeout: 5000,
//         receiveTimeout: 3000,
//         headers: {
//           'Authorization': 'Basic Sk5wbkZOelhxOnltMWM4cGU4QzNPNHM3bDBBVms=',
//         });
//     Dio dio = new Dio(options);

//   final response =
//       await dio.get('/');

//   if (response.statusCode == 200) {
//     // If server returns an OK response, parse the JSON
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // If that response was not OK, throw an error.
//     throw Exception('Failed to load post');
//   }
// }
  // print(data);

  Future<bool> punchClock(Employee employee, Device device) async {
    bool result = false;
    String tokenx = await getHumanityToken();
    http.Response _clockResponse;
    _clockResponse = await http.get(
        'https://www.humanity.com/api/v2/timeclocks/status/${employee.id}/1?clockout?access_token=${tokenx}');
    var decodedResponse =
        json.decode(_clockResponse.body).cast<String, dynamic>();
    print(_clockResponse);
    print(decodedResponse);
    return false;
    (employee.clockedIn == null) ? employee.clockedIn = false : null;
    if (employee.clockedIn) {
      _clockResponse = await http.put(
          'https://www.humanity.com/api/v2/employees/${employee.id}/clockout?access_token=' +
              tokenx);
    } else {
      _clockResponse = await http.post(
          'https://www.humanity.com/api/v2/employees/${employee.id}/clockin?access_token=' +
              tokenx);
    }

    decodedResponse = json.decode(_clockResponse.body).cast<String, dynamic>();

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
    await updateEmployeeTimesheetStatus(employee, updatedStatus, docId);

    return result;
  }

  Future<Employee> getEmployee(employeeId) async {
    DocumentSnapshot result = await Firestore.instance
        .collection('employees')
        .document(employeeId)
        .get();
    var employee = EmployeeSerializer().fromMap(result.data);
    return employee;
  }
}
