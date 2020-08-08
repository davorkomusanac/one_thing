import 'package:flutter/material.dart';
import 'package:one_thing/utils/constants.dart';
import 'package:one_thing/utils/quotes.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:one_thing/models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  Random random;
  int randNum;

  @override
  void initState() {
    random = Random();
    randNum = random.nextInt(quotes.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    String quote;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'What is the One Thing you need to do right NOW?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              //decoration: kAddActivityInputDecoration,
              // maxLength: 30,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
              onSubmitted: (text) {
                if (newTaskTitle != null && newTaskTitle.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskTitle);
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
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskTitle);
                }
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 30.0, bottom: 10.0),
              child: Text(
                quotes[randNum],
                // quote = quotes[2],
                // quotes[2],
                // quotes[Random().nextInt(quotes.length)],
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
