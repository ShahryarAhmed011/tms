import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:tms/screens/kanban_board_screen/kamban_board_view_model.dart';
import 'package:tms/utils/app_colors.dart';
import 'package:tms/utils/app_util.dart';

class FlowyGroupHeader extends StatelessWidget {
  final KanbanBoardViewModel model;
  final AppFlowyGroupData<dynamic> columnData;

  const FlowyGroupHeader({
    required this.model,
    required this.columnData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildAppFlowyGroupHeader(context,columnData,model);
  }

  /// This function builds the AppFlowyGroupHeader for the Kanban board.
  /// It takes in the `BuildContext`, `AppFlowyGroupData<dynamic>` and `KanbanBoardViewModel` as arguments.
  /// The function returns an `AppFlowyGroupHeader` widget with the following properties:
  /// `onAddButtonClick` - calls the `_displayTextInputDialog` function when the add button is clicked
  /// `icon` - icon displayed on the header
  /// `title` - title of the group
  /// `addIcon` - add icon displayed on the header
  /// `height` - height of the header
  /// `margin` - margin of the header
  AppFlowyGroupHeader buildAppFlowyGroupHeader(BuildContext context,
      AppFlowyGroupData<dynamic> columnData, KanbanBoardViewModel model) {
    return AppFlowyGroupHeader(
      onAddButtonClick: () {
        if (columnData.headerData.groupName == 'To Do') {
          //  model.addTask(columnData.id);
          _displayTextInputDialog(context, columnData, model);
        }
      },
      icon: const Icon(Icons.pending),
      title: Expanded(
        flex: 1,
        child: SizedBox(
          child: Text(columnData.headerData.groupName),
        ),
      ),
      addIcon: (columnData.headerData.groupName == 'In Progress' ||
              columnData.headerData.groupName == 'Done')
          ? Container()
          : const Icon(Icons.add, size: 30),
      height: 60,
      margin: AppUtil().boardConfig.groupItemPadding,
    );
  }

  /// _displayTextInputDialog is a function that displays a text input dialog where the user can enter a task name
  /// It takes in 3 parameters:
  /// 1. BuildContext context: the context of the widget where the dialog will be shown
  /// 2. AppFlowyGroupData<dynamic> columnData: data of the column where the task will be created
  /// 3. KanbanBoardViewModel model: the view model that will handle the creation of the task
  Future<void> _displayTextInputDialog(BuildContext context,
      AppFlowyGroupData<dynamic> columnData, KanbanBoardViewModel model) async {
    String inputText = "";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create Task', style: TextStyle(fontSize: 12)),
            content: TextField(
              onChanged: (value) {
                inputText = value;
              },
              //  controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Enter something"),
              style: const TextStyle(fontSize: 12),
            ),
            actions: <Widget>[
              TextButton(
                style: dialogButtonStyle(),
                child: const Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: dialogButtonStyle(),
                child: const Text('Create'),
                onPressed: () {
                  model.createTask(columnData.id, inputText);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  /// Function to create button style for dialog
  ButtonStyle dialogButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: AppColors.secondaryThemeColor,
      foregroundColor: AppColors.primaryTextColor,
      textStyle: const TextStyle(color: Colors.white),
    );
  }

}
