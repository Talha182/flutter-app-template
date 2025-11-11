import 'subtask.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final bool isDone;
  final List<SubTask> subtasks;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    this.subtasks = const [],
  });
}
