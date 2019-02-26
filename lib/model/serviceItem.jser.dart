// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceItem.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$PictureSerializer implements Serializer<Picture> {
  @override
  Map<String, dynamic> toMap(Picture model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'url', model.url);
    return ret;
  }

  @override
  Picture fromMap(Map map) {
    if (map == null) return null;
    final obj = new Picture();
    obj.id = map['id'] as String;
    obj.url = map['url'] as String;
    return obj;
  }
}

abstract class _$ServiceItemSerializer implements Serializer<ServiceItem> {
  Serializer<Picture> __pictureSerializer;
  Serializer<Picture> get _pictureSerializer =>
      __pictureSerializer ??= new PictureSerializer();
  @override
  Map<String, dynamic> toMap(ServiceItem model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'smGUID', model.smGUID);
    setMapValue(ret, 'status', model.status);
    setMapValue(ret, 'id', model.id);
    setMapValue(ret, 'smServiceItemId', model.smServiceItemId);
    setMapValue(ret, 'needsRepair', model.needsRepair);
    setMapValue(ret, 'createdAt', model.createdAt);
    setMapValue(ret, 'prettyCreatedAt', model.prettyCreatedAt);
    setMapValue(ret, 'priority', model.priority);
    setMapValue(ret, 'createdById', model.createdById);
    setMapValue(ret, 'createdByName', model.createdByName);
    setMapValue(ret, 'prettyDueAt', model.prettyDueAt);
    setMapValue(ret, 'notes', model.notes);
    setMapValue(ret, 'serviceName', model.serviceName);
    setMapValue(ret, 'tagId', model.tagId);
    setMapValue(ret, 'tagColor', model.tagColor);
    setMapValue(ret, 'primaryPictureUrl', model.primaryPictureUrl);
    setMapValue(ret, 'intake_notes', model.intake_notes);
    setMapValue(ret, 'workorderId', model.workorderId);
    setMapValue(ret, 'quantity', model.quantity);
    setMapValue(ret, 'smWorkorderId', model.smWorkorderId);
    setMapValue(ret, 'length', model.length);
    setMapValue(ret, 'width', model.width);
    setMapValue(ret, 'price', model.price);
    setMapValue(ret, 'hasUrine', model.hasUrine);
    setMapValue(
        ret, 'dueDateTime', dateTimeUtcProcessor.serialize(model.dueDateTime));
    setMapValue(ret, 'isDone', model.isDone);
    setMapValue(
        ret,
        'pictures',
        codeIterable(
            model.pictures, (val) => _pictureSerializer.toMap(val as Picture)));
    return ret;
  }

  @override
  ServiceItem fromMap(Map map) {
    if (map == null) return null;
    final obj = new ServiceItem(
        smGUID: map['smGUID'] as String ?? getJserDefault('smGUID'),
        serviceName:
            map['serviceName'] as String ?? getJserDefault('serviceName'),
        smWorkorderId:
            map['smWorkorderId'] as String ?? getJserDefault('smWorkorderId'),
        tagId: map['tagId'] as String ?? getJserDefault('tagId'),
        tagColor: map['tagColor'] as String ?? getJserDefault('tagColor'),
        workorderId:
            map['workorderId'] as String ?? getJserDefault('workorderId'),
        pictures: codeIterable<Picture>(map['pictures'] as Iterable,
                (val) => _pictureSerializer.fromMap(val as Map)) ??
            getJserDefault('pictures'));
    obj.status = map['status'] as String;
    obj.id = map['id'] as String;
    obj.smServiceItemId = map['smServiceItemId'] as String;
    obj.needsRepair = map['needsRepair'] as bool;
    obj.createdAt = map['createdAt'] as int;
    obj.prettyCreatedAt = map['prettyCreatedAt'] as String;
    obj.priority = map['priority'] as String;
    obj.createdById = map['createdById'] as String;
    obj.createdByName = map['createdByName'] as String;
    obj.prettyDueAt = map['prettyDueAt'] as String;
    obj.notes = map['notes'] as String;
    obj.primaryPictureUrl = map['primaryPictureUrl'] as String;
    obj.intake_notes = map['intake_notes'] as String;
    obj.quantity = map['quantity'] as int;
    obj.length = map['length'] as int;
    obj.width = map['width'] as int;
    obj.price = map['price'] as int;
    obj.hasUrine = map['hasUrine'] as bool;
    obj.dueDateTime =
        dateTimeUtcProcessor.deserialize(map['dueDateTime'] as String);
    obj.isDone = map['isDone'] as bool;
    return obj;
  }
}
