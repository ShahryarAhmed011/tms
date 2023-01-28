import 'package:appflowy_board/appflowy_board.dart';
import 'package:intl/intl.dart';
import 'package:tms/utils/app_colors.dart';

class AppUtil {
  static final AppUtil _singleton = AppUtil._internal();

  factory AppUtil() {
    return _singleton;
  }

  AppUtil._internal();

  String measureTotal(int start) {
    int end = DateTime.now().millisecondsSinceEpoch;
    DateTime mStart = DateTime.fromMillisecondsSinceEpoch(start , isUtc: false);
    DateTime mEnd = DateTime.fromMillisecondsSinceEpoch(end , isUtc: false);
    Duration duration = mEnd.difference(mStart);
//   String sDuration = "${duration.inHours} H:${duration.inMinutes.remainder(60)} M:${(duration.inSeconds.remainder(60))} S";

    final String formatted = duration.toString().split('.').first.padLeft(8, "0");
    return formatted;
  }

  String format(int millisecondsSinceEpoch){
    final f =  DateFormat('dd-MMM-yy hh:mm a');
    return f.format(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: false));
  }

  int currentMillisecondsSinceEpoch(){
    return DateTime.now().millisecondsSinceEpoch;
  }

  final boardConfig = const AppFlowyBoardConfig(
      groupBackgroundColor: AppColors.boardColor
  );


}