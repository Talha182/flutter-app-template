// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
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

  NoteDao? _noteDaoInstance;

  TaskDao? _taskDaoInstance;

  SubTaskDao? _subTaskDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `notes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `content` TEXT NOT NULL, `createdAt` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tasks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `isDone` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `subtasks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `taskId` INTEGER NOT NULL, `title` TEXT NOT NULL, `isDone` INTEGER NOT NULL, FOREIGN KEY (`taskId`) REFERENCES `tasks` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }

  @override
  SubTaskDao get subTaskDao {
    return _subTaskDaoInstance ??= _$SubTaskDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteModelInsertionAdapter = InsertionAdapter(
            database,
            'notes',
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdAt': item.createdAt
                }),
        _noteModelUpdateAdapter = UpdateAdapter(
            database,
            'notes',
            ['id'],
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdAt': item.createdAt
                }),
        _noteModelDeletionAdapter = DeletionAdapter(
            database,
            'notes',
            ['id'],
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdAt': item.createdAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteModel> _noteModelInsertionAdapter;

  final UpdateAdapter<NoteModel> _noteModelUpdateAdapter;

  final DeletionAdapter<NoteModel> _noteModelDeletionAdapter;

  @override
  Future<List<NoteModel>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM notes ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => NoteModel(
            id: row['id'] as int?,
            title: row['title'] as String,
            content: row['content'] as String,
            createdAt: row['createdAt'] as String));
  }

  @override
  Future<void> insertNote(NoteModel note) async {
    await _noteModelInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await _noteModelUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(NoteModel note) async {
    await _noteModelDeletionAdapter.delete(note);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskModelInsertionAdapter = InsertionAdapter(
            database,
            'tasks',
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'isDone': item.isDone ? 1 : 0
                }),
        _taskModelUpdateAdapter = UpdateAdapter(
            database,
            'tasks',
            ['id'],
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'isDone': item.isDone ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskModel> _taskModelInsertionAdapter;

  final UpdateAdapter<TaskModel> _taskModelUpdateAdapter;

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM tasks ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            isDone: (row['isDone'] as int) != 0));
  }

  @override
  Future<void> deleteTask(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM tasks WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertTask(TaskModel task) {
    return _taskModelInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await _taskModelUpdateAdapter.update(task, OnConflictStrategy.abort);
  }
}

class _$SubTaskDao extends SubTaskDao {
  _$SubTaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _subTaskModelInsertionAdapter = InsertionAdapter(
            database,
            'subtasks',
            (SubTaskModel item) => <String, Object?>{
                  'id': item.id,
                  'taskId': item.taskId,
                  'title': item.title,
                  'isDone': item.isDone ? 1 : 0
                }),
        _subTaskModelUpdateAdapter = UpdateAdapter(
            database,
            'subtasks',
            ['id'],
            (SubTaskModel item) => <String, Object?>{
                  'id': item.id,
                  'taskId': item.taskId,
                  'title': item.title,
                  'isDone': item.isDone ? 1 : 0
                }),
        _subTaskModelDeletionAdapter = DeletionAdapter(
            database,
            'subtasks',
            ['id'],
            (SubTaskModel item) => <String, Object?>{
                  'id': item.id,
                  'taskId': item.taskId,
                  'title': item.title,
                  'isDone': item.isDone ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SubTaskModel> _subTaskModelInsertionAdapter;

  final UpdateAdapter<SubTaskModel> _subTaskModelUpdateAdapter;

  final DeletionAdapter<SubTaskModel> _subTaskModelDeletionAdapter;

  @override
  Future<List<SubTaskModel>> getSubTasksByTaskId(int taskId) async {
    return _queryAdapter.queryList('SELECT * FROM subtasks WHERE taskId = ?1',
        mapper: (Map<String, Object?> row) => SubTaskModel(
            id: row['id'] as int?,
            taskId: row['taskId'] as int,
            title: row['title'] as String,
            isDone: (row['isDone'] as int) != 0),
        arguments: [taskId]);
  }

  @override
  Future<void> insertSubTask(SubTaskModel subTask) async {
    await _subTaskModelInsertionAdapter.insert(
        subTask, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSubTask(SubTaskModel subTask) async {
    await _subTaskModelUpdateAdapter.update(subTask, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSubTask(SubTaskModel subTask) async {
    await _subTaskModelDeletionAdapter.delete(subTask);
  }
}
