import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scb_login/features/auth/domain/usecases/login_use_case.dart';
import 'package:scb_login/features/auth/domain/usecases/offline_login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final OfflineLoginUseCase offlineLoginUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.offlineLoginUseCase,
  }) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());

    final success = await loginUseCase(username, password);

    if (success) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('Invalid username or password'));
    }
  }

  void offlineLogin() async {
    emit(LoginOfflineLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(LoginFailure('Couldn\'t connect, there is a problem with your connection'));
  }
}

