import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/core/constants/strings.dart';
import 'package:tms/screens/common_widgets/rich_text_card.dart';
import 'package:tms/screens/common_widgets/rich_text_item.dart';
import 'package:tms/screens/kanban_board_screen/kamban_board_view_model.dart';
import 'package:tms/utils/app_util.dart';

import 'flowy_group_header.dart';

// KanbanBoardView is a StatelessWidget that displays the KanbanBoard using the AppFlowyBoard package.
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

  // buildAppFlowyBoard is a function that creates the AppFlowyBoard widget
  AppFlowyBoard buildAppFlowyBoard(KanbanBoardViewModel model) {
    return AppFlowyBoard(
        controller: model.controller,
        cardBuilder: (context, group, groupItem)  {

          // AppFlowyGroupCard is a widget that is used to build each card in the board
          return AppFlowyGroupCard(
            key: ValueKey(groupItem.id),

            child: _buildCard(groupItem, group, model),
          );
        },
        // AppFlowyBoardScrollController is used to handle the scrolling of the board
        boardScrollController: AppFlowyBoardScrollController(),
        // FlowyGroupHeader is a widget that is used to build the headers of the board
        headerBuilder: (context, columnData) {
          return FlowyGroupHeader(columnData: columnData, model: model);
        },
        groupConstraints: const BoxConstraints.tightFor(width: 260),
        config: AppUtil().boardConfig);
  }

  // _buildCard is a function that is used to build the card depending on the item's type
  Widget _buildCard(AppFlowyGroupItem item, AppFlowyGroupData group,
      KanbanBoardViewModel model)  {

    if (item is RichTextItem) {
      // RichTextCard is a widget that is used to display the item's information
      return RichTextCard(
        item: item,
        model: model,
        group: group,
      );
    }

    // If the item's type is not handled, an error is thrown
    throw UnimplementedError();
  }
}
