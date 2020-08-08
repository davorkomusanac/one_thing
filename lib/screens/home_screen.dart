import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:one_thing/models/task.dart';
import 'package:one_thing/models/task_data.dart';
import 'package:one_thing/models/toast_message.dart';
import 'package:one_thing/screens/add_task_screen.dart';
import 'package:one_thing/widgets/tasks_list.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ToastMessage toast;
  Task test;

  @override
  void initState() {
    final contactsBox = Hive.box('tasks');
    toast = ToastMessage(context);
    test = contactsBox.get('first') as Task;
    contactsBox.delete('first');
    print(contactsBox.isEmpty.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          if (Provider.of<TaskData>(context, listen: false).isEachTaskDone()) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskScreen(),
                ),
              ),
            );
          } else {
            toast.showToast();
          }
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 30.0),
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: Icon(
                    MdiIcons.numeric1,
                    color: Colors.lightBlueAccent,
                    size: 80.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 16.0, right: 15.0),
              child: ListTile(
                title: Text(
                  'Project Name',
                  style: TextStyle(fontSize: 35.0, color: Colors.white),
                ),
                trailing: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: Transform.scale(
                    scale: 2.0,
                    child: Checkbox(
                        activeColor: Colors.red,
                        value: false,
                        onChanged: (truth) {
                          print('hello');
                        }),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32.0, right: 20.0, bottom: 20.0, top: 5.0),
              child: const Text(
                'What is the One Thing You want to do?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: TasksList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
