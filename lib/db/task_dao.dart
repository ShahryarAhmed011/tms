import 'package:floor/floor.dart';
import 'package:tms/models/task.dart';

///Data Access Object (DAO) for the Project entity.
///This class contains methods that perform database operations on the Project table.
///@dao annotation is used to mark this class as a DAO and work with Floor.
@dao
abstract class TaskDao {
  /// Select tasks from the Task table.
  /// @Query annotation is used to define a SQL SELECT statement to fetch all the projects from the Task table.
  /// The method returns a Future<List<Task>>, which will contain all the projects from the table.
  @Query('SELECT * FROM Task')
  Future<List<Task>> getAllTasks();

  /// Find a Task by its id.
  /// @Query annotation is used to define a SQL SELECT statement to fetch a Task from the Task table by its id.
  /// The method returns a Stream<Task?>, which will contain the project with the specified id if found.
  /// @param id The id of the Task to find.
  @Query('SELECT * FROM Task WHERE id = :id')
  Stream<Task?> findTaskById(int id);

  ///  This is a function that is annotated with the @insert annotation. It takes in a single parameter of type Task and returns a Future<void>. The purpose of this function is to insert a new task into the database. The @insert annotation is provided by the floor package and tells the database to insert the task as a new record in the Task table.
  @insert
  Future<void> insertTask(Task task);

  ///The @update annotation is used in conjunction with the update() function provided by the floor library. The updateTask() function takes in an object of type Task as a parameter, and returns a Future<int> which is the number of rows affected by the update query. This function is typically used to update existing rows in the database table associated with the Task class.
  @update
  Future<int> updateTask(Task task);

  ///This is a function that is decorated with the @Query annotation, which is used to indicate that this function is a query that is executed on the database. The query is a SQL SELECT statement that selects all columns from the Task table where the groupId is equal to the value of the groupId parameter and the mIndex is equal to the value of the mIndex parameter. The function returns a Future<Task?> which means it returns a task matching the given groupId and mIndex asynchronously, it could return null if no task is found with the given parameters.
  ///This function takes two parameters:
  ///groupId of type String, which is used in the query as a parameter for the groupId column.
  ///mIndex of type int, which is used in the query as a parameter for the mIndex column.
  @Query('SELECT * FROM Task WHERE groupId = :groupId AND mIndex = :mIndex')
  Future<Task?> getTask(String groupId, int mIndex);

  /// Annotate the method with @Query and include the SQL query
  /// Define the function signature, including the input parameter and return type
  @Query('SELECT * FROM Task WHERE groupId = :groupId')
  Future<List<Task>> getAllTasksByGroupId(String groupId);

  ///deletes all tasks
  @delete
  Future<void> deleteTasks(List<Task> tasks);
}
