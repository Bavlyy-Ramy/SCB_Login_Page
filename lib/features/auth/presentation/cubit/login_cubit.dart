import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(
      {required String username, required String password}) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
   
      emit(LoginSuccess());
    
  }

  void offlineLogin() async {
  emit(LoginOfflineLoading());
  await Future.delayed(const Duration(seconds: 2));
  emit(LoginFailure('Couldn\'t connect, there is a problem with your connection'));
}

}
