import 'package:meta/meta.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:flutter/material.dart';
import './account.dart';
import './serviceItem.dart';

part 'workorder.jser.dart';

class Workorder {
  String id;
  int createdAt;
  @required
  Account customer;
  @required
  String createdBy;
  @required
  List<ServiceItem> serviceItems;
  @required
  bool isDone;
  // @required int creationTimestamp;
  @required
  String status;
  @required
  String smOrderId;

  Workorder({this.customer, this.smOrderId});

  getColor() {
    if (this.status == 'Active') {
      return Colors.green[600];
    } else {
      return Colors.grey;
    }
  }
}

@GenSerializer()
class WorkorderSerializer extends Serializer<Workorder>
    with _$WorkorderSerializer {}
