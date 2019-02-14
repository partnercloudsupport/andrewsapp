import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'timesheet.jser.dart';


class Timesheet {
  String id;
  String store;
  String status;
  String notes;
  String created;
  String employeeId;
  String inTimestamp;
  String inDay;
  String outTimestamp;
  String outDay;
  String inHour;
  String outHour;
  String inLocation;
  String outLocation;
  String inTerminal;
  String outTerminal;
  String approvedBy;
  String prettyInDay;
  String prettyInTime;
  String prettyOutTime;
  String prettyOutDay;
  String approvedTime;
  String approvedNotes;
  String outPicture;
  String cell_phone;
  String breakTime;
  String startTimestamp;
  String endTimestamp;
  String createdAt;
  String updatedAt;

  Timesheet(
      {this.id,
      this.cell_phone,
      this.store,
      this.status,
      this.notes,
      this.created,
      this.inTimestamp,
      this.inDay,
      this.employeeId,
      this.outTimestamp,
      this.outDay,
      this.inHour,
      this.outHour,
      this.prettyInTime,
      this.prettyInDay,
  this.prettyOutTime,
      this.prettyOutDay,
      this.inLocation,
      this.outLocation,
      this.inTerminal,
      this.outTerminal,
      this.approvedBy,
      this.approvedTime,
      this.approvedNotes,
      this.outPicture,
      this.breakTime,
      this.startTimestamp,
      this.endTimestamp,
      this.createdAt,
      this.updatedAt,
      });

  Timesheet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    store = json['store'];
    status = json['status'];
    notes = json['notes'];
    created = json['created'];
    employeeId = json['employeeId'];
    inTimestamp = json['in_timestamp'];
    outTimestamp = json['out_timestamp'];
    outDay = json['out_day'];
    inHour = json['in_hour'];
    inDay = json['in_day'];

    outHour = json['out_hour'];
    inLocation = json['in_location'];
    outLocation = json['out_location'];
    inTerminal = json['in_terminal'];
    outTerminal = json['out_terminal'];
    approvedBy = json['approved_by'];
    approvedTime = json['approved_time'];
    approvedNotes = json['approved_notes'];
    outPicture = json['out_picture'];
    breakTime = json['break_time'];
    startTimestamp = json['start_timestamp'];
    endTimestamp = json['end_timestamp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store'] = this.store;
    data['status'] = this.status;
    data['notes'] = this.notes;
    data['created'] = this.created;
    data['in_timestamp'] = this.inTimestamp;
    data['in_day'] = this.inDay;
    data['out_timestamp'] = this.outTimestamp;
    data['out_day'] = this.outDay;
    data['in_hour'] = this.inHour;
    data['out_hour'] = this.outHour;
    data['in_location'] = this.inLocation;
    data['out_location'] = this.outLocation;

    data['in_terminal'] = this.inTerminal;
    data['out_terminal'] = this.outTerminal;
    data['approved_by'] = this.approvedBy;
    data['approved_time'] = this.approvedTime;
    data['approved_notes'] = this.approvedNotes;
    data['out_picture'] = this.outPicture;
    data['break_time'] = this.breakTime;
    data['start_timestamp'] = this.startTimestamp;
    data['end_timestamp'] = this.endTimestamp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


@GenSerializer()
class TimesheetSerializer extends Serializer<Timesheet> with _$TimesheetSerializer {}