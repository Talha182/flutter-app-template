import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/subtask.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TasksRepository repository;

  List<Task> _tasks = [];
  bool _isLoading = false;

  TaskProvider(this.repository);

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = await repository.getTasks();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await repository.addTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await repository.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await repository.deleteTask(taskId);
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
  }

  Task? getTaskById(String id) {
    return _tasks.firstWhere(
          (t) => t.id.toString() == id,
      orElse: () => Task(title: 'Unknown', description: ''),
    );
  }

  Future<void> toggleTaskStatus(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      isDone: !task.isDone,
      subtasks: task.subtasks,
    );

    await repository.updateTask(updatedTask);
    await fetchTasks();
  }

  Future<void> addSubTask(Task parentTask, String title) async {
    final subtask = SubTask(
      taskId: parentTask.id!,
      title: title,
      isDone: false,
    );
    await repository.addSubTask(subtask);
    await fetchTasks();
  }

  Future<void> toggleSubTask(Task task, SubTask subtask) async {
    final updatedSubTask = SubTask(
      id: subtask.id,
      taskId: subtask.taskId,
      title: subtask.title,
      isDone: !subtask.isDone,
    );
    await repository.updateSubTask(updatedSubTask);
    await fetchTasks();
  }
}