import 'package:floor/floor.dart';

@Entity(tableName: 'tasks')
class TaskModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });
}
