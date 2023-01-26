import 'package:tms/core/base/base_repository.dart';
import 'package:tms/models/task.dart';

abstract class TaskBoardRepository extends BaseRepository{
  Future<List<Task>> getAllTasks();
  exportList();
}