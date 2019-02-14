// import 'package:scoped_model/scoped_model.dart';
// import 'account.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'serviceItem.dart';

// class JobModel extends Model {
//   @required String id;
//   @required Account customer;
//   @required String author;
//   @required List<String> serviceItems;
//   @required bool isDone;

//   JobModel(this.id, this.customer);

//   JobModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];   
//     author = json['author'];    
//     isDone = json['isDone'];    
//     if (json['serviceItems'] != null) {
//       serviceItems = new List<String>();
//       json['serviceItems'].forEach((v) {
//         serviceItems.add(v);
//       });
//     }
//     customer = json['customer'] != null ? new Account.fromJson(json['customer']) : null;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['author'] = this.author;
//     data['isDone'] = this.isDone;

//  if (this.serviceItems != null) {
//       // data['serviceItems'] = this.serviceItems.map((v) => v.toList();
//       data['serviceItems'].forEach((v) {
//           data['serviceItems'].add(v);
//        } ) ;
//     }
//     if (this.customer != null) {
//       data['customer'] = this.customer.toJson();
//     }
//      author = data['author'];   
//      if(serviceItems != null){

//        data['serviceItems'].forEach((v) {
//           data['serviceItems'].add(v);
//        } ) ;
//      }
//     return data;
//   }

//   static JobModel of(BuildContext context) =>
//       ScopedModel.of<JobModel>(context);

//   void _onJobDocumentChange(DocumentSnapshot snapshot) {
//     if (snapshot.exists) {
//       // _user = User.fromDocumentSnapshot(snapshot.documentID, snapshot.data);
//       // _status = Status.Authenticated;
//     } else {
//       // _user = null;
//       // _status = Status.Unregistered;
//     }
//     // notifyListeners();
//   }


// }
 