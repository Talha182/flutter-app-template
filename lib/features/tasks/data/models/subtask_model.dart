import 'package:floor/floor.dart';
import 'package:sports_app/features/tasks/data/models/task_model.dart';

@Entity(
  tableName: 'subtasks',
  foreignKeys: [
    ForeignKey(
      childColumns: ['taskId'],
      parentColumns: ['id'],
      entity: TaskModel,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
class SubTaskModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int taskId;
  final String title;
  final bool isDone;

  SubTaskModel({
    this.id,
    required this.taskId,
    required this.title,
    this.isDone = false,
  });
}
