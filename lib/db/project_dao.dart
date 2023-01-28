import 'package:floor/floor.dart';
import 'package:tms/models/project.dart';

///Data Access Object (DAO) for the Project entity.
///This class contains methods that perform database operations on the Project table.
///@dao annotation is used to mark this class as a DAO and work with Floor.
@dao
abstract class ProjectDao {
  /// Select all projects from the Project table.
  /// @Query annotation is used to define a SQL SELECT statement to fetch all the projects from the Project table.
  /// The method returns a Future<List<Project>>, which will contain all the projects from the table.
  @Query('SELECT * FROM Project')
  Future<List<Project>> getAllProjects();

  /// Find a project by its id.
  /// @Query annotation is used to define a SQL SELECT statement to fetch a project from the Project table by its id.
  /// The method returns a Stream<Project?>, which will contain the project with the specified id if found.
  /// @param id The id of the project to find.
  @Query('SELECT * FROM Project WHERE id = :id')
  Stream<Project?> findProjectById(int id);

  ///Insert a new project into the Project table.
  ///@insert annotation is used to define a SQL INSERT statement to insert a new project into the Project table.
  ///The method returns a Future<void>, indicating that the insertion is done asynchronously.
  ///@param project The project to insert.
  @insert
  Future<void> insertProject(Project project);
}