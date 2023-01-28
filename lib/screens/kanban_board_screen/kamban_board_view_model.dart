import 'dart:developer';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:get_it/get_it.dart';
import 'package:tms/core/base/base_repository.dart';
import 'package:tms/core/base/base_view_model.dart';
import 'package:tms/core/constants/strings.dart';
import 'package:tms/models/task.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';
import 'package:tms/screens/common_widgets/rich_text_item.dart';

class KanbanBoardViewModel extends BaseVM with BaseRepository {

  // KanbanBoardRepository instance is created to interact with the database
  KanbanBoardRepository repository = GetIt.I.get<KanbanBoardRepository>();

  //List to store tasks
  List<Task> taskList = [];

  //Controller for the Kanban board
  late AppFlowyBoardController controller;

  //Data for the 'To Do' group in the Kanban board
  AppFlowyGroupData group1 =
      AppFlowyGroupData(id: Strings.todo, name: Strings.todo, items: []);

  //Data for the 'In Progress' group in the Kanban board
  AppFlowyGroupData group2 = AppFlowyGroupData(
    id: Strings.inProgress,
    name: Strings.inProgress,
    items: <AppFlowyGroupItem>[],
  );

  //Data for the 'Done' group in the Kanban board
  AppFlowyGroupData group3 = AppFlowyGroupData(
      id: Strings.done, name: Strings.done, items: <AppFlowyGroupItem>[]);

  ///KanbanBoardViewModel constructor function.
  ///Initializes the controller and gets all tasks.
  KanbanBoardViewModel() {
    initController();
    initialize();
  }

  /// Initialize the AppFlowyBoardController with an onMoveGroupItemToGroup callback
  void initController() {
    controller = AppFlowyBoardController(
      onMoveGroupItemToGroup:
          (fromGroupId, fromIndex, toGroupId, toIndex) async {
        // Check if the item is being moved to a different group
        if (fromGroupId != toGroupId) {
          // Get the task from the repository
          Task? task = await getTask(fromGroupId, fromIndex);
          if (task != null) {
            // Update the task's groupId and mIndex
            task.groupId = toGroupId;
            task.mIndex = toIndex;
            // If the task is being moved to the 'To Do' group, set the start time
            if (fromGroupId == 'To Do') {
              task.startTime = appUtil.currentMillisecondsSinceEpoch();
            }
            // Update the task in the repository and update group item in controller
            updateTaskOnMove(fromGroupId, toGroupId, task, fromIndex);
            //log("Selected Task = ${task.groupId} - ${task.taskTitle}");
          } else {
            //log("Task from db is null", name: runtimeType.toString());
          }
          // Notify listeners
          controller.notifyListeners();
          notifyListeners();
        }
      },
    );
    // Add groups to the controller
    controller.addGroup(group1);
    controller.addGroup(group2);
    controller.addGroup(group3);
    // Disable draggable for all groups
    group1.draggable = false;
    group2.draggable = false;
    group3.draggable = false;
  }

  // Function to initialize task list
  initialize() async {
    // Get all tasks from repository
    taskList = await repository.getAllTasks();
    // If task list is not empty
    if (taskList.isNotEmpty) {
      // Iterate through task list
      for (var i = 0; i < taskList.length; i++) {
        Task tsk = taskList[i];

        // Initialize start and spent time strings
        String startString = "00:00:00";
        String spentTimeString = "00:00:00";

        log("Current Time- ${DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch, isUtc: true)}");

        // If task has a start time
        if (tsk.startTime != null) {
          startString = appUtil.format(tsk.startTime!);
          spentTimeString = appUtil.measureTotal(tsk.startTime!);
          log("Task = ${tsk.taskTitle} -Converted StartTimeString- ${startString} --spentTimeStringConverted ${spentTimeString}");
          log("Task = ${tsk.taskTitle} -Converted StartTimeString- ${startString} --spentTimeStringConverted ${spentTimeString}");
        }

        // Insert task into controller at the specified group and index
        controller.insertGroupItem(
            tsk.groupId!,
            tsk.mIndex!,
            RichTextItem(
                title: taskList[i].taskTitle!,
                startTime: startString,
                timeSpent: spentTimeString));
      }
    }
  }

