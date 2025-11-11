import 'package:sports_app/features/tasks/data/dao/subtask_dao.dart';
import 'package:sports_app/features/tasks/data/dao/task_dao.dart';

import '../../core/database/app_database.dart';
import '../../features/notes/data/dao/note_dao.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  late AppDatabase _database;

  DatabaseService._internal();

  Future<void> init() async {
    _database = await AppDatabase.getInstance();
  }

  // Accessors for DAOs
  NoteDao get noteDao => _database.noteDao;
  TaskDao get taskDao => _database.taskDao;
  SubTaskDao get subTaskDao => _database.subTaskDao;

  Future<void> deleteAllTables() async {
    // Example: Delete all users
    // await userDao.deleteAll();
  }
}