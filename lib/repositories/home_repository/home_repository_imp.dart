import 'package:tms/models/project.dart';

import 'home_repository.dart';

class HomeRepositoryImp extends HomeRepository {

  @override
  Future<List<Project>> getProjects() async{
    List<Project> projectList = [];
    projectList = await (await database).projectDao.getAllProjects();
    if(projectList.isEmpty){
      Project project = Project(name:"Smart Logistics", description: "Progress board", dateTime:DateTime.now().millisecondsSinceEpoch);
      await (await database).projectDao.insertProject(project);
      projectList = await (await database).projectDao.getAllProjects();
    }
    return projectList;
  }
}