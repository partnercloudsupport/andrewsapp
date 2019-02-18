// import 'package:duration/duration.dart';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  final int id;
  final String name;
  final String assetTag;
  final String serial;
  final Map model;
  final String modelNumber;
  final Map statusLabel;
  final Map category;
  final Map manufacturer;
  final Map supplier;
  final String notes;
  final String orderNumber;
  final String company;
  final Map location;
  final Map rtdLocation;
  final String image;
  final Map assignedTo;
  final String warranty;
  final Map warrantyExpires;
  final Object createdAt;
  final Object updatedAt;
  final Object purchaseDate;
  final Object lastCheckout;
  final Object expectedCheckin;
  final String purchaseCost;
  final bool userCanCheckout;
  final String customFields;
  final Map availableActions;
  final List<String> employeeList;

  const Device({
    this.id,
    this.name,
    this.assetTag,
    this.serial,
    this.model,
    this.modelNumber,
    this.statusLabel,
    this.category,
    this.manufacturer,
    this.supplier,
    this.notes,
    this.orderNumber,
    this.company,
    this.location,
    this.rtdLocation,
    this.image,
    this.assignedTo,
    this.warranty,
    this.warrantyExpires,
    this.createdAt,
    this.updatedAt,
    this.purchaseDate,
    this.lastCheckout,
    this.expectedCheckin,
    this.purchaseCost,
    this.userCanCheckout,
    this.customFields,
    this.availableActions,
    this.employeeList,
  });

  static List<Device> allFromResponse(String response) {
    var decodedJsonDevices = json.decode(response).cast<String, dynamic>();

    return decodedJsonDevices['rows']
        .cast<Map<String, dynamic>>()
        .document((obj) => Device.fromJson(obj))
        .toList()
        .cast<Device>();
  }

  factory Device.fromJson(Map document) {
    var data = document;
    var _assignedTo = data['_assignedTo'];

    if (_assignedTo == null) {
      _assignedTo = {
        'id': null,
        'username': null,
        'name': null,
        'first_name': null,
        'last_name': null,
        'employee_number': null,
        'type': null,
      };
    }
    var _lastCheckout = data['last_checkout'];
    if (_lastCheckout == null) {
      _lastCheckout = {
        'datetime': null,
      };
    }
    var _expectedCheckin = data['expected_checkin'];
    if (_expectedCheckin == null) {
      _expectedCheckin = {
        'datetime': null,
      };
    }
    var _customFields = data['expected_checkin'];
    if (_customFields == null) {
      _customFields = '';
    }
    return new Device(
        id: document['id'],
        name: document['name'],
        assetTag: document['asset_tag'],
        serial: document['serial'],
        model: {
          'id': document['model']['id'],
          'name': document['model']['name'],
        },
        modelNumber: document['model_number'],
        statusLabel: {
          'id': document['status_label']['id'],
          'name': document['status_label']['name'],
          'status_meta': document['status_label']['status_meta']
        },
        category: {
          'id': document['category']['status_meta'],
          'name': document['category']['name']
        },
        manufacturer: {
          'id': document['manufacturer']['statuids_meta'],
          'name': document['manufacturer']['name']
        },
        supplier: {
          'id': document['supplier']['id'],
          'name': document['supplier']['statnameus_meta'],
        },
        notes: document['notes'],
        orderNumber: document['order_number'],
        company: document['company'],
        location: {
          'id': document['model']['status_meta'],
          'name': document['model']['status_meta'],
        },
        rtdLocation: {
          'id': document['model']['status_meta'],
          'name': document['model']['status_meta'],
        },
        image: document['image'],
        assignedTo: _assignedTo,
        warranty: document['warranty'],
        warrantyExpires: document['warranty_expires'],
        createdAt: document['created_at']['datetime'],
        // formatted: document['created_at']['formatted'],
        updatedAt: document['updated_at']['datetime'],
        purchaseDate: document['purchase_date']['date'],
        lastCheckout: _lastCheckout,
        expectedCheckin: _expectedCheckin,
        purchaseCost: document['purchase_cost'],
        userCanCheckout: document['user_can_checkout'],
        customFields: _customFields,
        availableActions: {
          'checkout': document['available_actions']['checkout'],
          'checkin': document['available_actions']['checkin'],
          'clone': document['available_actions']['clone'],
          'update': document['available_actions']['update'],
          'delete': document['available_actions']['delete'],
        });
  }
}
// {
//   id: data['id'],
//   name: data['name'],
//   asset_tag:data['asset_tag'],,
//   serial: data['serial'],,
//   model: {
//     id: data['model']['id'],
//     name: data['model']['name'],
//   },
//   model_number: ['model_number'],
//   status_label: {
//     id: data['status_label']['id'],
//     name: data['status_label']['name'],
//     status_meta: data['status_label']['status_meta']
//   },
//   category: {
//     id: data['category']['status_meta'],
//     name: data['category']['name']
//   },
//   manufacturer: {
//     id: data['manufacturer']['statuids_meta'],
//     name: data['manufacturer']['name']
//   },
//   supplier: {
//     id: data['supplier']['id'],
//     name: data['supplier']['statnameus_meta'],
//   },
//   notes: data['notes'],
//   order_number: data['order_number'],
//   company: data['company'],
//   location: {
//     id: data['model']['status_meta'],
//     name: data['model']['status_meta'],
//   },
//   rtd_location: {
//     id: data['model']['status_meta'],
//     name: data['model']['status_meta'],
//   },
//   image: data['image'],
//   assigned_to: {
//     id: data['assigned_to']['id'],
//     username: data['assigned_to']['username'],
//     name: data['assigned_to']['name'],
//     first_name:data['assigned_to']['first_name'],
//     last_name: data['assigned_to']['last_name'],
//     employee_number: data['assigned_to']['employee_number'],
//     type: data['assigned_to']['type'],
//   },
//   warranty: data['warranty'],
//   warranty_expires: data['warranty_expires'],
//   created_at: {
//     datetime: data['created_at']['datetime'],
//     formatted: data['created_at']['formatted'],
//   },
//   updated_at: {
//     datetime: data['updated_at']['datetime'],
//     formatted: data['updated_at']['formatted'],
//   },
//   purchase_date: {
//     date: data['purchase_date']['status_meta'],
//     formatted: data['purchase_date']['status_meta'],
//   },
//   last_checkout: {
//     datetime: data['last_checkout']['datetime'],
//     formatted: data['last_checkout']['formatted'],
//   },
//   expected_checkin: {
//     date: data['expected_checkin']['date'],
//     formatted: data['expected_checkin']['formatted'],
//   },
//   purchase_cost: data['purchase_cost'],
//   user_can_checkout: data['user_can_checkout'],
//   custom_fields: data['custom_fields'],
//   available_actions: {
//     checkout: data['available_actions']['checkout'],
//     checkin: data['available_actions']['checkin'],
//     clone: data['available_actions']['clone'],
//     update: data['available_actions']['update'],
//     delete: data['available_actions']['delete'],
//   }
// }
