import 'package:tms/models/project.dart';

import 'home_repository.dart';

class HomeRepositoryImp extends HomeRepository {

  /// This function fetch all the projects from the database
  @override
  Future<List<Project>> getProjects() async{
    List<Project> projectList = [];
    projectList = await (await database).projectDao.getAllProjects();

    ///check is project not exist in db if not exist then add dummy data
    if(projectList.isEmpty){
      Project project = Project(name:"Smart Logistics", description: "Progress board", dateTime:DateTime.now().millisecondsSinceEpoch);
      await (await database).projectDao.insertProject(project);
      projectList = await (await database).projectDao.getAllProjects();
    }
    return projectList;
  }
}