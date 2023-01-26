
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tms/db/app_database.dart';
import 'package:tms/db/task_dao.dart';

void main() {
  final database =  $FloorAppDatabase.databaseBuilder('tms_database.db').build();

  late TaskDao taskDao;

  setUp(() async {
    taskDao = (await database).taskDao;
  });

  tearDown(() async {
    //await (await database).close();
  });

  test('I want to test if am able to retrieve or not',() async{
    final tasks = await taskDao.getAllTasks();
    expect(tasks, isNotEmpty);
  });

  test('I want to test if am able to retrieve or history',() async{
    final tasks = await taskDao.getAllTasksByGroupId("Done");
    expect(tasks, isNotEmpty);
  });



}