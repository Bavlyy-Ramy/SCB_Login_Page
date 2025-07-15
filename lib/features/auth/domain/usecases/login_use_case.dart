import 'package:scb_login/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
