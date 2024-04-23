import 'package:hive_flutter/hive_flutter.dart';

part'message.g.dart';

@HiveType(typeId: 1)
class Message {
  Message({required this.text, required this.timestamp, required this.id});

  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final int id;

  @override
  String toString() {
    return '$text: $timestamp : $id';
  }
}
