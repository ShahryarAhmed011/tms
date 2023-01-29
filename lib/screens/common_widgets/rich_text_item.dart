import 'package:appflowy_board/appflowy_board.dart';

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String startTime;
  final String timeSpent;

  /// constructor with required parameter
  RichTextItem({required this.title, required this.startTime,required this.timeSpent});

  /// Overriding the getter method 'id' from parent class 'AppFlowyGroupItem'
  @override
  String get id => title;

}