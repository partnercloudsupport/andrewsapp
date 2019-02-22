// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AccountSerializer implements Serializer<Account> {
  Serializer<Address> __addressSerializer;
  Serializer<Address> get _addressSerializer =>
      __addressSerializer ??= new AddressSerializer();
  @override
  Map<String, dynamic> toMap(Account model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'firstName', model.firstName);
    setMapValue(ret, 'smId', model.smId);
    setMapValue(ret, 'lastName', model.lastName);
    setMapValue(ret, 'address', _addressSerializer.toMap(model.address));
    setMapValue(ret, 'address1', model.address1);
    setMapValue(ret, 'city', model.city);
    setMapValue(ret, 'state', model.state);
    setMapValue(ret, 'zip', model.zip);
    setMapValue(ret, 'accountName', model.accountName);
    setMapValue(
        ret, 'phones', codeIterable(model.phones, (val) => val as String));
    return ret;
  }

  @override
  Account fromMap(Map map) {
    if (map == null) return null;
    final obj = new Account();
    obj.firstName = map['firstName'] as String;
    obj.smId = map['smId'] as String;
    obj.lastName = map['lastName'] as String;
    obj.address = _addressSerializer.fromMap(map['address'] as Map);
    obj.address1 = map['address1'] as String;
    obj.city = map['city'] as String;
    obj.state = map['state'] as String;
    obj.zip = map['zip'] as String;
    obj.accountName = map['accountName'] as String;
    obj.phones =
        codeIterable<String>(map['phones'] as Iterable, (val) => val as String);
    return obj;
  }
}

abstract class _$AddressSerializer implements Serializer<Address> {
  @override
  Map<String, dynamic> toMap(Address model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'streetAddress', model.streetAddress);
    setMapValue(ret, 'address1', model.address1);
    setMapValue(ret, 'city', model.city);
    setMapValue(ret, 'state', model.state);
    setMapValue(ret, 'zipcode', model.zipcode);
    setMapValue(ret, 'pretty', model.pretty);
    return ret;
  }

  @override
  Address fromMap(Map map) {
    if (map == null) return null;
    final obj = new Address();
    obj.streetAddress = map['streetAddress'] as String;
    obj.address1 = map['address1'] as String;
    obj.city = map['city'] as String;
    obj.state = map['state'] as String;
    obj.zipcode = map['zipcode'] as String;
    obj.pretty = map['pretty'] as String;
    return obj;
  }
}
