import 'package:get_it/get_it.dart';
import 'package:tms/core/base/base_view_model.dart';
import 'package:tms/models/task.dart';
import 'package:tms/repositories/task_board_repository/task_board_repository.dart';

class TaskBoardViewModel extends BaseVM{
  TaskBoardRepository repository = GetIt.I.get<TaskBoardRepository>();

  late String _appBarTitle = "Task Board";
  String get appBarTitle => _appBarTitle;

  int _navItemIndex = 0;
  int get navItemIndex => _navItemIndex;

  navigateTo(int itemIndex){
    _navItemIndex = itemIndex;
    if(itemIndex == 0){
      _appBarTitle = "Task Board";
    }else{
      _appBarTitle = "History";
    }
    notifyListeners();
  }

  ///The exportCSV() function is a method that exports data from a list to a CSV file. It first calls the exportList() method from a repository object. Then it returns a string "Exported" to indicate that the export process has been completed successfully.
  String exportCSV()   {
    repository.exportList();
    return "Exported";
  }

  ///This function is called isTaskExist() and it is an asynchronous function that returns a Future of type bool. The function first retrieves a list of Task objects by calling the getAllTasks() method on a repository object. It then checks if the task list is not empty and returns true if it is not, and false if it is. This function can be used to check if there are any tasks present in the system before attempting to export them to a CSV file.
  Future<bool> isTaskExist()  async {
    List<Task> taskList =  await repository.getAllTasks();
    return taskList.isNotEmpty;
  }
}