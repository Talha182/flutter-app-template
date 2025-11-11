import 'package:floor/floor.dart';
import '../models/task_model.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM tasks ORDER BY id DESC')
  Future<List<TaskModel>> getAllTasks();

  @insert
  Future<int> insertTask(TaskModel task);

  @update
  Future<void> updateTask(TaskModel task);

  @Query('DELETE FROM tasks WHERE id = :id')
  Future<void> deleteTask(int id);
}
