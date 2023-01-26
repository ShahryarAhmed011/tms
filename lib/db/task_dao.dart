import 'package:floor/floor.dart';
import 'package:tms/models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> getAllTasks();

  @Query('SELECT * FROM Task WHERE id = :id')
  Stream<Task?> findTaskById(int id);

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task task);

  @Query('SELECT * FROM Task WHERE groupId = :groupId AND mIndex = :mIndex')
  Future<Task?> getTask(String groupId,int mIndex);

  @Query('SELECT * FROM Task WHERE groupId = :groupId')
  Future<List<Task>> getAllTasksByGroupId(String groupId);


}