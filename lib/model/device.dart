import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './employee.dart';

part 'device.jser.dart';

class Device {
  Device({
    this.androidId,
    this.employees,
    this.owner,
    this.currentPosition,
  });
  final String androidId;
  final String owner;
  final List<Employee> employees;
  @pass
  GeoPoint currentPosition;
}

final _passProcessor = const PassProcessor();
Serializer<Employee> __employeeSerializer;
Serializer<Employee> get _employeeSerializer =>
    __employeeSerializer ??= new EmployeeSerializer();
@override
Device fromMap(Map map) {
  if (map == null) return null;
  final obj = new Device(
      androidId: map['androidId'] as String,
      employees: codeIterable<Employee>(map['employees'] as Iterable,
          (val) => _employeeSerializer.fromMap(val as Map)),
      owner: map['owner'] as String);
  obj.currentPosition =
      _passProcessor.deserialize(map['currentPosition']) as GeoPoint;
  return obj;
}

@GenSerializer()
class DeviceSerializer extends Serializer<Device> with _$DeviceSerializer {}
