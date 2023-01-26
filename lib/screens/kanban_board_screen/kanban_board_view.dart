import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/models/task.dart';
import 'package:tms/screens/common_widgets/rich_text_card.dart';
import 'package:tms/screens/common_widgets/rich_text_item.dart';
import 'package:tms/screens/kanban_board_screen/kamban_board_view_model.dart';

import 'flowy_group_header.dart';

class KanbanBoardView extends StatelessWidget {
  const KanbanBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KanbanBoardViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(child: buildAppFlowyBoard(model)),
                  ))
            ],
          ),
        );
      },
      viewModelBuilder: () => KanbanBoardViewModel(),
    );
  }

  AppFlowyBoard buildAppFlowyBoard(KanbanBoardViewModel model) {
    return AppFlowyBoard(
        controller: model.controller,
        cardBuilder: (context, group, groupItem)  {

          return AppFlowyGroupCard(
            key: ValueKey(groupItem.id),

            child: _buildCard(groupItem, group, model),
          );
        },
        boardScrollController: model.boardController,
        headerBuilder: (context, columnData) {
          return FlowyGroupHeader(columnData: columnData, model: model);
        },

        groupConstraints: const BoxConstraints.tightFor(width: 300),
        config: model.config);
  }

  Widget _buildCard(AppFlowyGroupItem item, AppFlowyGroupData group,
      KanbanBoardViewModel model)  {

    if (item is RichTextItem) {

      return RichTextCard(
        item: item,
        model: model,
        group: group,
      );
    }
    throw UnimplementedError();
  }


}
