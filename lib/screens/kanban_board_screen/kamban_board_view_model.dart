import 'dart:developer';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tms/core/base/base_view_model.dart';
import 'package:tms/models/task.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';
import 'package:tms/screens/common_widgets/rich_text_item.dart';

class KanbanBoardViewModel extends BaseVM {
  KanbanBoardRepository repository = GetIt.I.get<KanbanBoardRepository>();
  List<Task> taskList = [];
  List<Task> todoTasksList = [];
  List<Task> inProgressTasksList = [];
  List<Task> doneTasksList = [];

  // DateFormat formatter = DateFormat('HH:mm:ss a');

  final config = const AppFlowyBoardConfig(
      groupBackgroundColor:
          Color(0xfff4f5f7) //Color(0xff898F9C) , //Color(0xffF7F8FC)
      );
  AppFlowyBoardScrollController boardController =
      AppFlowyBoardScrollController();

  late AppFlowyBoardController controller;

  KanbanBoardViewModel() {
    initialize();
  }

  initialize() async {
    await initController();
    taskList = await repository.getAllTasks();
    AppFlowyGroupData? group1;
    AppFlowyGroupData? group2;
    AppFlowyGroupData? group3;
    group1 = AppFlowyGroupData(id: "To Do", name: "To Do", items: []);
    group2 = AppFlowyGroupData(
      id: "In Progress",
      name: "In Progress",
      items: <AppFlowyGroupItem>[],
    );
    group3 = AppFlowyGroupData(
        id: "Done", name: "Done", items: <AppFlowyGroupItem>[]);

    controller.addGroup(group1);
    controller.addGroup(group2);
    controller.addGroup(group3);
    group1.draggable = false;
    group2.draggable = false;
    group3.draggable = false;

    if (taskList.isNotEmpty) {
      for (var i = 0; i < taskList.length; i++) {
        Task tsk = taskList[i];

        String startString = "00:00:00";
        String spentTimeString = "00:00:00";

        log("Current Time- ${DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch, isUtc: true)}");

        if (tsk.startTime != null) {
          startString = appUtil.format(tsk.startTime!);
          spentTimeString = appUtil.measureTotal(tsk.startTime!);
          log("Task = ${tsk.taskTitle} -Converted StartTimeString- ${startString} --spentTimeStringConverted ${spentTimeString}");
          log("Task = ${tsk.taskTitle} -Converted StartTimeString- ${startString} --spentTimeStringConverted ${spentTimeString}");
        }

        controller.insertGroupItem(
            tsk.groupId!,
            tsk.mIndex!,
            RichTextItem(
                title: taskList[i].taskTitle!,
                startTime: startString,
                timeSpent: spentTimeString));
      }
    }

    notifyListeners();
  }

//  log("onMoveGroupItemToGroup ", name: "ViewModel");
  Future<void> initController() async {
    controller = AppFlowyBoardController(
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        log("onMoveGroup fromGroupId $fromGroupId toGroupId $toGroupId Group Item Moved fromIndex ${fromIndex} toIndex ${toIndex}");
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        //log("Group Item Moved fromIndex ${fromIndex} toIndex ${toIndex}");
      },
      onMoveGroupItemToGroup:
          (fromGroupId, fromIndex, toGroupId, toIndex) async {
        if (fromGroupId != toGroupId) {
          Task? task = await getTask(fromGroupId, fromIndex);

          if (task != null) {
            task.groupId = toGroupId;
            task.mIndex = toIndex;
            if (fromGroupId == 'To Do') {
              task.startTime = appUtil.currentMillisecondsSinceEpoch();
            }
            log("UpdateOnMove = ${task.groupId} - ${task.taskTitle}");

            updateTaskOnMove(fromGroupId, toGroupId, task);

            log("Selected Task = ${task.groupId} - ${task.taskTitle}");
          } else {
            log("Task from db is null", name: runtimeType.toString());
          }
          controller.notifyListeners();
          notifyListeners();
        }
      },
    );

    controller.addListener(() {});
  }

  Future<Task?> getTask(String fromGroupId, int fromIndex) async {
    var task = await repository.getTask(fromGroupId, fromIndex);
    return task;
  }

  formatDuration(Duration d) => d.toString().split('.').first.padLeft(8, "0");

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

  int getItemIndexFromGroup(String groupId) {
    var groupController = controller.getGroupController(groupId);
    if (groupController == null || groupController.items.isEmpty) {
      return 0;
    } else {
      return groupController.items.length;
    }
  }

  updateTask(
      RichTextItem item, String groupId, String taskTitle, Task task) async {
    var indexBeforeUpdate =
        controller.getGroupController(groupId)?.groupData.items.indexOf(item);
    task.groupId = groupId;
    task.taskTitle = taskTitle;
    task.mIndex = indexBeforeUpdate;
    String startString = "00:00:00";
    String spentTimeString = "00:00:00";
    if (task.startTime != null) {
      startString = appUtil.format(task.startTime!);
      spentTimeString = appUtil.measureTotal(task.startTime!);
    }
    await repository.updateTask(task);

    controller.removeGroupItem(groupId, item.id);
    var lastIndex = getItemIndexFromGroup(groupId);

    log("previous index ${indexBeforeUpdate} item index ${lastIndex - 1}");
    controller.insertGroupItem(
        groupId,
        lastIndex - 1,
        RichTextItem(
            title: task.taskTitle!,
            startTime: startString,
            timeSpent: spentTimeString));

    controller.moveGroupItem(groupId, lastIndex - 1, indexBeforeUpdate!);
  }

  updateTaskOnMove(String fromGroupId, String toGroupId, Task task) async {
    String startString = "00:00:00";
    String spentTimeString = "00:00:00";
    if (task.startTime != null) {
      startString = appUtil.format(task.startTime!);
      spentTimeString = appUtil.measureTotal(task.startTime!);
    }
    await repository.updateTask(task);
    controller.updateGroupItem(
        toGroupId,
        RichTextItem(
            title: task.taskTitle!,
            startTime: startString,
            timeSpent: spentTimeString));
  }
}


