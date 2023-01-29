
import 'package:appflowy_board/appflowy_board.dart';

class TextItem extends AppFlowyGroupItem {
  final String s;
  TextItem(this.s);
  @override
  String get id => s;
}