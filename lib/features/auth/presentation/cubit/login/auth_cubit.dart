import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/core/utils/auth/save.token.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/features/auth/domain/usecases/login.usecase.dart';
import 'auth_state.dart';

class AuthCubitLogin extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubitLogin(this.loginUseCase) : super(AuthInitial());

  Future<void> login(Request req) async {
    emit(AuthLoading());

    final result = await loginUseCase(req);

    result.fold(
      (error) => emit(AuthFailure(
        error.toString().isNotEmpty 
          ? error.toString() 
          : 'Ocurrió un error inesperado'
      )),
      (response) async {
        try {
          final jsonData = response.data; 
          final token = jsonData['token'];
          if (token != null) {
            await saveToken(token);
            emit(AuthSuccess());
          } else {
            emit(AuthFailure('Token no recibido'));
          }
        } catch (e) {
          emit(AuthFailure('Error procesando la respuesta'));
        }
      },
    );
  }
}

