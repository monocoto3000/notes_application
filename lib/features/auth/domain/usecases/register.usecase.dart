import 'package:dartz/dartz.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/features/auth/domain/repositories/auth.dart';
import 'package:notes_application/injection.container.dart';

class RegisterUseCase implements UseCase<Either, Request> {
  @override
  Future<Either> call(Request params) async {
    return sl<AuthRepository>().register(params);
  }
}