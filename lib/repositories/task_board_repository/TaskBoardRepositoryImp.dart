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

///  overrides a method called exportList. The function begins by asynchronously fetching a list of tasks from a database using the taskDao.getAllTasks() method. The function is marked with @override annotation which indicates that this function is intended to override a function with the same name in a parent class or in an interface.
///  Next, the function creates a list called row and adds the headers "Index", "Title", "Group Id", "Start Time", and "Spent Time" to it. This list will be used as the headers for a CSV file that will be exported later on.
///  Then, the function creates an empty list called listOfLists and another empty list called list. The function then uses a for loop to iterate over each task in the taskList and adds the task's properties to the list such as task.id, task.taskTitle, task.groupId, task.startTime and task.startTime by calling AppUtil() function which format and measure total time.
///  Finally, the list is added to listOfLists and the exportCSV.myCSV(row, listOfLists) method is called to export the CSV file with headers from row and data from listOfLists.
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