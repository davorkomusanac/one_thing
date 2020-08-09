import 'package:flutter/material.dart';
import 'package:one_thing/models/project_name_data.dart';
import 'package:one_thing/utils/constants.dart';
import 'package:one_thing/utils/quotes.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:one_thing/models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  final bool isTaskBeingAdded;
  AddTaskScreen({this.isTaskBeingAdded});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  Random random;
  int randNum;

  @override
  void initState() {
    //Get a random number so that each time the screen is showed to the user, a new random Quote is also showed
    random = Random();
    randNum = random.nextInt(quotes.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: kTasksListBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.isTaskBeingAdded
                  ? 'What is the One Thing you need to do right NOW?'
                  : 'What is the One Thing you WANT to do?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
              onSubmitted: (text) {
                if (newTaskTitle != null && newTaskTitle.isNotEmpty) {
                  //If isTaskBeingAdded is true then add a new task, otherwise add a new project
                  widget.isTaskBeingAdded
                      ? Provider.of<TaskData>(context, listen: false)
                          .addTask(newTaskTitle)
                      : Provider.of<ProjectNameData>(context, listen: false)
                          .addProject(newTaskTitle);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                if (newTaskTitle != null && newTaskTitle.isNotEmpty) {
                  //The same code as onSubmitted, so that the user can enter data with the pressing Enter or clicking the Add button
                  widget.isTaskBeingAdded
                      ? Provider.of<TaskData>(context, listen: false)
                          .addTask(newTaskTitle)
                      : Provider.of<ProjectNameData>(context, listen: false)
                          .addProject(newTaskTitle);
                }
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: kQuotePadding,
              child: Text(
                quotes[randNum],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent[100],
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
