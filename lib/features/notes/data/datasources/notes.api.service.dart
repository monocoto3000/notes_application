import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:notes_application/core/constants/api.urls.dart';
import 'package:notes_application/core/network/dio.client.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/core/error/failures.dart';
import 'package:notes_application/injection.container.dart';

abstract class NoteApiService {
  Future<List<Note>> getAllNotes();
  Future<Note> getNoteById(int id);
  Future<Either> createNote(Note note);
  Future<Either> updateNote(int id, Note note);
  Future<Either> deleteNote(int id);
  Future<List<Note>> getNotesByCategory(int categoryId);
}

class NoteApiServiceImpl extends NoteApiService {
  
  @override
  Future<List<Note>> getAllNotes() async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.notes);
      final data = response.data as List<dynamic>; 
      return data.map((e) => Note.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Error al obtener notas: ${e.message}');
    }
  }

  @override
  Future<Note> getNoteById(int id) async {
    try {
      final response = await sl<DioClient>().get('${ApiUrls.notes}/$id');
      return Note.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Error al obtener la nota: ${e.message}');
    }
  }


  @override
  Future<Either> createNote(Note note) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.notes, 
        data: note.toMap(),
      );
      return Right(Note.fromJson(response.data));
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either<Failure, Note>> updateNote(int id, Note note) async {
    try {
      var response = await sl<DioClient>().put(
        '${ApiUrls.notes}/$id',
        data: note.toMap(),
      );
      final noteData = response.data;
      final updatedNote = Note.fromJson(noteData);
      return Right(updatedNote);
    } on DioException catch (e) {
      return Left(e.response as Failure);
    }
  }

  @override
  Future<Either> deleteNote(int id) async {
    try {
      var response = await sl<DioClient>().delete(
        '${ApiUrls.notes}/$id', 
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<List<Note>> getNotesByCategory(int categoryId) async {
    try {
      final response = await sl<DioClient>().get('${ApiUrls.notes}/category/$categoryId');
      final data = response.data as List<dynamic>;
      return data.map((e) => Note.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Error al obtener notas por categoría: ${e.message}');
    }
  }
}
