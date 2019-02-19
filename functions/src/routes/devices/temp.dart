// library hardware;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'hardware.g.dart';

// abstract class Hardware implements Built<Hardware, HardwareBuilder> {
//   Hardware._();

//   factory Hardware([updates(HardwareBuilder b)]) = _$Hardware;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   @BuiltValueField(wireName: 'asset_tag')
//   String get assetTag;
//   @BuiltValueField(wireName: 'serial')
//   String get serial;
//   @BuiltValueField(wireName: 'model')
//   Model get model;
//   @BuiltValueField(wireName: 'model_number')
//   String get modelNumber;
//   @BuiltValueField(wireName: 'eol')
//   Eol get eol;
//   @BuiltValueField(wireName: 'status_label')
//   StatusLabel get statusLabel;
//   @BuiltValueField(wireName: 'category')
//   Category get category;
//   @BuiltValueField(wireName: 'manufacturer')
//   Manufacturer get manufacturer;
//   @BuiltValueField(wireName: 'supplier')
//   Supplier get supplier;
//   @BuiltValueField(wireName: 'notes')
//   String get notes;
//   @BuiltValueField(wireName: 'order_number')
//   String get orderNumber;
//   @BuiltValueField(wireName: 'company')
//   String get company;
//   @BuiltValueField(wireName: 'location')
//   String get location;
//   @BuiltValueField(wireName: 'rtd_location')
//   RtdLocation get rtdLocation;
//   @BuiltValueField(wireName: 'image')
//   String get image;
//   @BuiltValueField(wireName: 'assigned_to')
//   AssignedTo get assignedTo;
//   @BuiltValueField(wireName: 'warranty_months')
//   String get warrantyMonths;
//   @BuiltValueField(wireName: 'warranty_expires')
//   String get warrantyExpires;
//   @BuiltValueField(wireName: 'created_at')
//   CreatedAt get createdAt;
//   @BuiltValueField(wireName: 'updated_at')
//   UpdatedAt get updatedAt;
//   @BuiltValueField(wireName: 'last_audit_date')
//   LastAuditDate get lastAuditDate;
//   @BuiltValueField(wireName: 'next_audit_date')
//   NextAuditDate get nextAuditDate;
//   @BuiltValueField(wireName: 'deleted_at')
//   String get deletedAt;
//   @BuiltValueField(wireName: 'purchase_date')
//   PurchaseDate get purchaseDate;
//   @BuiltValueField(wireName: 'last_checkout')
//   LastCheckout get lastCheckout;
//   @BuiltValueField(wireName: 'expected_checkin')
//   String get expectedCheckin;
//   @BuiltValueField(wireName: 'purchase_cost')
//   String get purchaseCost;
//   @BuiltValueField(wireName: 'checkin_counter')
//   int get checkinCounter;
//   @BuiltValueField(wireName: 'checkout_counter')
//   int get checkoutCounter;
//   @BuiltValueField(wireName: 'requests_counter')
//   int get requestsCounter;
//   @BuiltValueField(wireName: 'user_can_checkout')
//   bool get userCanCheckout;
//   @BuiltValueField(wireName: 'custom_fields')
//   BuiltList<String> get customFields;
//   @BuiltValueField(wireName: 'available_actions')
//   AvailableActions get availableActions;
//   String toJson() {
//     return json.encode(serializers.serializeWith(Hardware.serializer, this));
//   }

//   static Hardware fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         Hardware.serializer, json.decode(jsonString));
//   }

//   static Serializer<Hardware> get serializer => _$hardwareSerializer;
// }
// library model;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'model.g.dart';

// abstract class Model implements Built<Model, ModelBuilder> {
//   Model._();

//   factory Model([updates(ModelBuilder b)]) = _$Model;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   String toJson() {
//     return json.encode(serializers.serializeWith(Model.serializer, this));
//   }

//   static Model fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         Model.serializer, json.decode(jsonString));
//   }

//   static Serializer<Model> get serializer => _$modelSerializer;
// }
// library eol;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'eol.g.dart';

// abstract class Eol implements Built<Eol, EolBuilder> {
//   Eol._();

//   factory Eol([updates(EolBuilder b)]) = _$Eol;

//   @BuiltValueField(wireName: 'date')
//   String get date;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json.encode(serializers.serializeWith(Eol.serializer, this));
//   }

//   static Eol fromJson(String jsonString) {
//     return serializers.deserializeWith(Eol.serializer, json.decode(jsonString));
//   }

