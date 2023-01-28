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

  initialize() async{
    projectList = await repository.getProjects();
    _isLoading = false;
    notifyListeners();
  }

  navigate(Project project){
    Get.to(TaskBoardView(), arguments: ["First data", "Second data"]);
  }


}
