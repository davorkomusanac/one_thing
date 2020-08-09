import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:one_thing/models/project_name_data.dart';
import 'package:one_thing/models/task.dart';
import 'package:one_thing/models/task_data.dart';
import 'package:one_thing/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_thing/utils/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var box = await Hive.openBox(kTasksBoxName);
  var projectNameBox = await Hive.openBox(kProjectNameBox);
  if (box.get('tasks') == null) {
    box.put('tasks', []);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => ProjectNameData(),
      child: ChangeNotifierProvider(
        create: (context) => TaskData(),
        child: MaterialApp(
          title: 'One Thing',
          theme: ThemeData.light().copyWith(
              appBarTheme: AppBarTheme(
            color: Color(0xff283593),
          )),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
