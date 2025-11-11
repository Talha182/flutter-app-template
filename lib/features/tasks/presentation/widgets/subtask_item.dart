import 'package:flutter/material.dart';
import '../../domain/entities/subtask.dart';

class SubTaskItem extends StatelessWidget {
  final SubTask subtask;
  final VoidCallback onToggle; // 👈 add this

  const SubTaskItem({
    super.key,
    required this.subtask,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        subtask.title,
        style: TextStyle(
          decoration: subtask.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      value: subtask.isDone,
      onChanged: (_) => onToggle(), // 👈 call the callback
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}
