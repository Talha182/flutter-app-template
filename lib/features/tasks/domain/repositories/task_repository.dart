import '../entities/task.dart';
import '../entities/subtask.dart';

abstract class TasksRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int taskId);

  Future<List<SubTask>> getSubTasks(int taskId);
  Future<void> addSubTask(SubTask subtask);
  Future<void> updateSubTask(SubTask subtask);
  Future<void> deleteSubTask(SubTask subtask);
}
