
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:tms/core/constants/strings.dart';
import 'package:tms/db/app_database.dart';
import 'package:tms/db/task_dao.dart';
import 'package:tms/models/task.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository_imp.dart';

void main() {
  final database =  $FloorAppDatabase.databaseBuilder('tms_database.db').build();
  late TaskDao taskDao;

  setUp(() async {
    taskDao = (await database).taskDao;
  });

  KanbanBoardRepository kanbanBoardRepository = KanbanBoardRepositoryImp();

  tearDown(() async {
    //await (await database).close();
  });





}