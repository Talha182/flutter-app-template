import 'package:floor/floor.dart';

@Entity(tableName: 'notes')
class NoteModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String content;
  final String createdAt;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}
