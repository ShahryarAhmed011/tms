import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tms/screens/splash_screen/splash_view.dart';
import 'package:tms/utils/app_colors.dart';
import 'db/app_database.dart';
import 'di/di.dart';
import 'models/task.dart';

final database =  $FloorAppDatabase.databaseBuilder('tms_database.db').build();

void main() async {

  {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primaryThemeColor,
      // navigation bar color
      statusBarColor: AppColors.primaryThemeColor, // status bar color
    ));
    WidgetsFlutterBinding.ensureInitialized();
    await DI.initDI();

    log("Main Method Called");
    Future.delayed(const Duration(seconds: 0),() async{
     //await addData();
    }).then((value)  {
      runApp(MyApp());
    });

  }
}

Future<void> addData() async {
  List<Task> taskList = await (await database).taskDao.getAllTasks();
  log("Data Exist: ${taskList.length}");
  await (await database).taskDao.deleteTasks(taskList);

  Task t1 = Task(groupId: "To Do",mIndex: 0, groupName: "To Do", taskTitle: "T1");
  Task t2 = Task(groupId: "To Do", mIndex: 1,groupName: "To Do", taskTitle: "T2");
  Task t3 = Task(groupId: "To Do",mIndex: 2, groupName: "To Do", taskTitle: "T3");
  Task t4 = Task(groupId: "To Do", mIndex: 3,groupName: "To Do", taskTitle: "T4");
  Task t5 = Task(groupId: "To Do",mIndex: 4, groupName: "To Do", taskTitle: "T5");
  await (await database).taskDao.insertTask(t1);
  await (await database).taskDao.insertTask(t2);
  await (await database).taskDao.insertTask(t3);
  await (await database).taskDao.insertTask(t4);
  await (await database).taskDao.insertTask(t5);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashView());
  }

  @override
  void initState()  {
     checkPermision();
     super.initState();
  }

  Future<void> checkPermision() async {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
        checkPermision();
      }

    if (await Permission.location.isRestricted) {
      await [
        Permission.storage,
      ].request();
      checkPermision();
    }

  }
}
