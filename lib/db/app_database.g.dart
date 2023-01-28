// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProjectDao? _projectDaoInstance;

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Project` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `description` TEXT, `dateTime` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `groupId` TEXT, `groupName` TEXT, `taskTitle` TEXT, `startTime` INTEGER, `endTime` INTEGER, `timeSpent` TEXT, `mIndex` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProjectDao get projectDao {
    return _projectDaoInstance ??= _$ProjectDao(database, changeListener);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$ProjectDao extends ProjectDao {
  _$ProjectDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _projectInsertionAdapter = InsertionAdapter(
            database,
            'Project',
            (Project item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'dateTime': item.dateTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Project> _projectInsertionAdapter;

  @override
  Future<List<Project>> getAllProjects() async {
    return _queryAdapter.queryList('SELECT * FROM Project',
        mapper: (Map<String, Object?> row) => Project(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            dateTime: row['dateTime'] as int?));
  }

  @override
  Stream<Project?> findProjectById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Project WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Project(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            dateTime: row['dateTime'] as int?),
        arguments: [id],
        queryableName: 'Project',
        isView: false);
  }

  @override
  Future<void> insertProject(Project project) async {
    await _projectInsertionAdapter.insert(project, OnConflictStrategy.abort);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'groupId': item.groupId,
                  'groupName': item.groupName,
                  'taskTitle': item.taskTitle,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'timeSpent': item.timeSpent,
                  'mIndex': item.mIndex
                },
            changeListener),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'groupId': item.groupId,
                  'groupName': item.groupName,
                  'taskTitle': item.taskTitle,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'timeSpent': item.timeSpent,
                  'mIndex': item.mIndex
                },
            changeListener),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'groupId': item.groupId,
                  'groupName': item.groupName,
                  'taskTitle': item.taskTitle,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'timeSpent': item.timeSpent,
                  'mIndex': item.mIndex
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM Task',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            groupId: row['groupId'] as String?,
            groupName: row['groupName'] as String?,
            taskTitle: row['taskTitle'] as String?,
            mIndex: row['mIndex'] as int?,
            startTime: row['startTime'] as int?,
            endTime: row['endTime'] as int?,
            timeSpent: row['timeSpent'] as String?));
  }

  @override
  Stream<Task?> findTaskById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            groupId: row['groupId'] as String?,
            groupName: row['groupName'] as String?,
            taskTitle: row['taskTitle'] as String?,
            mIndex: row['mIndex'] as int?,
            startTime: row['startTime'] as int?,
            endTime: row['endTime'] as int?,
            timeSpent: row['timeSpent'] as String?),
        arguments: [id],
        queryableName: 'Task',
        isView: false);
  }

  @override
  Future<Task?> getTask(
    String groupId,
    int mIndex,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM Task WHERE groupId = ?1 AND mIndex = ?2',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            groupId: row['groupId'] as String?,
            groupName: row['groupName'] as String?,
            taskTitle: row['taskTitle'] as String?,
            mIndex: row['mIndex'] as int?,
            startTime: row['startTime'] as int?,
            endTime: row['endTime'] as int?,
            timeSpent: row['timeSpent'] as String?),
        arguments: [groupId, mIndex]);
  }

  @override
  Future<List<Task>> getAllTasksByGroupId(String groupId) async {
    return _queryAdapter.queryList('SELECT * FROM Task WHERE groupId = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            groupId: row['groupId'] as String?,
            groupName: row['groupName'] as String?,
            taskTitle: row['taskTitle'] as String?,
            mIndex: row['mIndex'] as int?,
            startTime: row['startTime'] as int?,
            endTime: row['endTime'] as int?,
            timeSpent: row['timeSpent'] as String?),
        arguments: [groupId]);
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTask(Task task) {
    return _taskUpdateAdapter.updateAndReturnChangedRows(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTasks(List<Task> tasks) async {
    await _taskDeletionAdapter.deleteList(tasks);
  }
}
