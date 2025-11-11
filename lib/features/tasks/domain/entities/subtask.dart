class SubTask {
  final int? id;
  final int taskId;
  final String title;
  final bool isDone;

  SubTask({
    this.id,
    required this.taskId,
    required this.title,
    this.isDone = false,
  });
}
