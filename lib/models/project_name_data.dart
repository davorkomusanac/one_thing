import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:one_thing/utils/constants.dart';

class ProjectNameData extends ChangeNotifier {
  Box projectNameBox;
  String projectName;
  bool isProjectDone;

  ProjectNameData() {
    projectNameBox = Hive.box(kProjectNameBox);
    projectNameBox.isEmpty
        ? projectName = 'Project Name'
        : projectName = projectNameBox.keyAt(0) as String;
    projectNameBox.isEmpty
        ? isProjectDone = false
        : isProjectDone = projectNameBox.getAt(0) as bool;
  }

  void addProject(String project) {
    if (projectNameBox.isNotEmpty) {
      projectNameBox.deleteAt(0);
    }
    projectName = project;
    isProjectDone = false;
    projectNameBox.put(projectName, isProjectDone);
    notifyListeners();
  }

  void updateProjectStatus() {
    isProjectDone = true;
    projectNameBox.putAt(0, isProjectDone);
    notifyListeners();
  }
}
