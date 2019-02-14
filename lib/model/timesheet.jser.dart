// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$TimesheetSerializer implements Serializer<Timesheet> {
  @override
  Map<String, dynamic> toMap(Timesheet model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'store', model.store);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'notes', model.notes);
    setMapValue(ret, 'created', model.created);
    setMapValue(ret, 'inTimestamp', model.inTimestamp);
    setMapValue(ret, 'inDay', model.inDay);
    setMapValue(ret, 'outTimestamp', model.outTimestamp);
    setMapValue(ret, 'outDay', model.outDay);
    setMapValue(ret, 'inHour', model.inHour);
    setMapValue(ret, 'outHour', model.outHour);
    setMapValue(ret, 'inLocation', model.inLocation);
    setMapValue(ret, 'outLocation', model.outLocation);
    setMapValue(ret, 'inTerminal', model.inTerminal);
    setMapValue(ret, 'outTerminal', model.outTerminal);
    setMapValue(ret, 'approvedBy', model.approvedBy);
    setMapValue(ret, 'approvedTime', model.approvedTime);
    setMapValue(ret, 'approvedNotes', model.approvedNotes);
    setMapValue(ret, 'outPicture', model.outPicture);
    setMapValue(ret, 'breakTime', model.breakTime);
    setMapValue(ret, 'startTimestamp', model.startTimestamp);
    setMapValue(ret, 'endTimestamp', model.endTimestamp);
    setMapValue(ret, 'createdAt', model.createdAt);
    setMapValue(ret, 'updatedAt', model.updatedAt);
    return ret;
  }

  @override
  Timesheet fromMap(Map map) {
    if (map == null) return null;
    final obj = new Timesheet();
    obj.id = map['id'] as String;
    obj.store = map['store'] as String;
    obj.status = map['status'] as String;
    obj.notes = map['notes'] as String;
    obj.employeeId = map['employeeId'] as String;
    obj.created = map['created'] as String;
    obj.inTimestamp = map['inTimestamp'] as String;
    obj.inDay = map['inDay'] as String;
    obj.cell_phone = map['cell_phone'] as String;
    obj.prettyInDay = map['in_time']['day'] as String;
    obj.prettyInTime = map['in_time']['time'] as String;
       obj.prettyOutDay = map['out_time']['day'] as String;
    obj.prettyOutTime = map['out_time']['time'] as String;
    obj.outTimestamp = map['outTimestamp'] as String;
    obj.outDay = map['outDay'] as String;
    obj.inHour = map['inHour'] as String;
    obj.outHour = map['outHour'] as String;
    obj.inLocation = map['inLocation'] as String;
    obj.outLocation = map['outLocation'] as String;
    obj.inTerminal = map['inTerminal'] as String;
    obj.outTerminal = map['outTerminal'] as String;
    obj.approvedBy = map['approvedBy'] as String;
    obj.approvedTime = map['approvedTime'] as String;
    obj.approvedNotes = map['approvedNotes'] as String;
    obj.outPicture = map['outPicture'] as String;
    obj.breakTime = map['breakTime'] as String;
    obj.startTimestamp = map['startTimestamp'] as String;
    obj.endTimestamp = map['endTimestamp'] as String;
    obj.createdAt = map['createdAt'] as String;
    obj.updatedAt = map['updatedAt'] as String;
    return obj;
  }
}
