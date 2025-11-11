import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/task.dart';
import '../providers/task_provider.dart';
import '../widgets/subtask_item.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final tasks = provider.tasks;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Tasks",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.primary),
            onPressed: provider.fetchTasks,
          ),
        ],
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 80.sp,
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            SizedBox(height: AppSizes.spacingL),
            Text(
              "No tasks yet",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: provider.fetchTasks,
        child: ListView.separated(
          padding: EdgeInsets.all(AppSizes.paddingM),
          itemCount: tasks.length,
          separatorBuilder: (_, __) => SizedBox(height: AppSizes.spacingM),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return _buildTaskCard(context, task, provider);
          },
        ),
      ),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, Task task, TaskProvider provider) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      elevation: 2,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
        ),
        tilePadding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingS,
        ),
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => provider.toggleTaskStatus(task),
          activeColor: colorScheme.primary,
          checkColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusXS),
          ),
        ),
        title: Text(
          task.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            decoration:
            task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            color: task.isDone
                ? colorScheme.onSurface.withOpacity(0.5)
                : colorScheme.onSurface,
          ),
        ),
        subtitle: task.description.isNotEmpty
            ? Text(
          task.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        )
            : null,
        childrenPadding: EdgeInsets.all(AppSizes.paddingM),
        children: [
          if (task.subtasks.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subtasks",
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(height: AppSizes.spacingS),
                ...task.subtasks.map(
                      (subtask) => SubTaskItem(
                    subtask: subtask,
                    onToggle: () => provider.toggleSubTask(task, subtask),
                  ),
                ),
                SizedBox(height: AppSizes.spacingL),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => _showAddSubTaskDialog(context, task),
                icon: Icon(Icons.add, color: colorScheme.primary),
                label: Text(
                  "Add Subtask",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                onPressed: () => _confirmDelete(context, provider, task),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, TaskProvider provider, Task task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusML)),
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deleteTask(task.id!);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final List<TextEditingController> subtaskControllers = [];
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext dialogContext, StateSetter setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusML)),
          title: Text(
            "Add New Task",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      borderSide: BorderSide(color: colorScheme.primary, width: 2),
                    ),
                  ),
                  autofocus: true,
                ),
                SizedBox(height: AppSizes.spacingM),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: "Description (optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      borderSide: BorderSide(color: colorScheme.primary, width: 2),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: AppSizes.spacingL),
                if (subtaskControllers.isNotEmpty)
                  Text(
                    "Subtasks",
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ...subtaskControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(top: AppSizes.paddingS),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: "Subtask ${index + 1}",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                                borderSide: BorderSide(color: colorScheme.primary, width: 2),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: colorScheme.error),
                          onPressed: () {
                            setState(() {
                              subtaskControllers.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: AppSizes.spacingS),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      subtaskControllers.add(TextEditingController());
                    });
                  },
                  icon: Icon(Icons.add, color: colorScheme.primary),
                  label: Text(
                    "Add Subtask",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                "Cancel",
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                if (title.isEmpty) return;
                final subtasksTitles = subtaskControllers
                    .map((controller) => controller.text.trim())
                    .where((t) => t.isNotEmpty)
                    .toList();
                final newTask = Task(
                  title: title,
                  description: descController.text.trim(),
                  isDone: false,
                  subtasks: subtasksTitles.map((t) => SubTask(taskId: 0, title: t, isDone: false)).toList(),
                );
                final provider = context.read<TaskProvider>();
                await provider.addTask(newTask);
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                ),
              ),
              child: Text(
                "Add",
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddSubTaskDialog(BuildContext context, Task parentTask) {
    final subtaskController = TextEditingController();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusML)),
        title: Text(
          "Add Subtask",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: subtaskController,
          decoration: InputDecoration(
            labelText: "Subtask title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              "Cancel",
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final title = subtaskController.text.trim();
              if (title.isEmpty) return;
              context.read<TaskProvider>().addSubTask(parentTask, title);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
              ),
            ),
            child: Text(
              "Add",
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}