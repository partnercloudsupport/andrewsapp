// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NoteSerializer implements Serializer<Note> {
  @override
  Map<String, dynamic> toMap(Note model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'text', model.text);
    setMapValue(ret, 'type', model.type);
    return ret;
  }

  @override
  Note fromMap(Map map) {
    if (map == null) return null;
    final obj = new Note(
        text: map['text'] as String ?? getJserDefault('text'),
        type: map['type'] as String ?? getJserDefault('type'));
    return obj;
  }
}

abstract class _$TimesheetSerializer implements Serializer<Timesheet> {
  final _passProcessor = const PassProcessor();
  Serializer<Note> __noteSerializer;
  Serializer<Note> get _noteSerializer =>
      __noteSerializer ??= new NoteSerializer();
  @override
  Map<String, dynamic> toMap(Timesheet model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'store', model.store);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'notes',
        codeIterable(model.notes, (val) => _noteSerializer.toMap(val as Note)));
    setMapValue(ret, 'documentID', model.documentID);
    setMapValue(ret, 'employeeId', model.employeeId);
    setMapValue(ret, 'isValid', model.isValid);
    setMapValue(ret, 'created', model.created);
    setMapValue(ret, 'in_timestamp', model.in_timestamp);
    setMapValue(ret, 'inDay', model.inDay);
    setMapValue(ret, 'out_timestamp', model.out_timestamp);
    setMapValue(ret, 'outDay', model.outDay);
    setMapValue(ret, 'inHour', model.inHour);
    setMapValue(ret, 'outHour', model.outHour);
    setMapValue(ret, 'inLocation', _passProcessor.serialize(model.inLocation));
    setMapValue(ret, 'outLocation', model.outLocation);
    setMapValue(ret, 'inDevice', model.inDevice);
    setMapValue(ret, 'outTerminal', model.outTerminal);
    setMapValue(ret, 'fbemployeeid', model.fbemployeeid);
    setMapValue(ret, 'approvedBy', model.approvedBy);
    setMapValue(ret, 'prettyInDay', model.prettyInDay);
    setMapValue(ret, 'prettyInTime', model.prettyInTime);
    setMapValue(ret, 'prettyOutTime', model.prettyOutTime);
    setMapValue(ret, 'prettyOutDay', model.prettyOutDay);
    setMapValue(ret, 'approvedTime', model.approvedTime);
    setMapValue(ret, 'approvedNotes', model.approvedNotes);
    setMapValue(ret, 'outPicture', model.outPicture);
    setMapValue(ret, 'breakTime', model.breakTime);
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
    obj.notes = codeIterable<Note>(
        map['notes'] as Iterable, (val) => _noteSerializer.fromMap(val as Map));
    obj.documentID = map['documentID'] as String;
    obj.employeeId = map['employeeId'] as String;
    obj.isValid = map['isValid'] as bool;
    obj.created = map['created'] as int;
    obj.in_timestamp = map['in_timestamp'] as int;
    obj.inDay = map['inDay'] as int;
    obj.out_timestamp = map['out_timestamp'] as int;
    obj.outDay = map['outDay'] as int;
    obj.inHour = map['inHour'] as int;
    obj.outHour = map['outHour'] as int;
    obj.inLocation = _passProcessor.deserialize(map['inLocation']) as GeoPoint;
    obj.outLocation = map['outLocation'] as String;
    obj.inDevice = map['inDevice'] as String;
    obj.outTerminal = map['outTerminal'] as String;
    obj.fbemployeeid = map['fbemployeeid'] as String;
    obj.approvedBy = map['approvedBy'] as String;
    obj.prettyInDay = map['prettyInDay'] as String;
    obj.prettyInTime = map['prettyInTime'] as String;
    obj.prettyOutTime = map['prettyOutTime'] as String;
    obj.prettyOutDay = map['prettyOutDay'] as String;
    obj.approvedTime = map['approvedTime'] as String;
    obj.approvedNotes = map['approvedNotes'] as String;
    obj.outPicture = map['outPicture'] as String;
    obj.breakTime = map['breakTime'] as String;
    obj.updatedAt = map['updatedAt'] as String;
    return obj;
  }
}
