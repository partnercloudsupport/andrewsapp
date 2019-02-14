import 'package:cloud_firestore/cloud_firestore.dart';


class Account  {
  String firstName;
  String smId;
  String lastName;
  Address address;
  String accountName;
  List<String> phones;

  Account({this.smId, this.firstName, this.lastName, this.address, this.phones, this.accountName});

    Account.fromSnapshot(DocumentSnapshot snapshot)
      :  
      smId = snapshot['smId'],
    firstName = snapshot['firstName'],
    lastName = snapshot['lastName'],
    accountName = snapshot['name'],
    address = Address.fromJson(snapshot['address']),
    phones = List.from(snapshot['phone']);

  // Account.fromReference(DocumentReference ref )  {
  //   DocumentSnapshot document =  Firestore.instance.collection('accounts').document(ref.path).get() as DocumentSnapshot;
  //   smId = document['smId'];     
  //   firstName = document['firstName'];
  //   lastName = document['lastName'];
  //   accountName = document['name'];
  //   address = Address.fromJson(document['address']);
  //   phones = List.from(document['phone']);
  //   // address =
  //   //     document['address'] != null ? new Address.fromJson(json) : null;

  // // if  (address.city != null && address.zipcode != null && address.streetAddress != null && address.pretty == null) 
  // //   address.pretty = address.streetAddress + ' ' + address.city + ', TX '+ address.zipcode;
  
    
  //   // if (json['phones'] != null) {
  //   //   phones = new List<String>();
  //   //   json['phones'].forEach((v) {
  //   //     phones.add(v);
  //   //   });
  //   // }
  // }

  Account.fromJson(Map<dynamic, dynamic> json) {
    smId = json['smId'];     
    firstName = json['firstName'];
    lastName = json['lastName'];
    accountName = json['name'];
    address =
        json['address'] != null ? new Address.fromJson(json) : null;

  // if  (address.city != null && address.zipcode != null && address.streetAddress != null && address.pretty == null) 
  //   address.pretty = address.streetAddress + ' ' + address.city + ', TX '+ address.zipcode;
  
    
    if (json['phones'] != null) {
      phones = new List<String>();
      json['phones'].forEach((v) {
        phones.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smId'] = this.smId;

    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['name'] = this.accountName;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v).toList();
    }
    return data;
  }
}

class Address {
  String streetAddress;
  String city;
  String state;
  String zipcode;
  String pretty;

  Address({this.streetAddress, this.city, this.state, this.zipcode});

  Address.fromJson(Map<dynamic, dynamic> json) {
    if(json['accountID'] == null){
    streetAddress = json['address']['streetAddress'];
    city = json['address']['city'];
    state = json['address']['state'];
    zipcode = json['address']['zipcode'];
    // pretty = json['address']['pretty'];
    }else{
         streetAddress = json['streetAddress'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    pretty = json['pretty'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['streetAddress'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['pretty'] = this.streetAddress +' '+ this.city + ' ' + this.state +', '+ this.zipcode;
    return data;
  }
}

// class PhoneNumber {
//   String type;
//   String number;

//   PhoneNumber({this.type, this.number});

//   PhoneNumber.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     number = json['number'];
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['type'] = this.type;
//   //   data['number'] = this.number;
//   //   return data;
//   // }
// }
