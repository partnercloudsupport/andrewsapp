import 'package:meta/meta.dart';
import 'package:meta/meta.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'log.jser.dart';

class Log {
  String type;
  String userId;
  String timestamp;
  Log({this.type, this.userId, this.timestamp}) {}
}

@GenSerializer()
class LogSerializer extends Serializer<Log> with _$LogSerializer {}
