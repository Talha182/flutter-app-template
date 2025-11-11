import 'package:floor/floor.dart';
import '../models/note_model.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM notes ORDER BY id DESC')
  Future<List<NoteModel>> getAllNotes();

  @insert
  Future<void> insertNote(NoteModel note);

  @update
  Future<void> updateNote(NoteModel note);

  @delete
  Future<void> deleteNote(NoteModel note);
}
