import 'package:tms/models/task.dart';
import 'package:tms/repositories/history_repository/history_repository.dart';

class HistoryRepositoryImp extends HistoryRepository{

  /// This function fetch all the Task from the database with specific group id
  @override
  Future<List<Task>> getAllTasksByGroupId(String groupId) async {
    List<Task> taskList = [];
    taskList = await (await database).taskDao.getAllTasksByGroupId(groupId);
    return taskList;
  }

}