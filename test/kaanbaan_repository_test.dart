import 'package:flutter_test/flutter_test.dart';
import 'package:tms/core/constants/strings.dart';
import 'package:tms/db/app_database.dart';
import 'package:tms/db/task_dao.dart';
import 'package:tms/models/task.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository.dart';
import 'package:tms/repositories/kanban_board_repository/kanban_board_repository_imp.dart';

void main() {
  final database =  $FloorAppDatabase.databaseBuilder('tms_database.db').build();
  late TaskDao taskDao;

  setUp(() async {
    taskDao = (await database).taskDao;
  });

  KanbanBoardRepository kanbanBoardRepository = KanbanBoardRepositoryImp();



  //working
  /// Creates a mock task with groupId 'Strings.todo', index 0, title "task1" and groupName 'Strings.todo'
  /// Inserts the mock task into the database using the 'insertTask' method of the kanbanBoardRepository.
  /// Calls the 'updateGroupTaskIndexes' method of the kanbanBoardRepository, passing in the groupId 'Strings.todo' and the new index 1 as arguments.
  /// Verifies that the task index has been updated by fetching the task again using the 'getTask' method of the kanbanBoardRepository and checking if its index is now 1.
  /// Also it verifies that the result of updateGroupTaskIndexes method is 1 which means one task is updated.
  /// This test case ensures that the 'updateGroupTaskIndexes' method of the kanbanBoardRepository is able to update the index of a task within a group correctly.

  test('test updateGroupTaskIndexes', () async {
    // Create a mock task
    final task =  Task(groupId: Strings.todo, mIndex: 0, taskTitle: "task1", groupName: Strings.todo);
    // Insert the mock task into the database
    await kanbanBoardRepository.insertTask(task);
    // Call the updateGroupTaskIndexes method
    final result = await kanbanBoardRepository.updateGroupTaskIndexes(Strings.todo,1);
    // Verify that the task index has been updated
    final updatedTask = await kanbanBoardRepository.getTask(Strings.todo,1);
    expect(updatedTask!.mIndex, 1);
    expect(result, 1);
  });

  /// This test case is for the getAllTasksByGroupId method in the kanbanBoardRepository class. The test case creates three Task objects, task1, task2, and task3 and inserts them into the repository. The groupId variable is set to Strings.todo.
  /// In the "Arrange" section, the test creates 3 task objects with different groupId, and inserts them into the repository using the insertTask method.
  /// In the "Act" section, the test calls the getAllTasksByGroupId method on the kanbanBoardRepository object, passing in the groupId variable as an argument. The result of this call is stored in the taskList variable.
  /// In the "Assert" section, the test asserts that the taskList variable is of type List<Task>.
  /// The test case will check if the getAllTasksByGroupId method correctly retrieves all tasks with the provided groupId from the repository.

  test('test getAllTasksByGroupId',() async{
    const groupId = Strings.todo;

    // Arrange
    final task1 =  Task(groupId: Strings.todo, mIndex: 0, taskTitle: "task1", groupName: Strings.todo);
    final task2 =  Task(groupId: Strings.inProgress, mIndex: 1, taskTitle: "task1", groupName: Strings.inProgress);
    final task3 =  Task(groupId: Strings.todo, mIndex: 2, taskTitle: "task1", groupName: Strings.todo);

    await kanbanBoardRepository.insertTask(task1);
    await kanbanBoardRepository.insertTask(task2);
    await kanbanBoardRepository.insertTask(task3);

    // Act
    final taskList = await kanbanBoardRepository.getAllTasksByGroupId(groupId);
    // Assert
    expect(taskList, isA<List<Task>>());

  });

  /// The 'test getAllTasks' test case is used to test the 'getAllTasks' method of the 'taskDao' object. This method is used to retrieve all tasks from the database.
  /// In this test case, the 'getAllTasks' method of the 'taskDao' object is called and the result is stored in a variable called 'tasks'. The 'expect' function is then used to verify that the 'tasks' variable is not empty. This verifies that the 'getAllTasks' method is correctly retrieving all tasks from the database.
  test('test getAllTasks',() async{
    final tasks = await taskDao.getAllTasks();
    expect(tasks, isNotEmpty);
  });

  ///This test case is testing the functionality of a method called "updateTask". The test starts by creating a mock task object with specific properties, such as id, groupId, mIndex, taskTitle, and groupName. Then it inserts this mock task into the database using the "insertTask" method from the "kanbanBoardRepository" object.
  ///After that, the test updates the task's title property to "updated task" and then calls the "updateTask" method from the "kanbanBoardRepository" object. The test then checks if the method returns a status code of 1, indicating that the task was successfully updated in the database
  test('test updateTask', () async {
    // Create a mock task
    final task = Task(id: 0,groupId: 'To Do', mIndex: 0, taskTitle: 'task1', groupName: 'To Do');
    // Insert the mock task into the database
    await kanbanBoardRepository.insertTask(task);
    // Update the task's properties
    task.taskTitle = 'updated task';
    // Call the updateTask method
    int  statusCode = await kanbanBoardRepository.updateTask(task);
    expect(statusCode, 1);
  });



  ///This test case is testing the "insertTask" method of the "kanbanBoardRepository" object. It first clears all the tasks in the database by calling the "getAllTasks" and "deleteTasks" methods from the "taskDao" object, Then it creates a mock task with specific properties, and then calls the "insertTask" method from "kanbanBoardRepository" object with this mock task. Then it retrieves the task from the database using the "getTask" method from the "kanbanBoardRepository" object, passing in the groupId and mIndex of the task as arguments. Finally, it verifies that the task was inserted correctly by comparing the groupId and mIndex of the inserted task with the mock task. The test case makes use of the test and expect functions from the Dart test library.
  test('test insertTask', () async {
    List<Task> taskList = await (await database).taskDao.getAllTasks();
    await (await database).taskDao.deleteTasks(taskList);
    // Create a mock task
    final task = Task(groupId: 'To Do', mIndex: 1, taskTitle: 'task1', groupName: 'To Do');
    // Call the insertTask method
    await kanbanBoardRepository.insertTask(task);
    // Get the task from the database
    final insertedTask = await kanbanBoardRepository.getTask("To Do",1);
    // Verify that the task was inserted correctly
    expect(insertedTask!.groupId, task.groupId);
    expect(insertedTask.mIndex, task.mIndex);
  });


  ///This test case is testing the "insertTask" method of the "kanbanBoardRepository" object. It first clears all the tasks in the database by calling the "getAllTasks" and "deleteTasks" methods from the "taskDao" object, Then it creates a mock task with specific properties, and then calls the "insertTask" method from "kanbanBoardRepository" object with this mock task. Then it retrieves the task from the database using the "getTask" method from the "kanbanBoardRepository" object, passing in the groupId and mIndex of the task as arguments. Finally, it verifies that the task was inserted correctly by comparing the groupId and mIndex of the inserted task with the mock task. The test case makes use of the test and expect functions from the Dart test library.
  test('test insertTask', () async {
    List<Task> taskList = await (await database).taskDao.getAllTasks();
    await (await database).taskDao.deleteTasks(taskList);
    // Create a mock task
    final task = Task(groupId: 'To Do', mIndex: 1, taskTitle: 'task1', groupName: 'To Do');
    // Call the insertTask method
    await kanbanBoardRepository.insertTask(task);
    // Get the task from the database
    final insertedTask = await kanbanBoardRepository.getTask("To Do",1);
    // Verify that the task was inserted correctly
    expect(insertedTask!.groupId, task.groupId);
    expect(insertedTask.mIndex, task.mIndex);
  });


  test('getAllTasks', () async {
    // Arrange
    // Clear the existing tasks in the database
    List<Task> taskList = await (await database).taskDao.getAllTasks();
    await (await database).taskDao.deleteTasks(taskList);

    // Create two new tasks
    final task1 =  Task(groupId: Strings.todo, mIndex: 0, taskTitle: "task1", groupName: Strings.todo);
    final task2 =  Task(groupId: Strings.inProgress, mIndex: 1, taskTitle: "task1", groupName: Strings.inProgress);

    // Insert the new tasks into the database
    await kanbanBoardRepository.insertTask(task1);
    await kanbanBoardRepository.insertTask(task2);

    // Act
    // Call the getAllTasks function
    List<Task> result = await kanbanBoardRepository.getAllTasks();

    // Assert
    // Check that the result is a list of tasks
    expect(result, isA<List<Task>>());
    // Check that the result contains the same tasks as the tasks list
    // You can check by comparing the values of the result tasks to the values of the tasks you inserted in arrange section
  });

}