  /// Function to get a task from the repository
  /// @param fromGroupId - The ID of the group the task belongs to
  /// @param fromIndex - The index of the task within the group
  /// @returns - A Future that resolves to the task or null if it does not exist
  Future<Task?> getTask(String fromGroupId, int fromIndex) async {
    var task = await repository.getTask(fromGroupId, fromIndex);
    return task;
  }

  /// This method is used to create a new task and add it to a group.
  ///
  ///  @param groupId The id of the group to which the task should be added.
  ///  @param taskTitle The title of the task that is being created.
  ///  @returns void
  ///
  createTask(String groupId, String taskTitle) async {
    var index = getItemIndexFromGroup(groupId);
    Task task = Task(
      groupId: groupId,
      groupName: controller
          .getGroupController(groupId)
          ?.groupData
          .headerData
          .groupName,
      mIndex: index,
      taskTitle: taskTitle,
    );
    await repository.insertTask(task);
    // taskList.add(task);
    log("GroupId = $groupId and Index = $index", name: "VIEWMODEL");
    controller.insertGroupItem(
        groupId,
        index,
        RichTextItem(
            title: task.taskTitle!,
            startTime: task.startTime.toString(),
            timeSpent: task.timeSpent.toString()));

    notifyListeners();
  }

  /// This function is used to get the index of an item in a group.
  ///
  /// @param groupId The id of the group for which the item index is being retrieved.
  /// @returns int The index of the item in the group. If the group controller is null or the group has no items, returns 0.
  ///
  // Function to get the index of an item in a group
  int getItemIndexFromGroup(String groupId) {
    // Get the group controller for the specified group
    var groupController = controller.getGroupController(groupId);
    // If the group controller is null or the group has no items, return 0
    if (groupController == null || groupController.items.isEmpty) {
      return 0;
    }
    // Otherwise, return the length of the items in the group
    else {
      return groupController.items.length;
    }
  }

  /// Function to update a task
  ///
  /// @param item The RichTextItem that needs to be updated.
  /// @param groupId The id of the group in which the item is located.
  /// @param taskTitle The new title for the task.
  /// @param task The task object that needs to be updated.
  ///
  // Function to update a task
  updateTask(
      RichTextItem item, String groupId, String taskTitle, Task task) async {
    // Get index of item before update
    var indexBeforeUpdate =
        controller.getGroupController(groupId)?.groupData.items.indexOf(item);

    // Update task properties
    task.groupId = groupId;
    task.taskTitle = taskTitle;
    task.mIndex = indexBeforeUpdate;
    String startString = "00:00:00";
    String spentTimeString = "00:00:00";

    // Check if task has a start time
    if (task.startTime != null) {
      // Format start time and calculate spent time
      startString = appUtil.format(task.startTime!);
      spentTimeString = appUtil.measureTotal(task.startTime!);
    }

    // Update task in repository
    await repository.updateTask(task);
    // Remove old item from controller
    controller.removeGroupItem(groupId, item.id);
    // Get last index in group
    var lastIndex = getItemIndexFromGroup(groupId);

    // Insert updated item into controller
    controller.insertGroupItem(
        groupId,
        lastIndex - 1,
        RichTextItem(
            title: task.taskTitle!,
            startTime: startString,
            timeSpent: spentTimeString));

    // Move item to its original position
    controller.moveGroupItem(groupId, lastIndex - 1, indexBeforeUpdate!);
  }

  /// Function to update task on move from one group to another

  /// updateTaskOnMove function updates the task when moved from one group to another
  /// @param {String} fromGroupId - the group id of the group the task is moving from
  /// @param {String} toGroupId - the group id of the group the task is moving to
  ///@param {Task} task - the task that is being moved
  ///@param {int} fromIndex - the index of the task in the group it is moving from
  // Function to update task on move from one group to another
  updateTaskOnMove(
      String fromGroupId, String toGroupId, Task task, int fromIndex) async {
    // Initialize start and spent time strings
    String startString = "00:00:00";
    String spentTimeString = "00:00:00";

    // Check if task has a start time
    if (task.startTime != null) {
      startString = appUtil.format(task.startTime!);
      spentTimeString = appUtil.measureTotal(task.startTime!);
    }

    await repository.updateTask(task);

    // Update group item in controller
    controller.updateGroupItem(
        toGroupId,
        RichTextItem(
            title: task.taskTitle!,
            startTime: startString,
            timeSpent: spentTimeString));

    // Update group task indexes in repository
    await repository.updateGroupTaskIndexes(fromGroupId, fromIndex);
  }
}


