import 'package:floor/floor.dart';
import 'package:tms/db/project_dao.dart';
import 'package:tms/db/task_dao.dart';
import 'package:tms/models/project.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tms/models/task.dart';
part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Project,Task])
abstract class AppDatabase extends FloorDatabase {
  ProjectDao get projectDao;

  TaskDao get taskDao;
}