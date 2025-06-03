import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_application/core/utils/auth/save.token.dart';
import 'package:notes_application/features/auth/data/models/request.model.dart';
import 'package:notes_application/features/auth/domain/usecases/register.usecase.dart';
import 'auth_state.dart';

class AuthCubitRegister extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;

  AuthCubitRegister(this.registerUseCase) : super(AuthInitial());

  Future<void> register(Request req) async {
  emit(AuthLoading());

  final result = await registerUseCase(req);

  result.fold(
    (error) => emit(AuthFailure(error.toString().isNotEmpty ? error.toString() : 'An unexpected error occurred')),
    (response) async {
      final jsonData = response.data; 
      final token = jsonData['token'];
      await saveToken(token);
      emit(AuthSuccess());
    },
  );
}

}
