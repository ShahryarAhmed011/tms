import 'package:get_it/get_it.dart';
import 'package:tms/repositories/history_repository/history_repository.dart';
import 'package:tms/repositories/home_repository/home_repository.dart';
import 'package:tms/repositories/home_repository/home_repository_imp.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository_imp.dart';
import 'package:tms/repositories/task_board_repository/TaskBoardRepositoryImp.dart';
import 'package:tms/repositories/task_board_repository/task_board_repository.dart';

import '../repositories/history_repository/history_repository_imp.dart';

class DI {
  ///This function is using the GetIt package to register singletons of different repositories and models. It's registering HomeRepositoryImp, KanbanBoardRepositoryImp, HistoryRepositoryImp, TaskBoardRepositoryImp and AppModel as singletons. And waits for all of them to be ready with the help of await GetIt.I.allReady() method.
  /// Using GetIt package to register singletons
  static Future<void> initDI() async {
    GetIt.I.registerSingleton<HomeRepository>(HomeRepositoryImp());
    GetIt.I.registerSingleton<KanbanBoardRepository>(KanbanBoardRepositoryImp());
    GetIt.I.registerSingleton<HistoryRepository>(HistoryRepositoryImp());
    GetIt.I.registerSingleton<TaskBoardRepository>(TaskBoardRepositoryImp());
    /// Waiting for all singletons to be ready
    await GetIt.I.allReady();
  }
}
