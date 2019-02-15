// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AvatarSerializer implements Serializer<Avatar> {
  @override
  Map<String, dynamic> toMap(Avatar model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'large', model.large);
    setMapValue(ret, 'small', model.small);
    return ret;
  }

  @override
  Avatar fromMap(Map map) {
    if (map == null) return null;
    final obj = new Avatar(
        large: map['large'] as String ?? getJserDefault('large'),
        small: map['small'] as String ?? getJserDefault('small'));
    return obj;
  }
}

abstract class _$AddressSerializer implements Serializer<Address> {
  @override
  Map<String, dynamic> toMap(Address model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'city', model.city);
    setMapValue(ret, 'state', model.state);
    setMapValue(ret, 'street', model.street);
    setMapValue(ret, 'zip', model.zip);
    return ret;
  }

  @override
  Address fromMap(Map map) {
    if (map == null) return null;
    final obj = new Address();
    obj.city = map['city'] as String;
    obj.state = map['state'] as String;
    obj.street = map['street'] as String;
    obj.zip = map['zip'] as String;
    return obj;
  }
}

abstract class _$EmployeeSerializer implements Serializer<Employee> {
  Serializer<Avatar> __avatarSerializer;
  Serializer<Avatar> get _avatarSerializer =>
      __avatarSerializer ??= new AvatarSerializer();
  @override
  Map<String, dynamic> toMap(Employee model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'avatar', _avatarSerializer.toMap(model.avatar));
    setMapValue(ret, 'currentTimesheetId', model.currentTimesheetId);
    setMapValue(ret, 'clockTimestamp', model.clockTimestamp);
    setMapValue(ret, 'city', model.city);
    setMapValue(ret, 'state', model.state);
    setMapValue(ret, 'fbemployeeid', model.fbemployeeid);
    setMapValue(ret, 'address', model.address);
    setMapValue(ret, 'zip', model.zip);
    setMapValue(ret, 'currentDeviceId', model.currentDeviceId);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'birth_day', model.birth_day);
    setMapValue(ret, 'birth_month', model.birth_month);
    setMapValue(ret, 'work_start_date', model.work_start_date);
    setMapValue(ret, 'email', model.email);
    setMapValue(ret, 'cell_phone', model.cell_phone);
    setMapValue(ret, 'clockedIn', model.clockedIn);
    return ret;
  }

  @override
  Employee fromMap(Map map) {
    if (map == null) return null;
    final obj = new Employee(
        name: map['name'] as String ?? getJserDefault('name'),
        work_start_date: map['work_start_date'] as String ??
            getJserDefault('work_start_date'),
        email: map['email'] as String ?? getJserDefault('email'),
        currentDeviceId: map['currentDeviceId'] as String ??
            getJserDefault('currentDeviceId'));
    obj.id = map['id'] as String;
    obj.avatar = _avatarSerializer.fromMap(map['avatar'] as Map);
    obj.currentTimesheetId = map['currentTimesheetId'] as String;
    obj.clockTimestamp = map['clockTimestamp'] as int;
    obj.city = map['city'] as String;
    obj.state = map['state'] as String;
    obj.fbemployeeid = map['fbemployeeid'] as String;
    obj.address = map['address'] as String;
    obj.zip = map['zip'] as String;
    obj.birth_day = map['birth_day'] as String;
    obj.birth_month = map['birth_month'] as String;
    obj.cell_phone = map['cell_phone'] as String;
    obj.clockedIn = map['clockedIn'] as bool;
    return obj;
  }
}
