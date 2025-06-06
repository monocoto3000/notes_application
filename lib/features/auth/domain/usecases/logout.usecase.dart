import 'package:notes_application/core/usecase/noparams.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  @override
  Future<void> call(NoParams params) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}