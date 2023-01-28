import 'package:tms/core/base/base_repository.dart';

import '../../models/task.dart';

abstract class HistoryRepository extends BaseRepository {
  /// This function fetch all the  task from the database with specific group id
  Future<List<Task>> getAllTasksByGroupId(String groupId);
}