import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist/model/workorder.dart';
import 'package:taskist/model/device.dart';
import 'package:taskist/model/serviceItem.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopService {
  final serviceItemCollection = Firestore.instance.collection("service_items");

  final workOrderCollection = Firestore.instance.collection("workorders");

  Future<String> uploadServiceItem(ServiceItem serviceItem) async {
    DocumentReference docRef = await serviceItemCollection
        .add(ServiceItemSerializer().toMap(serviceItem));
    return docRef.documentID;
  }

  Future<void> updateServiceItem(serviceItemId) async {
    DateTime now = new DateTime.now();
    final DocumentReference serviceItemRef =
        Firestore.instance.document('serviceItems/' + serviceItemId);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot serviceItemSnapshot = await tx.get(serviceItemRef);
      if (serviceItemSnapshot.exists) {
        await tx.update(serviceItemRef, <String, dynamic>{
          'status': '0',
          'outTimestamp': now.millisecondsSinceEpoch,
          'outDay': now.day,
          'outHour': now.hour
        });
      }
    });
  }

  Future<void> updateWorkorderServiceItemStatus(
      workorder, updatedStatus, docId) async {
    DateTime now = new DateTime.now();
    final DocumentReference workorderRef =
        Firestore.instance.document('workorder/' + workorder.fbworkorderid);
    await Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot empSnapshot = await tx.get(workorderRef);
      if (empSnapshot.exists) {
        await tx.update(workorderRef, <String, dynamic>{
          'clockedIn': updatedStatus,
          'currentServiceItemId': docId,
          'clockTimestamp': now.millisecondsSinceEpoch
        });
        WorkorderSerializer().fromMap(empSnapshot.data);
        // Navigator.pop(context);
        // _toggleClockedIn();
        // _buildActionButtons(Theme.of(context));
      }
    });
  }

  Stream<List<Workorder>> getWorkorders({List<QueryConstraint> constraints}) {
    try {
      Query query =
          buildQuery(collection: workOrderCollection, constraints: constraints);
      return getDataFromQuery(
        query: query,
        // mapper: (doc) => WorkorderSerializer().fromMap(doc.data),
        mapper: (eventDoc) {
          var workorder = WorkorderSerializer().fromMap(eventDoc.data);

          workorder.documentID = eventDoc.documentID;
          return workorder;
        },
        // orderComparer: (order1, order2) =>
        //     order1.createdAt.compareTo(order2.createdAt),
      );
    } on Exception catch (ex) {
      print(ex);
    }
    return null;
  }

// getEvents(constraints: [new QueryConstraint(field: "creatorId", isEqualTo: _currentUser.id)]);
  Stream<List<ServiceItem>> getServiceItems(
      {List<QueryConstraint> constraints}) {
    try {
      Query query = buildQuery(
          collection: serviceItemCollection, constraints: constraints);

      return getDataFromQuery(
        query: query,

        mapper: (eventDoc) {
          var serviceItem = ServiceItemSerializer().fromMap(eventDoc.data);

          serviceItem.documentID = eventDoc.documentID;
          return serviceItem;
        },
        // orderComparer: (serviceItem1, serviceItem2) =>
        //     serviceItem1.inTimestamp.compareTo(serviceItem2.inTimestamp),
        //  clientSidefilters: (ServiceItem serviceItem) => serviceItem.workorderId == '123';
      );
    } on Exception catch (ex) {
      print(ex);
    }
    return null;
  }

  // print(data);

  Future<bool> punchClock(Workorder workorder, Device device) async {
    // bool result = false;
    // String tokenx = await getHumanityToken();
    // http.Response _clockResponse;
    // (workorder.clockedIn == null) ? workorder.clockedIn = false : null;
    // if (workorder.clockedIn) {
    //   _clockResponse = await http.put(
    //       'https://www.humanity.com/api/v2/workorder/${workorder.id}/clockout?access_token=' +
    //           tokenx);
    // } else {
    //   _clockResponse = await http.post(
    //       'https://www.humanity.com/api/v2/workorder/${workorder.id}/clockin?access_token=' +
    //           tokenx);
    // }

    // var decodedResponse =
    //     json.decode(_clockResponse.body).cast<String, dynamic>();

    // bool updatedStatus;

    // if (decodedResponse['status'] == 13) {
    //   (workorder.clockedIn) ? updatedStatus = false : updatedStatus = true;
    // } else {
    //   (decodedResponse['data']['out_timestamp'] == '0')
    //       ? updatedStatus = true
    //       : updatedStatus = false;
    // }

    // var docId;
    // if (updatedStatus) {
    //   var ts = createNewServiceItem(workorder, device);
    //   docId = await uploadServiceItem(ts);
    // } else {
    //   await updateServiceItem(workorder.currentServiceItemId);
    //   docId = "0";
    // }
    // await updateWorkorderServiceItemStatus(workorder, updatedStatus, docId);

    // return result;
  }
}

//  void _punchClock() async {
//     // print(currentStatus);
//     http.Response _clockResponse;

//     // if (workorder.clockedIn) {
//     //   _clockResponse = await http.put(
//     //       'https://www.humanity.com/api/v2/workorder/${workorder.id}/clockout?access_token=b490958e4890f89ae444334283874c487aab419f');
//     // } else {
//     //   _clockResponse = await http.post(
//     //       'https://www.humanity.com/api/v2/workorder/${workorder.id}/clockin?access_token=b490958e4890f89ae444334283874c487aab419f');
//     // }
//     // print(_clockResponse.body);
//     var decodedResponse =
//         json.decode(_clockResponse.body).cast<String, dynamic>();

//     print(decodedResponse['data']['out_timestamp']);

//     DocumentReference workorderRef =
//         Firestore.instance.document('workorder/' + workorder.id);

//     if (decodedResponse['data']['out_timestamp'] == '0') {
//       // workorder['clockedIn'] = false;
//       Firestore.instance.runTransaction((Transaction tx) async {
//         DocumentSnapshot postSnapshot = await tx.get(workorderRef);
//         if (postSnapshot.exists) {
//           await tx.update(workorderRef, <String, dynamic>{'clockedIn': false});
//         }
//       });
//     } else {
//       Firestore.instance.runTransaction((Transaction tx) async {
//         DocumentSnapshot postSnapshot = await tx.get(workorderRef);
//         if (postSnapshot.exists) {
//           await tx.update(workorderRef, <String, dynamic>{'clockedIn': true});
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
//     // var data = decodedJsonWorkorder['data']
//     //     .cast<Map<String, dynamic>>()
//     //     // .map((obj) => Object.fromMap(obj))
//     //     .toList()
//     //     .cast<Object>();
//  }
