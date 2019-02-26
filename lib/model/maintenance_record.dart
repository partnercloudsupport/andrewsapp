import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:meta/meta.dart';
import 'serviceItem.dart';

part 'maintenance_record.jser.dart';

class MaintenanceRecord {
  String id;
  String createdBy;
  int createdAt;
  String notes;
  final List<Picture> pictures;
  bool needsRepair;
  final int priority;
  bool picturesRequired;
  List<MaintenanceJob> maintenanceNeeded;

  MaintenanceRecord(
      {this.id,
      @required this.createdBy,
      this.notes,
      this.priority,
      this.picturesRequired,
      this.maintenanceNeeded,
      this.needsRepair,
      @required this.pictures,
      @required this.createdAt});
}

class MaintenanceJob {
  String id;
  String name;

  MaintenanceJob({this.id, this.name});
}

@GenSerializer()
class MaintenanceJobSerializer extends Serializer<MaintenanceJob>
    with _$MaintenanceJobSerializer {}
