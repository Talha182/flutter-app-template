import 'package:flutter/material.dart';

import '../../../tasks/data/dao/subtask_dao.dart';
import '../../../tasks/data/dao/task_dao.dart';
import '../../../tasks/data/models/subtask_model.dart';
import '../../../tasks/data/models/task_model.dart';

class TasksPage extends StatefulWidget {
  final TaskDao taskDao;
  final SubTaskDao subTaskDao;

  const TasksPage({
    super.key,
    required this.taskDao,
    required this.subTaskDao,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<TaskModel> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await widget.taskDao.getAllTasks();
    setState(() => _tasks = tasks);
  }

  Future<void> _addTask() async {
    final task = TaskModel(
      title: "Task ${DateTime.now().second}",
      description: "Sample description",
    );
    await widget.taskDao.insertTask(task);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text("No tasks"))
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(_tasks[i].title),
          subtitle: Text(_tasks[i].description),
          onTap: () async {
            final subtasks = await widget.subTaskDao.getSubTasksByTaskId(_tasks[i].id!);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SubTasksPage(
                  task: _tasks[i],
                  subTaskDao: widget.subTaskDao,
                  subtasks: subtasks,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubTasksPage extends StatefulWidget {
  final TaskModel task;
  final SubTaskDao subTaskDao;
  final List<SubTaskModel> subtasks;

  const SubTasksPage({
    super.key,
    required this.task,
    required this.subTaskDao,
    required this.subtasks,
  });

  @override
  State<SubTasksPage> createState() => _SubTasksPageState();
}

class _SubTasksPageState extends State<SubTasksPage> {
  late List<SubTaskModel> _subtasks;

  @override
  void initState() {
    super.initState();
    _subtasks = widget.subtasks;
  }

  Future<void> _addSubtask() async {
    final subtask = SubTaskModel(
      taskId: widget.task.id!,
      title: "Subtask ${DateTime.now().second}",
    );
    await widget.subTaskDao.insertSubTask(subtask);
    final updated = await widget.subTaskDao.getSubTasksByTaskId(widget.task.id!);
    setState(() => _subtasks = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSubtask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _subtasks.length,
        itemBuilder: (context, i) => CheckboxListTile(
          title: Text(_subtasks[i].title),
          value: _subtasks[i].isDone,
          onChanged: (_) {},
        ),
      ),
    );
  }
}
