import 'dart:convert';
import 'package:meta/meta.dart';

class CurrentStatus {
  CurrentStatus(
      {@required this.employee_id,
      this.timeclock_id,
      this.clockin_time,
      this.clockin_date,
      @required this.status,
      this.is_on_break});

  String employee_id;
  String status;
  String timeclock_id;
  String clockin_time;
  String clockin_date;
  String is_on_break;

  static List<CurrentStatus> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['data']
        .cast<Map<String, dynamic>>()
        .map((obj) => CurrentStatus.fromMap(obj))
        .toList()
        .cast<CurrentStatus>();
  }

  static CurrentStatus fromMap(Map map) {
    return new CurrentStatus(
        employee_id: map['employee_id'],
        timeclock_id: map['timeclock_id'],
        clockin_time: map['clockin_time']['time'],
        clockin_date: map['clockin_time']['formatted'],
        is_on_break: map['is_on_break']);
  }
}
