// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_record.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$MaintenanceJobSerializer
    implements Serializer<MaintenanceJob> {
  @override
  Map<String, dynamic> toMap(MaintenanceJob model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  MaintenanceJob fromMap(Map map) {
    if (map == null) return null;
    final obj = new MaintenanceJob();
    obj.id = map['id'] as String;
    obj.name = map['name'] as String;
    return obj;
  }
}
