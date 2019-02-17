import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:flutter/material.dart';
import './account.dart';

part 'account.jser.dart';

class Account {
  String firstName;
  String smId;
  String lastName;
  Address address;
  String accountName;
  List<String> phones;

  Account(
      {this.smId,
      this.firstName,
      this.lastName,
      this.address,
      this.phones,
      this.accountName});
}

class Address {
  String streetAddress;
  String city;
  String state;
  String zipcode;
  String pretty;

  Address({this.streetAddress, this.city, this.state, this.zipcode});
}

@GenSerializer()
class AccountSerializer extends Serializer<Account> with _$AccountSerializer {}

@GenSerializer()
class AddressSerializer extends Serializer<Address> with _$AddressSerializer {}
