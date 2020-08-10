import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:one_thing/models/task.dart';
import 'package:one_thing/utils/constants.dart';

class ProjectNameData extends ChangeNotifier {
  Box projectNameBox;
  String projectName;
  bool isProjectDone;

  ProjectNameData() {
    projectNameBox = Hive.box(kProjectNameBox);
    projectNameBox.isEmpty
        ? projectName = 'Project Name'
        : projectName = projectNameBox.getAt(0).name as String;
    projectNameBox.isEmpty
        ? isProjectDone = false
        : isProjectDone = projectNameBox.getAt(0).isDone as bool;
  }

  void addProject(String project) {
    if (projectNameBox.isNotEmpty) {
      projectNameBox.deleteAt(0);
    }
    projectName = project;
    isProjectDone = false;
    var task = Task(name: projectName);
    projectNameBox.add(task);
    notifyListeners();
  }

  void updateProjectStatus() {
    isProjectDone = true;
    var task = Task(name: projectName);
    task.toggleDone();
    projectNameBox.putAt(0, task);
    notifyListeners();
  }
}
