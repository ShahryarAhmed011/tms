import 'package:tms/models/task.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';

class KanbanBoardRepositoryImp extends KanbanBoardRepository {

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> taskList = [];
    taskList = await (await database).taskDao.getAllTasks();
    return taskList;
  }

  @override
  Future<void> insertTask(Task task) async {
    return await (await database).taskDao.insertTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
     await (await database).taskDao.updateTask(task);
  }

  @override
  Future<Task?> getTask(String groupId, int index) async{
    return await(await database).taskDao.getTask(groupId,index);
  }


  @override
  Future<List<Task>> getAllTasksByGroupId(String groupId) async {
    List<Task> taskList = [];
    taskList = await (await database).taskDao.getAllTasks();
    return taskList;
  }

  @override
  Future<void> deleteAll() async {
    await (await database).taskDao.getAllTasks();
  }

}

