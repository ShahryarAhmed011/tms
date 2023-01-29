import 'package:appflowy_board/appflowy_board.dart';
import 'package:intl/intl.dart';
import 'package:tms/utils/app_colors.dart';

class AppUtil {
  static final AppUtil _singleton = AppUtil._internal();

  factory AppUtil() {
    return _singleton;
  }

  AppUtil._internal();

//  This function takes in an integer 'start' which represents the start time in milliseconds since the epoch and returns a string representing the total duration since the start time until the current time. The duration is calculated by finding the difference between the current time and the start time in milliseconds and then converting it to a human-readable format. It returns the duration in the format of hours, minutes and seconds.
  String measureTotal(int start) {
    int end = DateTime.now().millisecondsSinceEpoch;
    DateTime mStart = DateTime.fromMillisecondsSinceEpoch(start , isUtc: false);
    DateTime mEnd = DateTime.fromMillisecondsSinceEpoch(end , isUtc: false);
    Duration duration = mEnd.difference(mStart);
//   String sDuration = "${duration.inHours} H:${duration.inMinutes.remainder(60)} M:${(duration.inSeconds.remainder(60))} S";

    final String formatted = duration.toString().split('.').first.padLeft(8, "0");
    return formatted;
  }

  ///This function takes in an integer 'millisecondsSinceEpoch' which represents a timestamp in milliseconds since the epoch and returns a string representing the formatted date-time. The date-time is formatted by using the DateFormat class and the format string 'dd-MMM-yy hh:mm a'.
  String format(int millisecondsSinceEpoch){
    final f =  DateFormat('dd-MMM-yy hh:mm a');
    return f.format(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: false));
  }

  ///This function returns an integer representing the current time in milliseconds since the epoch. It uses the DateTime.now() method to get the current time and then retrieves the timestamp in milliseconds using the millisecondsSinceEpoch property.
  int currentMillisecondsSinceEpoch(){
    return DateTime.now().millisecondsSinceEpoch;
  }

  ///This is a constant variable of type AppFlowyBoardConfig that contains the configuration for the board. The configuration includes a property called groupBackgroundColor which is set to the AppColors.boardColor constant. This sets the background color of the board to the color defined in the AppColors class.
  final boardConfig = const AppFlowyBoardConfig(
      groupBackgroundColor: AppColors.boardColor
  );


}