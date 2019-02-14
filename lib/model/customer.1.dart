import 'package:scoped_model/scoped_model.dart';

class Customer extends Model {
  String firstName;
  String lastName;
  Address address;
  List<PhoneNumber> phoneNumber;

  Customer({this.firstName, this.lastName, this.address, this.phoneNumber});

  Customer.fromJson(Map<dynamic, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['phoneNumber'] != null) {
      phoneNumber = new List<PhoneNumber>();
      json['phoneNumber'].forEach((v) {
        phoneNumber.add(new PhoneNumber.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.phoneNumber != null) {
      data['phoneNumber'] = this.phoneNumber.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String streetAddress;
  String city;
  String state;
  String postalCode;

  Address({this.streetAddress, this.city, this.state, this.postalCode});

  Address.fromJson(Map<dynamic, dynamic> json) {
    streetAddress = json['streetAddress'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetAddress'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    return data;
  }
}

class PhoneNumber {
  String type;
  String number;

  PhoneNumber({this.type, this.number});

  PhoneNumber.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['number'] = this.number;
    return data;
  }
}
