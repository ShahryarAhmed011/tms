import 'package:get_it/get_it.dart';
import 'package:tms/models/app_model.dart';
import 'package:tms/repositories/history_repository/history_repository.dart';
import 'package:tms/repositories/home_repository/home_repository.dart';
import 'package:tms/repositories/home_repository/home_repository_imp.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository_imp.dart';
import 'package:tms/repositories/task_board_repository/TaskBoardRepositoryImp.dart';
import 'package:tms/repositories/task_board_repository/task_board_repository.dart';

import '../repositories/history_repository/history_repository_imp.dart';

class DI {
  static Future<void> initDI() async {
    GetIt.I.registerSingleton<HomeRepository>(HomeRepositoryImp());
    GetIt.I.registerSingleton<KanbanBoardRepository>(KanbanBoardRepositoryImp());
    GetIt.I.registerSingleton<HistoryRepository>(HistoryRepositoryImp());
    GetIt.I.registerSingleton<TaskBoardRepository>(TaskBoardRepositoryImp());
    GetIt.I.registerSingleton<AppModel>(AppModel());
    await GetIt.I.allReady();
  }
}
