import 'package:appflowy_board/appflowy_board.dart';

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String startTime;
  final String timeSpent;

  RichTextItem({required this.title, required this.startTime,required this.timeSpent});

  @override
  String get id => title;

}