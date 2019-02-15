import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/device.dart';
import 'package:uuid/uuid.dart';
import 'package:location/location.dart';

part 'timesheet.jser.dart';

class Note {
  Note({
    this.text,
    this.type,
  });

  final String text;
  final String type;
}

class Timesheet {
  String id;
  String store;
  String status;
  List<Note> notes;
  String documentID;
  String employeeId;
  bool isValid;
  int created;

  int in_timestamp;
  int inDay;
  int out_timestamp;
  int outDay;
  int inHour;
  int outHour;
  @pass
  GeoPoint inLocation;
  String outLocation;
  String inDevice;
  String outTerminal;
  String fbemployeeid;
  String approvedBy;
  String prettyInDay;
  String prettyInTime;
  String prettyOutTime;
  String prettyOutDay;
  String approvedTime;
  String approvedNotes;
  String outPicture;
  String breakTime;
  String updatedAt;

  Timesheet({
    this.id,
    this.store,
    this.status,
    this.notes,
    this.created,
    this.in_timestamp,
    this.inDay,
    this.employeeId,
    this.out_timestamp,
    this.outDay,
    this.inHour,
    this.outHour,
    this.prettyInTime,
    this.prettyInDay,
    this.isValid,
    this.prettyOutTime,
    this.prettyOutDay,
    this.inLocation,
    this.outLocation,
    this.fbemployeeid,
    this.outTerminal,
    this.approvedBy,
    this.inDevice,
    this.approvedTime,
    this.approvedNotes,
    this.outPicture,
    this.breakTime,
    this.updatedAt,
  });
}

Timesheet createNewTimesheet(Employee employee, Device device) {
  Timesheet newSheet = new Timesheet();
  DateTime now = new DateTime.now();
  int timestamp = new DateTime.now().millisecondsSinceEpoch;

  now.day;
  newSheet.id = "0";
  newSheet.isValid = false;
  newSheet.store = "0";
  newSheet.status = "1";
  newSheet.notes = new List<Note>();
  newSheet.created = now.millisecondsSinceEpoch;
  newSheet.in_timestamp = timestamp;
  newSheet.inDay = now.day;
  newSheet.employeeId = employee.id;
  newSheet.fbemployeeid = employee.fbemployeeid;
  newSheet.out_timestamp = 0;
  newSheet.outDay = 0;
  newSheet.inHour = now.hour;
  newSheet.outHour = 0;
  newSheet.prettyInTime = "0";
  newSheet.prettyInDay = "0";
  newSheet.prettyOutTime = "0";
  newSheet.prettyOutDay = "0";
  newSheet.inLocation = device.currentPosition;
  newSheet.outLocation = "0";
  newSheet.inDevice = device.androidId;
  newSheet.outTerminal = "0";
  newSheet.approvedBy = "0";
  newSheet.approvedTime = "0";
  newSheet.approvedNotes = "0";
  newSheet.outPicture = "0";
  newSheet.breakTime = "0";
  newSheet.updatedAt = "0";

  return newSheet;
}

@GenSerializer()
class NoteSerializer extends Serializer<Note> with _$NoteSerializer {}

@GenSerializer()
class TimesheetSerializer extends Serializer<Timesheet>
    with _$TimesheetSerializer {}
