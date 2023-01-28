import 'dart:developer';

import 'package:tms/models/task.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';

class KanbanBoardRepositoryImp extends KanbanBoardRepository {

  @override
  Future<List<Task>> getAllTasks() async {
    // Initialize an empty list called taskList that will be used to store the retrieved tasks
    List<Task> taskList = [];
    // Wait for the database object to be ready and then wait for the getAllTasks function of the taskDao object to complete
    taskList = await (await database).taskDao.getAllTasks();
    // Return the taskList which contains all the retrieved tasks from the database
    return taskList;
  }


  /// This function insert task into the database
  @override
  Future<void> insertTask(Task task) async {
    return await (await database).taskDao.insertTask(task);
  }

  /// This function updates an existing task in the database
  /// @param task: Task object containing the updated information
  /// @return Future<void>
  @override
  Future<int> updateTask(Task task) async {
     await (await database).taskDao.updateTask(task);
     return 1;
  }

  ///This function retrieves a specific task based on the group ID and index.
  ///@param groupId: The group ID of the task to be retrieved.
  ///@param index: The index of the task within the group.
  ///@return Future<Task?> : Returns a Future containing the task, or null if no task is found.
  @override
  Future<Task?> getTask(String groupId, int index) async{
    return await(await database).taskDao.getTask(groupId,index);
  }

  /// This function retrieves a list of all tasks for a specific group ID.
  ///
  /// @param groupId: The ID of the group for which tasks will be retrieved.
  /// @return Future<List<Task>>: Returns a Future containing a list of tasks that belong to the specified group ID.
  @override
  Future<List<Task>> getAllTasksByGroupId(String groupId) async {
    List<Task> taskList = await (await database).taskDao.getAllTasksByGroupId(groupId);
    return taskList;
  }

  /// This function updates the task indexes for a specific group.
  ///
  /// @param fromGroupId: The group ID for which the task indexes will be updated.
  /// @param fromIndex: The starting index from which the task indexes will be updated.
  /// @return Future<int> : Returns a Future containing the status of the update operation.
  @override
  Future<int> updateGroupTaskIndexes(String fromGroupId, int fromIndex) async {
    int status = 0;
    // Get all tasks for the specified group ID
    List<Task> list = await (await database).taskDao.getAllTasksByGroupId(
        fromGroupId);
    // Iterate through the tasks starting from the specified index
    for (var i = fromIndex; i < list.length; i++) {
      Task task = list[i];
      // Update the task index
      task.mIndex = i;
      // Update the task in the database
      status =  await (await database).taskDao.updateTask(task);
    }
    return status;
  }
}



