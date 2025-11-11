import '../../domain/entities/note.dart';
import '../../../../common/services/database_service.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  final DatabaseService databaseService;

  NotesRepositoryImpl({required this.databaseService});

  @override
  Future<List<Note>> getNotes() async {
    final noteModels = await databaseService.noteDao.getAllNotes();

    return noteModels.map((model) {
      return Note(
        id: model.id?.toString() ?? '',
        title: model.title,
        content: model.content,
        createdAt: DateTime.parse(model.createdAt),
      );
    }).toList();
  }

  @override
  Future<void> addNote(Note note) async {
    final model = NoteModel(
      title: note.title,
      content: note.content,
      createdAt: note.createdAt.toIso8601String(),
    );

    await databaseService.noteDao.insertNote(model);
  }

  @override
  Future<void> updateNote(Note note) async {
    final model = NoteModel(
      id: int.tryParse(note.id),
      title: note.title,
      content: note.content,
      createdAt: note.createdAt.toIso8601String(),
    );

    await databaseService.noteDao.updateNote(model);
  }

  @override
  Future<void> deleteNote(Note note) async {
    final model = NoteModel(
      id: int.tryParse(note.id),
      title: note.title,
      content: note.content,
      createdAt: note.createdAt.toIso8601String(),
    );

    await databaseService.noteDao.deleteNote(model);
  }
}
