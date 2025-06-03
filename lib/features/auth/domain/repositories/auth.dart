import 'package:dartz/dartz.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';

abstract class AuthRepository {
  Future<Either> register(Request request); 
  Future<Either> login(Request request);
}