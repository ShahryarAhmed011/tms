import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/models/task.dart';
import 'package:tms/models/task.dart';
import 'package:tms/screens/kanban_board_screen/kamban_board_view_model.dart';
import 'package:tms/utils/app_colors.dart';

import 'rich_text_item.dart';

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  final KanbanBoardViewModel model;
  final AppFlowyGroupData group;

  const RichTextCard({
    required this.item,
    required this.model,
    required this.group,
    Key? key,
  }) : super(key: key);

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  late Task? task;
  //late Task Task;
  @override
  void initState() {
    getTask();
    super.initState();

  }

  getTask() async{
    int? i = widget.model.controller.getGroupController(widget.group.id)?.groupData.items.indexOf(widget.item);
    if(i!=null){
      task = await widget.model.getTask(widget.group.id, i);
    }
   }

  @override
  Widget build(BuildContext context)  {
    //  int? i = widget.model.controller.getGroupController(widget.group.id)?.groupData.items.indexOf(widget.item);
    //  Task task = widget.model.taskList[i??0];
    //widget.model.getTask(widget.item);



    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildEditButton(context),
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Row(
              children: [

                Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),

                        (widget.group.headerData.groupName == 'To Do')
                            ? Container()
                            : Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Start Time: ${widget.item.startTime}',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black,fontWeight: FontWeight.bold),
                                )),

                        (widget.group.headerData.groupName == 'To Do')?
                        Container():
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Spent: ${widget.item.timeSpent}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black,fontWeight: FontWeight.bold),
                          )
                        )
                      ],
                    )),
              ],

            )
          ],
        ),
      ),
    );
  }

  Row buildEditButton(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                _displayTextInputDialog(context, widget.group, widget.model,task!);
              },
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            )),
      )
    ]);
  }

  Future<void> _displayTextInputDialog(
    BuildContext context,
    AppFlowyGroupData<dynamic> columnData,
    KanbanBoardViewModel model,
    Task task,
  ) async {
    String inputText = "";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Task', style: TextStyle(fontSize: 12)),
            content: TextField(
              onChanged: (value) {
                inputText = value;
              },
              controller: TextEditingController(text: widget.item.title),
              decoration: const InputDecoration(hintText: "Update task"),
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
                child: const Text('Update'),
                onPressed: () {

                  model.updateTask(widget.item,columnData.id, inputText, task);
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
