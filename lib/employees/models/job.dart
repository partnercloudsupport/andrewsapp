import 'package:scoped_model/scoped_model.dart';
import 'account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'serviceItem.dart';

class JobModel extends Model {
  @required String id;
  @required Account customer;
  @required String author;
  @required List<Map> serviceItems;
  @required bool isDone;
  // @required int creationTimestamp;
  @required String status;
  @required String fbId;

  JobModel({this.id, this.customer});

    JobModel.fromSnapshot(DocumentSnapshot snapshot)
      : fbId = snapshot.documentID,
        author = snapshot['name'],
        status = snapshot['status'],
        // creationTimestamp = snapshot['creationTimestamp'],
        serviceItems = List<Map>.from(snapshot['serviceItems']),
        customer = Account.fromJson(snapshot['customer']);


  getColor(){
        if(this.status == 'Active'){
      return Colors.green[600];
    }  else{
     return Colors.grey;
    }
  }
  // JobModel.fromJson(Map<dynamic, dynamic> json) {
  //   serviceItems = json['serviceItems'];
  //   author = json['author'];    
  //   isDone = json['isDone'];    
    
  //   fbId = json['fbId'];
  //   status = json['status'];  

  //   if (serviceItems != null) {
  //     serviceItems = new List<ServiceItem>();
  //     json['serviceItems'].forEach((v) {
  //       print(v);
  //       ServiceItem item = new ServiceItem(v['name'], v['isDone']);
        
  //     serviceItems.add(item);
  //     });
  //   }
  //   customer = json['customer2'] != null ? new Account.fromJson(json['customer2']) : null;
  // }
  
  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['fbId'] = this.fbId;
    data['author'] = this.author;
    data['isDone'] = this.isDone;
   if(this.status == 'Active'){
      data['color'] = Colors.green[600];
    }  else{
      data['color'] = Colors.grey;
    }
    
    
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
     author = data['author'];   
     if(serviceItems != null){

      this.serviceItems.forEach((v) {
          data['serviceItems'].add(v);
       } ) ;
     }
    return data;
  }

  // static JobModel of(BuildContext context) =>
  //     ScopedModel.of<JobModel>(context);

  // void _onJobDocumentChange(DocumentSnapshot snapshot) {
  //   if (snapshot.exists) {
  //     // _user = User.fromDocumentSnapshot(snapshot.documentID, snapshot.data);
  //     // _status = Status.Authenticated;
  //   } else {
  //     // _user = null;
  //     // _status = Status.Unregistered;
  //   }
  //   // notifyListeners();
  // }


}
 