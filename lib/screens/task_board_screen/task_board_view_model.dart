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

  String exportCSV()   {
    repository.exportList();
    return "Exported";
  }

  Future<bool> isTaskExist()  async {
    List<Task> taskList =  await repository.getAllTasks();
    return taskList.isNotEmpty;
  }
}