import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String name;

  @HiveField(1)
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
    isDone = true;
  }
}
