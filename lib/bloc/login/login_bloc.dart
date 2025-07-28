import 'package:crypto_fake/data/services/AuthService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final isSuccess = await authService.login(event.loginData);
      if (isSuccess) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Login gagal. Periksa kembali kredensial Anda."));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
