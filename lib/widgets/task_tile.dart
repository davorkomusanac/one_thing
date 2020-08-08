import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longPressCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: ListTile(
        onLongPress: longPressCallback,
        title: Text(
          taskTitle,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
              fontSize: 22.0,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.w500),
        ),
        trailing: Transform.scale(
          scale: 1.5,
          child: Checkbox(
            activeColor: Colors.lightBlueAccent,
            value: isChecked,
            onChanged: checkboxCallback,
          ),
        ),
      ),
    );
  }
}
