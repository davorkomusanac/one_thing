import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:one_thing/models/task.dart';
import 'dart:collection';
import 'package:one_thing/utils/constants.dart';

class TaskData extends ChangeNotifier {
  Box tasksBox;
  List<Task> _tasks;

  TaskData() {
    tasksBox = Hive.box(kTasksBoxName);
    _tasks = Hive.box(kTasksBoxName).get('tasks').cast<Task>();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    tasksBox.put('tasks', _tasks);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    tasksBox.put('tasks', _tasks);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    tasksBox.put('tasks', _tasks);
    notifyListeners();
  }

  void deleteAllTasks() {
    _tasks = [];
    tasksBox.put('tasks', _tasks);
    notifyListeners();
  }

  bool isEachTaskDone() {
    for (var task in _tasks) {
      if (!task.isDone) {
        return false;
      }
    }
    return true;
  }
}
