import 'package:flutter/material.dart';
import 'package:one_thing/utils/constants.dart';
import 'package:one_thing/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:one_thing/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[taskData.taskCount - 1 - index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              longPressCallback: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        contentPadding: kAlertDialogPadding,
                        content: Text(
                          'Are you sure you want to delete this task?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        actions: [
                          FlatButton(
                            child: Text('NO'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('YES'),
                            onPressed: () {
                              taskData.deleteTask(task);
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
