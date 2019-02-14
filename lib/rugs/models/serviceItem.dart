import 'package:meta/meta.dart';

class ServiceItem {
  final String smGUID;
  final String smServiceItemId;
  String notes;
  String intake_notes;
  String log;
  final int quantity;
  int length;
  int width;
  final int price;
  bool hasUrine;
  DateTime dueDateTime;
  final bool isComplete;
  List<String> pictures;

  ServiceItem({
    @required this.smGUID,
    @required this.smServiceItemId,
    @required this.dueDateTime,
    @required this.notes,
    @required this.intake_notes,
    @required this.log,
    @required this.quantity,
    @required this.price,
    @required this.hasUrine,
    @required this.isComplete,
    @required this.pictures,
    @required this.length,
    @required this.width,
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
