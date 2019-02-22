import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:scoped_model/scoped_model.dart';

part 'employee.jser.dart';

class Avatar {
  Avatar({
    this.large,
    this.small,
  });

  final String large;
  final String small;
}

class Address {
  Address({this.city, this.state, this.street, this.zip});

  String city;
  String state;
  String street;
  String zip;
}

class Employee {
  Employee({
    this.avatar,
    this.id,
    this.name,
    this.fullname,
    this.work_start_date,
    this.email,
    this.fbemployeeid,
    this.lastname,
    this.firstname,
    // this.address,
    this.currentDeviceId,
  });

  String id;
  Avatar avatar;
  String currentTimesheetId;
  int clockTimestamp;
  String city;
  String avatarSmall;
  String snipeId;
  String avatarLarge;
  String state;
  String fullname;
  String firstname;
  String lastname;

  String fbemployeeid;
  String address;
  String zip;
  // Address address;
  String currentDeviceId;
  String name;
  String birth_day;
  String birth_month;
  String work_start_date;
  String email;
  String cell_phone;
  bool clockedIn;
  getPrettyBirthDay() {
    if (this.birth_month == null || this.birth_day == null) {
      return 'N/A';
    }
    return this.birth_month + '/' + this.birth_day;
  }

  getPretty() {
    if (this.address == null ||
        this.city == null ||
        this.state == null ||
        this.zip == null) {
      return 'N/A';
    }
    return this.address + ' ' + this.city + ', ' + this.state + ' ' + this.zip;
  }
}

@GenSerializer()
class AvatarSerializer extends Serializer<Avatar> with _$AvatarSerializer {}

@GenSerializer()
class AddressSerializer extends Serializer<Address> with _$AddressSerializer {}

@GenSerializer()
class EmployeeSerializer extends Serializer<Employee>
    with _$EmployeeSerializer {}
