import '../../domain/entities/task.dart';
import '../../domain/entities/subtask.dart';
import '../../../../common/services/database_service.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';
import '../models/subtask_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final DatabaseService databaseService;

  TasksRepositoryImpl({required this.databaseService});

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await databaseService.taskDao.getAllTasks();
    final List<Task> tasks = [];

    for (var model in taskModels) {
      final subtasks = await getSubTasks(model.id!);
      tasks.add(
        Task(
          id: model.id,
          title: model.title,
          description: model.description,
          isDone: model.isDone,
          subtasks: subtasks,
        ),
      );
    }

    return tasks;
  }

  @override
  Future<void> addTask(Task task) async {
    final taskId = await databaseService.taskDao.insertTask(
      TaskModel(
        title: task.title,
        description: task.description,
        isDone: task.isDone,
      ),
    );

    for (var sub in task.subtasks) {
      await addSubTask(
        SubTask(
          id: sub.id,
          taskId: taskId,
          title: sub.title,
          isDone: sub.isDone,
        ),
      );
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    await databaseService.taskDao.updateTask(
      TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isDone: task.isDone,
      ),
    );
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await databaseService.taskDao.deleteTask(
        taskId
    );
  }

  // 🔹 SubTasks

  @override
  Future<List<SubTask>> getSubTasks(int taskId) async {
    final subModels = await databaseService.subTaskDao.getSubTasksByTaskId(taskId);
    return subModels
        .map(
          (m) => SubTask(
        id: m.id,
        taskId: m.taskId,
        title: m.title,
        isDone: m.isDone,
      ),
    )
        .toList();
  }

  @override
  Future<void> addSubTask(SubTask subtask) async {
    await databaseService.subTaskDao.insertSubTask(
      SubTaskModel(
        taskId: subtask.taskId,
        title: subtask.title,
        isDone: subtask.isDone,
      ),
    );
  }

  @override
  Future<void> updateSubTask(SubTask subtask) async {
    await databaseService.subTaskDao.updateSubTask(
      SubTaskModel(
        id: subtask.id,
        taskId: subtask.taskId,
        title: subtask.title,
        isDone: subtask.isDone,
      ),
    );
  }

  @override
  Future<void> deleteSubTask(SubTask subtask) async {
    await databaseService.subTaskDao.deleteSubTask(
      SubTaskModel(
        id: subtask.id,
        taskId: subtask.taskId,
        title: subtask.title,
        isDone: subtask.isDone,
      ),
    );
  }
}