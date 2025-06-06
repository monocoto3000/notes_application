 import 'package:dartz/dartz.dart';
import 'package:notes_application/features/auth/data/datasources/auth.api.service.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/features/auth/domain/repositories/auth.dart';
import 'package:notes_application/injection.container.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> register(Request request) {
    return sl<AuthApiService>().register(request);
  }
  @override
  Future<Either> login(Request request) {
    return sl<AuthApiService>().login(request);
  }
}