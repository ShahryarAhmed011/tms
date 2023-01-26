
import 'package:floor/floor.dart';
import 'package:tms/models/project.dart';

@dao
abstract class ProjectDao {
  @Query('SELECT * FROM Project')
  Future<List<Project>> getAllProjects();

  @Query('SELECT * FROM Project WHERE id = :id')
  Stream<Project?> findProjectById(int id);

  @insert
  Future<void> insertProject(Project project);

}