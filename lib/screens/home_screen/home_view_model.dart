import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:tms/core/base/base_view_model.dart';
import 'package:tms/models/project.dart';
import 'package:tms/repositories/home_repository/home_repository.dart';
import 'package:tms/screens/task_board_screen/task_board_view.dart';

class HomeViewModel extends BaseVM {

  HomeRepository repository = GetIt.I.get<HomeRepository>();
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<Project> projectList = [];

  HomeViewModel() {
    initialize();

  }

  /// Method to initialize the project list and update the loading status
  initialize() async {
    /// Get the project list from the repository
    projectList = await repository.getProjects();
    /// Update the loading status to false
    _isLoading = false;
    /// Notify the listeners to update the UI
    notifyListeners();
  }

  navigate(Project project){
    Get.to(TaskBoardView(), arguments: ["First data", "Second data"]);
  }


}
