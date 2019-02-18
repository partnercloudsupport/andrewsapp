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

@GenSerializer()
class DeviceSerializer extends Serializer<Device> with _$DeviceSerializer {}
