// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$LogSerializer implements Serializer<Log> {
  @override
  Map<String, dynamic> toMap(Log model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'type', model.type);
    setMapValue(ret, 'userId', model.userId);
    setMapValue(ret, 'timestamp', model.timestamp);
    return ret;
  }

  @override
  Log fromMap(Map map) {
    if (map == null) return null;
    final obj = new Log();
    obj.type = map['type'] as String;
    obj.userId = map['userId'] as String;
    obj.timestamp = map['timestamp'] as String;
    return obj;
  }
}
