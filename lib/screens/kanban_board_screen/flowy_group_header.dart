import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:tms/screens/kanban_board_screen/kamban_board_view_model.dart';
import 'package:tms/utils/app_colors.dart';

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
      margin: model.config.groupItemPadding,
    );
  }


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

  ButtonStyle dialogButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: AppColors.secondaryThemeColor,
      foregroundColor: AppColors.primaryTextColor,
      textStyle: const TextStyle(color: Colors.white),
    );
  }

}
