import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'employee.jser.dart';

// class Address {
//   Address({this.city, this.state, this.street, this.zip});

//   final String city;
//   final String state;
//   final String street;
//   final String zip;
//   static Address fromMap(Map map) {
//     return new Address(
//       city: map['city'],
//       state: map['state'],
//       street: map['street'],
//       zip: map['zip'],
//     );
//   }

//   getPretty() {
//     if (this.street == null ||
//         this.city == null ||
//         this.state == null ||
//         this.zip == null) {
//       return 'needs updating';
//     }
//     return this.street + ' ' + this.city + ', ' + this.state + ' ' + this.zip;
//   }
// }

class Employee {
  Employee({
    @required this.avatar,
    this.id,
    @required this.name,
    this.email,
    // this.address,
    this.currentDeviceId,
  });

   String id;
  final String avatar;
    @pass // GeopPoints should not be serialized but passed as they are to FireStore
  // final Address address;
  final String currentDeviceId;
  final String name;
  final String email;
 String cell_phone;
  bool clockedIn;
    @ignore // we don't store the distance. This will be filled in during reading
  double distance;
  // int humanityId

  static List<Employee> allFromResponse(String response) {
    var decodedJsonEmployees = json.decode(response).cast<dynamic, dynamic>();
    return decodedJsonEmployees['data']
        .cast<Map<dynamic, dynamic>>()
        // .map((obj) => Employee.fromMap(obj))
        .toList()
        .cast<Employee>();
  }

  factory Employee.fromDocument(DocumentSnapshot document) {
    // Address _address = new Address(
    //     state: document['state'],
    //     street: document['address'],
    //     zip: document['zip']);

    return new Employee(
        id: document.documentID,
        avatar: document['avatar']['large'],
        name: document['name'],
        email: document['email']);
        // address: _address,
  }
  // static Employee fromMap(Map map) {
  //   // map['location'] =
  //   //     '"street":"abildsøveien 4299","city":"røyken","state":"oppland","postcode":"5578"';
  //   // Address _address = new Address(
  //   //     state: map['state'], street: map['address'], zip: map['zip']);

  //   // if (_address == null || _address == "") {
  //   //   _address = "2811 University blvd";
  //   // }
  //   var _state = map['state'];
  //   if (_state == null || _state == "") {
  //     _state = "TX";
  //   }

  //   var _name = map['name'];
  //   var _avatar = map['avatar']['large'];
  //   if (_avatar == null || _avatar == "") {
  //     _avatar =
  //         "https://s3.amazonaws.com/uf.shiftplanning.com/avatars%2F1447703-54e21cf441430.jpg";
  //   }
  //   var _email = map['email'];
  //   if (_email == null || _email == "") {
  //     _email = "info@andrewscarpetcleaning.com";
  //   }
  //   bool _clockedIn = false;
  //   (map['clockedIn'] != null && map['clockedIn'] == true)
  //       ? _clockedIn = true
  //       : _clockedIn = false;

  //   return new Employee(
  //       id: map['id'],
  //       avatar: _avatar,
  //       // address: _address,
  //       name: _name,
  //       clockedIn: _clockedIn,
  //       email: _email);
  //   // location: _capitalize(_address));
  // }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
@GenSerializer()
class EmployeeSerializer extends Serializer<Employee> with _$EmployeeSerializer {}