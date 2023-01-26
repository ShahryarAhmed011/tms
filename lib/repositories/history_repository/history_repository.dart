import 'package:tms/core/base/base_repository.dart';

import '../../models/task.dart';

abstract class HistoryRepository extends BaseRepository {
  Future<List<Task>> getAllTasksByGroupId(String groupId);
}