//   static Serializer<Eol> get serializer => _$eolSerializer;
// }
// library status_label;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'status_label.g.dart';

// abstract class StatusLabel implements Built<StatusLabel, StatusLabelBuilder> {
//   StatusLabel._();

//   factory StatusLabel([updates(StatusLabelBuilder b)]) = _$StatusLabel;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   @BuiltValueField(wireName: 'status_type')
//   String get statusType;
//   @BuiltValueField(wireName: 'status_meta')
//   String get statusMeta;
//   String toJson() {
//     return json.encode(serializers.serializeWith(StatusLabel.serializer, this));
//   }

//   static StatusLabel fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         StatusLabel.serializer, json.decode(jsonString));
//   }

//   static Serializer<StatusLabel> get serializer => _$statusLabelSerializer;
// }
// library category;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'category.g.dart';

// abstract class Category implements Built<Category, CategoryBuilder> {
//   Category._();

//   factory Category([updates(CategoryBuilder b)]) = _$Category;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   String toJson() {
//     return json.encode(serializers.serializeWith(Category.serializer, this));
//   }

//   static Category fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         Category.serializer, json.decode(jsonString));
//   }

//   static Serializer<Category> get serializer => _$categorySerializer;
// }
// library manufacturer;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'manufacturer.g.dart';

// abstract class Manufacturer
//     implements Built<Manufacturer, ManufacturerBuilder> {
//   Manufacturer._();

//   factory Manufacturer([updates(ManufacturerBuilder b)]) = _$Manufacturer;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   String toJson() {
//     return json
//         .encode(serializers.serializeWith(Manufacturer.serializer, this));
//   }

//   static Manufacturer fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         Manufacturer.serializer, json.decode(jsonString));
//   }

//   static Serializer<Manufacturer> get serializer => _$manufacturerSerializer;
// }
// library supplier;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'supplier.g.dart';

// abstract class Supplier implements Built<Supplier, SupplierBuilder> {
//   Supplier._();

//   factory Supplier([updates(SupplierBuilder b)]) = _$Supplier;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   String toJson() {
//     return json.encode(serializers.serializeWith(Supplier.serializer, this));
//   }

//   static Supplier fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         Supplier.serializer, json.decode(jsonString));
//   }

//   static Serializer<Supplier> get serializer => _$supplierSerializer;
// }
// library rtd_location;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'rtd_location.g.dart';

// abstract class RtdLocation implements Built<RtdLocation, RtdLocationBuilder> {
//   RtdLocation._();

//   factory RtdLocation([updates(RtdLocationBuilder b)]) = _$RtdLocation;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   String toJson() {
//     return json.encode(serializers.serializeWith(RtdLocation.serializer, this));
//   }

//   static RtdLocation fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         RtdLocation.serializer, json.decode(jsonString));
//   }

//   static Serializer<RtdLocation> get serializer => _$rtdLocationSerializer;
// }
// library assigned_to;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'assigned_to.g.dart';

// abstract class AssignedTo implements Built<AssignedTo, AssignedToBuilder> {
//   AssignedTo._();

//   factory AssignedTo([updates(AssignedToBuilder b)]) = _$AssignedTo;

//   @BuiltValueField(wireName: 'id')
//   int get id;
//   @BuiltValueField(wireName: 'username')
//   String get username;
//   @BuiltValueField(wireName: 'name')
//   String get name;
//   @BuiltValueField(wireName: 'first_name')
//   String get firstName;
//   @BuiltValueField(wireName: 'last_name')
//   String get lastName;
//   @BuiltValueField(wireName: 'employee_number')
//   String get employeeNumber;
//   @BuiltValueField(wireName: 'type')
//   String get type;
//   String toJson() {
//     return json.encode(serializers.serializeWith(AssignedTo.serializer, this));
//   }

//   static AssignedTo fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         AssignedTo.serializer, json.decode(jsonString));
//   }

//   static Serializer<AssignedTo> get serializer => _$assignedToSerializer;
// }
// library created_at;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'created_at.g.dart';

// abstract class CreatedAt implements Built<CreatedAt, CreatedAtBuilder> {
//   CreatedAt._();

//   factory CreatedAt([updates(CreatedAtBuilder b)]) = _$CreatedAt;

//   @BuiltValueField(wireName: 'datetime')
//   String get datetime;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json.encode(serializers.serializeWith(CreatedAt.serializer, this));
//   }

//   static CreatedAt fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         CreatedAt.serializer, json.decode(jsonString));
//   }

