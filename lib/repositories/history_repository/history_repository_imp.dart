import 'package:tms/models/task.dart';
import 'package:tms/repositories/history_repository/history_repository.dart';

class HistoryRepositoryImp extends HistoryRepository{
  @override
  Future<List<Task>> getAllTasksByGroupId(String groupId) async {
    List<Task> taskList = [];
    taskList = await (await database).taskDao.getAllTasksByGroupId(groupId);
    return taskList;
  }

}