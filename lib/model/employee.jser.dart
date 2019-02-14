// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$EmployeeSerializer implements Serializer<Employee> {
  final _passProcessor = const PassProcessor();
  @override
  Map<String, dynamic> toMap(Employee model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'avatar', model.avatar);
    setMapValue(ret, 'currentDeviceId',
        _passProcessor.serialize(model.currentDeviceId));
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'email', model.email);
    setMapValue(ret, 'clockedIn', model.clockedIn);
    return ret;
  }

  @override
  Employee fromMap(Map map) {
    if (map == null) return null;
    final obj = new Employee(
        avatar: map['avatar']['large'] as String ?? getJserDefault('avatar'),
        name: map['name'] as String ?? getJserDefault('name'),
        email: map['email'] as String ?? getJserDefault('email'),
        currentDeviceId:
            _passProcessor.deserialize(map['currentDeviceId']) as String ??
                getJserDefault('currentDeviceId'));
    obj.id = map['id'] as String;
    obj.cell_phone = map['cell_phone'] as String;
    obj.clockedIn = map['clockedIn'] as bool;
    return obj;
  }
}