//   static Serializer<CreatedAt> get serializer => _$createdAtSerializer;
// }
// library updated_at;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'updated_at.g.dart';

// abstract class UpdatedAt implements Built<UpdatedAt, UpdatedAtBuilder> {
//   UpdatedAt._();

//   factory UpdatedAt([updates(UpdatedAtBuilder b)]) = _$UpdatedAt;

//   @BuiltValueField(wireName: 'datetime')
//   String get datetime;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json.encode(serializers.serializeWith(UpdatedAt.serializer, this));
//   }

//   static UpdatedAt fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         UpdatedAt.serializer, json.decode(jsonString));
//   }

//   static Serializer<UpdatedAt> get serializer => _$updatedAtSerializer;
// }
// library last_audit_date;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'last_audit_date.g.dart';

// abstract class LastAuditDate
//     implements Built<LastAuditDate, LastAuditDateBuilder> {
//   LastAuditDate._();

//   factory LastAuditDate([updates(LastAuditDateBuilder b)]) = _$LastAuditDate;

//   @BuiltValueField(wireName: 'datetime')
//   String get datetime;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json
//         .encode(serializers.serializeWith(LastAuditDate.serializer, this));
//   }

//   static LastAuditDate fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         LastAuditDate.serializer, json.decode(jsonString));
//   }

//   static Serializer<LastAuditDate> get serializer => _$lastAuditDateSerializer;
// }
// library next_audit_date;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'next_audit_date.g.dart';

// abstract class NextAuditDate
//     implements Built<NextAuditDate, NextAuditDateBuilder> {
//   NextAuditDate._();

//   factory NextAuditDate([updates(NextAuditDateBuilder b)]) = _$NextAuditDate;

//   @BuiltValueField(wireName: 'date')
//   String get date;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json
//         .encode(serializers.serializeWith(NextAuditDate.serializer, this));
//   }

//   static NextAuditDate fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         NextAuditDate.serializer, json.decode(jsonString));
//   }

//   static Serializer<NextAuditDate> get serializer => _$nextAuditDateSerializer;
// }
// library purchase_date;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'purchase_date.g.dart';

// abstract class PurchaseDate
//     implements Built<PurchaseDate, PurchaseDateBuilder> {
//   PurchaseDate._();

//   factory PurchaseDate([updates(PurchaseDateBuilder b)]) = _$PurchaseDate;

//   @BuiltValueField(wireName: 'date')
//   String get date;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json
//         .encode(serializers.serializeWith(PurchaseDate.serializer, this));
//   }

//   static PurchaseDate fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         PurchaseDate.serializer, json.decode(jsonString));
//   }

//   static Serializer<PurchaseDate> get serializer => _$purchaseDateSerializer;
// }
// library last_checkout;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'last_checkout.g.dart';

// abstract class LastCheckout
//     implements Built<LastCheckout, LastCheckoutBuilder> {
//   LastCheckout._();

//   factory LastCheckout([updates(LastCheckoutBuilder b)]) = _$LastCheckout;

//   @BuiltValueField(wireName: 'datetime')
//   String get datetime;
//   @BuiltValueField(wireName: 'formatted')
//   String get formatted;
//   String toJson() {
//     return json
//         .encode(serializers.serializeWith(LastCheckout.serializer, this));
//   }

//   static LastCheckout fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         LastCheckout.serializer, json.decode(jsonString));
//   }

//   static Serializer<LastCheckout> get serializer => _$lastCheckoutSerializer;
// }
// library available_actions;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'available_actions.g.dart';

// abstract class AvailableActions
//     implements Built<AvailableActions, AvailableActionsBuilder> {
//   AvailableActions._();

//   factory AvailableActions([updates(AvailableActionsBuilder b)]) =
//       _$AvailableActions;

//   @BuiltValueField(wireName: 'checkout')
//   bool get checkout;
//   @BuiltValueField(wireName: 'checkin')
//   bool get checkin;
//   @BuiltValueField(wireName: 'clone')
//   bool get clone;
//   @BuiltValueField(wireName: 'restore')
//   bool get restore;
//   @BuiltValueField(wireName: 'update')
//   bool get update;
//   @BuiltValueField(wireName: 'delete')
//   bool get delete;
//   String toJson() {
//     return json
//         .encode(serializers.serializeWith(AvailableActions.serializer, this));
//   }

//   static AvailableActions fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         AvailableActions.serializer, json.decode(jsonString));
//   }

//   static Serializer<AvailableActions> get serializer =>
//       _$availableActionsSerializer;
// }
