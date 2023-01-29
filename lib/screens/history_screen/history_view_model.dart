import 'package:get_it/get_it.dart';
import 'package:tms/core/base/base_view_model.dart';
import 'package:tms/models/task.dart';
import 'package:tms/repositories/history_repository/history_repository.dart';

class HistoryViewModel extends BaseVM{
  HistoryRepository repository = GetIt.I.get<HistoryRepository>();
  List<Task> taskList = [];

  HistoryViewModel(){
    initialize();
  }

  ///Initialize the taskList by calling the getAllTasksByGroupId method from the repository and passing 'Done' as an argument
  ///Then notify the listeners of changes
  initialize() async {
    taskList = await repository.getAllTasksByGroupId('Done');
    notifyListeners();
  }
}
