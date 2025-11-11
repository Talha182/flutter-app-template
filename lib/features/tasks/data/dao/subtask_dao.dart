import 'package:floor/floor.dart';
import '../models/subtask_model.dart';

@dao
abstract class SubTaskDao {
  @Query('SELECT * FROM subtasks WHERE taskId = :taskId')
  Future<List<SubTaskModel>> getSubTasksByTaskId(int taskId);

  @insert
  Future<void> insertSubTask(SubTaskModel subTask);

  @update
  Future<void> updateSubTask(SubTaskModel subTask);

  @delete
  Future<void> deleteSubTask(SubTaskModel subTask);
}
