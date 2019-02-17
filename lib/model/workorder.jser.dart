// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workorder.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$WorkorderSerializer implements Serializer<Workorder> {
  Serializer<Account> __accountSerializer;
  Serializer<Account> get _accountSerializer =>
      __accountSerializer ??= new AccountSerializer();
  Serializer<ServiceItem> __serviceItemSerializer;
  Serializer<ServiceItem> get _serviceItemSerializer =>
      __serviceItemSerializer ??= new ServiceItemSerializer();
  @override
  Map<String, dynamic> toMap(Workorder model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'createdAt', model.createdAt);
    setMapValue(ret, 'customer', _accountSerializer.toMap(model.customer));
    setMapValue(ret, 'createdBy', model.createdBy);
    setMapValue(
        ret,
        'serviceItems',
        codeIterable(model.serviceItems,
            (val) => _serviceItemSerializer.toMap(val as ServiceItem)));
    setMapValue(ret, 'isDone', model.isDone);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'smOrderId', model.smOrderId);
    return ret;
  }

  @override
  Workorder fromMap(Map map) {
    if (map == null) return null;
    final obj = new Workorder(
        smOrderId: map['smOrderId'] as String ?? getJserDefault('smOrderId'));
    obj.id = map['id'] as String;
    obj.createdAt = map['createdAt'] as int;
    obj.customer = _accountSerializer.fromMap(map['customer'] as Map);
    obj.createdBy = map['createdBy'] as String;
    obj.serviceItems = codeIterable<ServiceItem>(
        map['serviceItems'] as Iterable,
        (val) => _serviceItemSerializer.fromMap(val as Map));
    obj.isDone = map['isDone'] as bool;
    obj.status = map['status'] as String;
    return obj;
  }
}
