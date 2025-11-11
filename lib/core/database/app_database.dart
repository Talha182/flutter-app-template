import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../features/notes/data/models/note_model.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/tasks/data/models/subtask_model.dart';
import '../../features/notes/data/dao/note_dao.dart';
import '../../features/tasks/data/dao/task_dao.dart';
import '../../features/tasks/data/dao/subtask_dao.dart';
part 'app_database.g.dart'; // generated file

@Database(version: 1, entities: [NoteModel, TaskModel, SubTaskModel])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
  TaskDao get taskDao;
  SubTaskDao get subTaskDao;
  static Future<AppDatabase> getInstance() async {
    return $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
