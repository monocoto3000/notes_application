import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:notes_application/core/constants/api.urls.dart';
import 'package:notes_application/core/network/dio.client.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/injection.container.dart';

abstract class AuthApiService {
  Future<Either> register(Request request);
  Future<Either> login(Request request);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> register(Request request) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: request.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> login(Request request) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.login,
        data: request.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}