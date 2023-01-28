import 'package:floor/floor.dart';
import 'package:tms/db/project_dao.dart';
import 'package:tms/db/task_dao.dart';
import 'package:tms/models/project.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tms/models/task.dart';
part 'app_database.g.dart'; // the generated code will be there

/// Database class that uses [Floor] library to manage the database
/// entities of the TMS app.
///
/// [version] is set to 1.
///
/// [entities] is set to a list of [Project] and [Task].
@Database(version: 1, entities: [Project,Task])
abstract class AppDatabase extends FloorDatabase {
  /// Returns the [ProjectDao] object for the app.
  ProjectDao get projectDao;

  /// Returns the [TaskDao] object for the app.
  TaskDao get taskDao;
}