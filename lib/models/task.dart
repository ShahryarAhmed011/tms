import 'package:floor/floor.dart';


///Task entity class
@entity
class Task{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? groupId;
  String? groupName;
  String? taskTitle;
  int? startTime;
  int? endTime;
  String? timeSpent;
  int? mIndex;

  Task({
    this.id,
    required this.groupId,
    required this.groupName,
    required this.taskTitle,
    this.mIndex,
    this.startTime,
    this.endTime,
    this.timeSpent,
  });

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          groupId == other.groupId &&
          groupName == other.groupName &&
          taskTitle == other.taskTitle &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          timeSpent == other.timeSpent &&
          mIndex == other.mIndex;

  @override
  int get hashCode =>
      id.hashCode ^
      groupId.hashCode ^
      groupName.hashCode ^
      taskTitle.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      timeSpent.hashCode ^
      mIndex.hashCode;
}