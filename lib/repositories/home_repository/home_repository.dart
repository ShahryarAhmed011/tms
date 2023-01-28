import 'package:tms/core/base/base_repository.dart';
import 'package:tms/models/project.dart';

abstract class HomeRepository extends BaseRepository {

  /// This function fetch all the projects from the database
  Future<List<Project>> getProjects();

}

