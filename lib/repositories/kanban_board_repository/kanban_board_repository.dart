import 'package:tms/core/base/base_repository.dart';
import 'package:tms/models/task.dart';

abstract class KanbanBoardRepository extends BaseRepository{
  Future<List<Task>> getAllTasks();
  Future<void> insertTask(Task task);
  Future<void> updateTask(Task task);
  Future<Task?> getTask(String groupId,int index);
  Future<List<Task>> getAllTasksByGroupId(String groupId);
  Future<void> deleteAll();

}