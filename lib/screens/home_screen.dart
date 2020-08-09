import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:one_thing/models/project_name_data.dart';
import 'package:one_thing/models/task_data.dart';
import 'package:one_thing/models/toast_message.dart';
import 'package:one_thing/screens/add_task_screen.dart';
import 'package:one_thing/utils/constants.dart';
import 'package:one_thing/widgets/card_logo.dart';
import 'package:one_thing/widgets/tasks_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ToastMessage toast;

  @override
  void initState() {
    toast = ToastMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: Consumer<ProjectNameData>(
        builder: (context, projectNameData, child) {
          return FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            onPressed: () {
              //First check if the project has a name or perhaps is it finished, if it is, then let the user add a new project
              if (projectNameData.projectName == 'Project Name' ||
                  projectNameData.isProjectDone) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskScreen(isTaskBeingAdded: false),
                    ),
                  ),
                );

                //Delete all tasks from the previous project, so that the new project starts with a blank list
                Provider.of<TaskData>(context, listen: false).deleteAllTasks();
              } else {
                //Let the user add new tasks -  If the first condition wasn't fulfilled, then the current project is still not complete so tasks can be added
                if (Provider.of<TaskData>(context, listen: false)
                    .isEachTaskDone()) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen(
                          isTaskBeingAdded: true,
                        ),
                      ),
                    ),
                  );
                } else {
                  toast.showToast(
                    "You cannot add a new task until your old one is finished",
                  );
                }
              }
            },
          );
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 30.0,
              ),
              child: LogoCard(),
            ),
            Padding(
              padding: kProjectNamePadding,
              child: Consumer<ProjectNameData>(
                builder: (context, projectNameData, child) {
                  return ListTile(
                    title: Text(
                      projectNameData.projectName,
                      style: TextStyle(
                        decoration: projectNameData.isProjectDone
                            ? TextDecoration.lineThrough
                            : null,
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Transform.scale(
                        scale: 2.0,
                        child: Checkbox(
                          activeColor: Colors.lightBlueAccent[400],
                          value: projectNameData.isProjectDone,
                          onChanged: (status) {
                            //Only let the user check the project checkbox if each task is done and there is at least one task in the list
                            if (!projectNameData.isProjectDone) {
                              if (Provider.of<TaskData>(context, listen: false)
                                      .isEachTaskDone() &&
                                  Provider.of<TaskData>(context, listen: false)
                                      .tasks
                                      .isNotEmpty) {
                                //Show a confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      contentPadding: kAlertDialogPadding,
                                      content: Text(
                                        'Are you completely finished with your project?\n'
                                        'You won\'t be able to add new tasks to this project anymore.',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
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
                                            projectNameData
                                                .updateProjectStatus();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            //A congratulations dialog
                                            showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                  contentPadding:
                                                      kAlertDialogPadding,
                                                  content: Text(
                                                    'Congratulations on finishing your project! 🥳\n'
                                                    'Keep going and start a new project',
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text('Thanks'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                toast.showToast(
                                  "You cannot finish this project until all of your tasks are completed",
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: kSubtitlePadding,
              child: const Text(
                'What is the One Thing You want to do?',
                style: kSubtitleTextStyle,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: kTasksListBoxDecoration,
                child: TasksList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
