import 'package:meta/meta.dart';
import 'package:meta/meta.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'log.dart';
part 'serviceItem.jser.dart';

class ServiceItem {
  final String smGUID;
  String status;
  String id;
  String smServiceItemId;
  String needsRepair;
  int createdAt;
  String prettyCreatedAt;
  String priority;
  String prettyDueAt;
  String notes;
  final String serviceName;
  final String tagId;
  final String tagColor;
  String intake_notes;
  List<Log> logs;
  final String workorderId;
  int quantity;
  final String smWorkorderId;
  int length;
  int width;
  int price;
  bool hasUrine;
  DateTime dueDateTime;
  final bool isDone;
  final List<Picture> pictures;

  ServiceItem({
    this.id,
    @required this.smGUID,
    @required this.status,
    @required this.createdAt,
    @required this.priority,
    @required this.prettyCreatedAt,
    @required this.prettyDueAt,
    @required this.serviceName,
    @required this.smWorkorderId,
    @required this.tagId,
    @required this.tagColor,
    @required this.workorderId,
    @required this.isDone,
    // @required this.smServiceItemId,
    // @required this.dueDateTime,
    // @required this.notes,
    // @required this.intake_notes,
    // @required this.log,
    // @required this.quantity,
    // @required this.price,
    @required this.hasUrine,
    // @required this.isComplete,
    @required this.pictures,
    // @required this.length,
    // @required this.width,
  });

  getQuantity() {
    return this.length * this.width;
  }

  getPictures() {
    return this.length * this.width;
  }

  getPrice() {
    return (!this.hasUrine)
        ? this.price * this.getQuantity()
        : this.price * this.getQuantity() * 1.5;
  }
}

class Picture {
  String id;
  String url;

  Picture({this.id, this.url});
}

@GenSerializer()
class PictureSerializer extends Serializer<Picture> with _$PictureSerializer {}

@GenSerializer()
class ServiceItemSerializer extends Serializer<ServiceItem>
    with _$ServiceItemSerializer {}
