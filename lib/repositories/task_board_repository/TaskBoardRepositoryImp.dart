import 'package:tms/models/task.dart';
import 'package:tms/repositories/task_board_repository/task_board_repository.dart';

import '../../utils/app_util.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class TaskBoardRepositoryImp extends TaskBoardRepository{
  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> taskList =  await (await database).taskDao.getAllTasks();
    return taskList;
  }

  @override
  exportList() async {
    List<Task> taskList =  await (await database).taskDao.getAllTasks();

    List<String> row = [];
    row.add("Index");
    row.add("Title");
    row.add("Group Id");
    row.add("Start Time");
    row.add("Spent Time");

    List<List<String>> listOfLists = [];
    List<String> list = [];
    for (int i = 0; i < taskList.length; i++) {
      Task task = taskList[i];
      list.add(task.id.toString());
      list.add(task.taskTitle!);
      list.add(task.groupId!);
      list.add(AppUtil().format(task.startTime!));
      list.add(AppUtil().measureTotal(task.startTime!));
    }
    listOfLists.add(list);
    exportCSV.myCSV(row, listOfLists);
  }



}