// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$AssetSerializer implements Serializer<Asset> {
  Serializer<HardwareModel> __hardwareModelSerializer;
  Serializer<HardwareModel> get _hardwareModelSerializer =>
      __hardwareModelSerializer ??= new HardwareModelSerializer();
  Serializer<StatusLabel> __statusLabelSerializer;
  Serializer<StatusLabel> get _statusLabelSerializer =>
      __statusLabelSerializer ??= new StatusLabelSerializer();
  Serializer<Category> __categorySerializer;
  Serializer<Category> get _categorySerializer =>
      __categorySerializer ??= new CategorySerializer();
  Serializer<Manufacturer> __manufacturerSerializer;
  Serializer<Manufacturer> get _manufacturerSerializer =>
      __manufacturerSerializer ??= new ManufacturerSerializer();
  Serializer<Supplier> __supplierDateSerializer;
  Serializer<Supplier> get _supplierDateSerializer =>
      __supplierDateSerializer ??= new SupplierDateSerializer();
  Serializer<AvailableActions> __availableActionsSerializer;
  Serializer<AvailableActions> get _availableActionsSerializer =>
      __availableActionsSerializer ??= new AvailableActionsSerializer();
  @override
  Map<String, dynamic> toMap(Asset model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'assetTag', model.assetTag);
    setMapValue(ret, 'serial', model.serial);
    setMapValue(ret, 'model', _hardwareModelSerializer.toMap(model.model));
    setMapValue(
        ret, 'statusLabel', _statusLabelSerializer.toMap(model.statusLabel));
    setMapValue(ret, 'category', _categorySerializer.toMap(model.category));
    setMapValue(
        ret, 'manufacturer', _manufacturerSerializer.toMap(model.manufacturer));
    setMapValue(ret, 'supplier', _supplierDateSerializer.toMap(model.supplier));
    setMapValue(ret, 'notes', model.notes);
    setMapValue(ret, 'orderNumber', model.orderNumber);
    setMapValue(ret, 'image', model.image);
    setMapValue(ret, 'warrantyMonths', model.warrantyMonths);
    setMapValue(ret, 'warrantyExpires', model.warrantyExpires);
    setMapValue(ret, 'purchaseCost', model.purchaseCost);
    setMapValue(ret, 'checkinCounter', model.checkinCounter);
    setMapValue(ret, 'checkoutCounter', model.checkoutCounter);
    setMapValue(ret, 'requestsCounter', model.requestsCounter);
    setMapValue(ret, 'userCanCheckout', model.userCanCheckout);
    setMapValue(ret, 'availableActions',
        _availableActionsSerializer.toMap(model.availableActions));
    return ret;
  }

  @override
  Asset fromMap(Map map) {
    if (map == null) return null;
    final obj = new Asset();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    obj.assetTag = map['assetTag'] as String;
    obj.serial = map['serial'] as String;
    obj.model = _hardwareModelSerializer.fromMap(map['model'] as Map);
    obj.statusLabel = _statusLabelSerializer.fromMap(map['statusLabel'] as Map);
    obj.category = _categorySerializer.fromMap(map['category'] as Map);
    obj.manufacturer =
        _manufacturerSerializer.fromMap(map['manufacturer'] as Map);
    obj.supplier = _supplierDateSerializer.fromMap(map['supplier'] as Map);
    obj.notes = map['notes'] as String;
    obj.orderNumber = map['orderNumber'] as String;
    obj.image = map['image'] as String;
    obj.warrantyMonths = map['warrantyMonths'] as String;
    obj.warrantyExpires = map['warrantyExpires'] as String;
    obj.purchaseCost = map['purchaseCost'] as String;
    obj.checkinCounter = map['checkinCounter'] as int;
    obj.checkoutCounter = map['checkoutCounter'] as int;
    obj.requestsCounter = map['requestsCounter'] as int;
    obj.userCanCheckout = map['userCanCheckout'] as bool;
    obj.availableActions =
        _availableActionsSerializer.fromMap(map['availableActions'] as Map);
    return obj;
  }
}

abstract class _$HardwareModelSerializer implements Serializer<HardwareModel> {
  @override
  Map<String, dynamic> toMap(HardwareModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  HardwareModel fromMap(Map map) {
    if (map == null) return null;
    final obj = new HardwareModel();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$AvailableActionsSerializer
    implements Serializer<AvailableActions> {
  @override
  Map<String, dynamic> toMap(AvailableActions model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'checkout', model.checkout);
    setMapValue(ret, 'checkin', model.checkin);
    setMapValue(ret, 'clone', model.clone);
    setMapValue(ret, 'restore', model.restore);
    setMapValue(ret, 'update', model.update);
    setMapValue(ret, 'delete', model.delete);
    return ret;
  }

  @override
  AvailableActions fromMap(Map map) {
    if (map == null) return null;
    final obj = new AvailableActions();
    obj.checkout = map['checkout'] as bool;
    obj.checkin = map['checkin'] as bool;
    obj.clone = map['clone'] as bool;
    obj.restore = map['restore'] as bool;
    obj.update = map['update'] as bool;
    obj.delete = map['delete'] as bool;
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

abstract class _$AssignedToSerializer implements Serializer<AssignedTo> {
  @override
  Map<String, dynamic> toMap(AssignedTo model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'username', model.username);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'firstName', model.firstName);
    setMapValue(ret, 'lastName', model.lastName);
    setMapValue(ret, 'employeeNumber', model.employeeNumber);
    setMapValue(ret, 'type', model.type);
    return ret;
  }

  @override
  AssignedTo fromMap(Map map) {
    if (map == null) return null;
    final obj = new AssignedTo();
    obj.id = map['id'] as int;
    obj.username = map['username'] as String;
    obj.name = map['name'] as String;
    obj.firstName = map['firstName'] as String;
    obj.lastName = map['lastName'] as String;
    obj.employeeNumber = map['employeeNumber'] as String;
    obj.type = map['type'] as String;
    return obj;
  }
}

abstract class _$RtdLocationSerializer implements Serializer<RtdLocation> {
  @override
  Map<String, dynamic> toMap(RtdLocation model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  RtdLocation fromMap(Map map) {
    if (map == null) return null;
    final obj = new RtdLocation();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$SupplierDateSerializer implements Serializer<Supplier> {
  @override
  Map<String, dynamic> toMap(Supplier model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  Supplier fromMap(Map map) {
    if (map == null) return null;
    final obj = new Supplier();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$ManufacturerSerializer implements Serializer<Manufacturer> {
  @override
  Map<String, dynamic> toMap(Manufacturer model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  Manufacturer fromMap(Map map) {
    if (map == null) return null;
    final obj = new Manufacturer();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$CategorySerializer implements Serializer<Category> {
  @override
  Map<String, dynamic> toMap(Category model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    return ret;
  }

  @override
  Category fromMap(Map map) {
    if (map == null) return null;
    final obj = new Category();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    return obj;
  }
}

abstract class _$StatusLabelSerializer implements Serializer<StatusLabel> {
  @override
  Map<String, dynamic> toMap(StatusLabel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'name', model.name);
    setMapValue(ret, 'statusType', model.statusType);
    setMapValue(ret, 'statusMeta', model.statusMeta);
    return ret;
  }

  @override
  StatusLabel fromMap(Map map) {
    if (map == null) return null;
    final obj = new StatusLabel();
    obj.id = map['id'] as int;
    obj.name = map['name'] as String;
    obj.statusType = map['statusType'] as String;
    obj.statusMeta = map['statusMeta'] as String;
    return obj;
  }
}
