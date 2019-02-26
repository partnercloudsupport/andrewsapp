import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'account.dart';
import 'package:flutter/material.dart';
part 'asset.jser.dart';

class HardwareModel {
  int id;
  String name;

  HardwareModel({this.id, this.name});
}

class Eol {
  String date;
  String formatted;

  Eol({this.date, this.formatted});
}

class StatusLabel {
  int id;
  String name;
  String statusType;
  String statusMeta;

  StatusLabel({this.id, this.name, this.statusType, this.statusMeta});
}

class Category {
  int id;
  String name;

  Category({this.id, this.name});
}

class Manufacturer {
  int id;
  String name;

  Manufacturer({this.id, this.name});
}

class Supplier {
  int id;
  String name;

  Supplier({this.id, this.name});
}

class RtdLocation {
  int id;
  String name;

  RtdLocation({this.id, this.name});
}

class AssignedTo {
  int id;
  String username;
  String name;
  String firstName;
  String lastName;
  String employeeNumber;
  String type;

  AssignedTo(
      {this.id,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.employeeNumber,
      this.type});
}

class AvailableActions {
  bool checkout;
  bool checkin;
  bool clone;
  bool restore;
  bool update;
  bool delete;

  AvailableActions(
      {this.checkout,
      this.checkin,
      this.clone,
      this.restore,
      this.update,
      this.delete});
}

class Asset {
  int id;
  String name;
  String assetTag;
  String serial;
  HardwareModel model;
  // String modelNumber;
  // String eol;
  StatusLabel statusLabel;
  Category category;
  Manufacturer manufacturer;
  Supplier supplier;
  String notes;
  String orderNumber;
  // String company;
  // String location;
  // RtdLocation rtdLocation;
  String image;
  // AssignedTo assignedTo;
  String warrantyMonths;
  String warrantyExpires;
  // String createdAt;
  // String updatedAt;
  // String lastAuditDate;
  // String nextAuditDate;
  // String deletedAt;
  // String purchaseDate;
  // String lastCheckout;
  // String expectedCheckin;
  String purchaseCost;
  int checkinCounter;
  int checkoutCounter;
  int requestsCounter;
  bool userCanCheckout;
  // List<String> customFields;
  AvailableActions availableActions;

  Asset({
    this.id,
    this.name,
    this.assetTag,
    this.serial,
    // this.model,
    // this.modelNumber,
    // this.eol,
    // this.statusLabel,
    // // this.category,
    // this.manufacturer,
    // this.supplier,
    this.notes,
    this.orderNumber,
    // this.company,
    // this.location,
    // this.rtdLocation,
    this.image,
    // this.assignedTo,
    // this.warrantyMonths,
    // this.warrantyExpires,
    // this.createdAt,
    // this.updatedAt,
    // this.lastAuditDate,
    // this.nextAuditDate,
    // this.deletedAt,
    // this.purchaseDate,
    // this.lastCheckout,
    // this.expectedCheckin,
    this.purchaseCost,
    this.checkinCounter,
    this.checkoutCounter,
    this.requestsCounter,
    this.userCanCheckout,
    // this.customFields,
    // this.availableActions
  });
}

@GenSerializer()
class AssetSerializer extends Serializer<Asset> with _$AssetSerializer {}

@GenSerializer()
class HardwareModelSerializer extends Serializer<HardwareModel>
    with _$HardwareModelSerializer {}

@GenSerializer()
class AvailableActionsSerializer extends Serializer<AvailableActions>
    with _$AvailableActionsSerializer {}

@GenSerializer()
class AddressSerializer extends Serializer<Address> with _$AddressSerializer {}

@GenSerializer()
class AssignedToSerializer extends Serializer<AssignedTo>
    with _$AssignedToSerializer {}

@GenSerializer()
class RtdLocationSerializer extends Serializer<RtdLocation>
    with _$RtdLocationSerializer {}

@GenSerializer()
class SupplierDateSerializer extends Serializer<Supplier>
    with _$SupplierDateSerializer {}

@GenSerializer()
class ManufacturerSerializer extends Serializer<Manufacturer>
    with _$ManufacturerSerializer {}

@GenSerializer()
class CategorySerializer extends Serializer<Category>
    with _$CategorySerializer {}

@GenSerializer()
class StatusLabelSerializer extends Serializer<StatusLabel>
    with _$StatusLabelSerializer {}
