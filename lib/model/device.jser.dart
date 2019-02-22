// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$DeviceSerializer implements Serializer<Device> {
  final _passProcessor = const PassProcessor();
  Serializer<Employee> __employeeSerializer;
  Serializer<Employee> get _employeeSerializer =>
      __employeeSerializer ??= new EmployeeSerializer();
  @override
  Map<String, dynamic> toMap(Device model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'androidId', model.androidId);
    setMapValue(ret, 'ownerId', model.ownerId);
    setMapValue(
        ret,
        'employees',
        codeIterable(model.employees,
            (val) => _employeeSerializer.toMap(val as Employee)));
    setMapValue(ret, 'currentPosition',
        _passProcessor.serialize(model.currentPosition));
    return ret;
  }

  @override
  Device fromMap(Map map) {
    if (map == null) return null;
    final obj = new Device(
        androidId: map['androidId'] as String ?? getJserDefault('androidId'),
        employees: codeIterable<Employee>(map['employees'] as Iterable,
                (val) => _employeeSerializer.fromMap(val as Map)) ??
            getJserDefault('employees'));
    obj.ownerId = map['ownerId'] as String;
    obj.currentPosition =
        _passProcessor.deserialize(map['currentPosition']) as GeoPoint;
    return obj;
  }
}
