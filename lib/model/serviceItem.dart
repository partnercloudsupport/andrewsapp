import 'package:meta/meta.dart';
import 'package:meta/meta.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'serviceItem.jser.dart';

class ServiceItem {
  final String smGUID;
  String id;
  String documentID;
  String smServiceItemId;
  String notes;
  final String serviceName;
  final String tagId;
  final String tagColor;
  String intake_notes;
  String log;
  final String workOrderId;
  int quantity;
  int length;
  int width;
  int price;
  bool hasUrine;
  DateTime dueDateTime;
  final bool isDone;
  final List<String> pictures;

  ServiceItem({
    @required this.id,
    @required this.smGUID,
    @required this.serviceName,
    @required this.tagId,
    @required this.tagColor,
    @required this.workOrderId,
    @required this.isDone,
    // @required this.smServiceItemId,
    // @required this.dueDateTime,
    // @required this.notes,
    // @required this.intake_notes,
    // @required this.log,
    // @required this.quantity,
    // @required this.price,
    // @required this.hasUrine,
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

@GenSerializer()
class ServiceItemSerializer extends Serializer<ServiceItem>
    with _$ServiceItemSerializer {}
