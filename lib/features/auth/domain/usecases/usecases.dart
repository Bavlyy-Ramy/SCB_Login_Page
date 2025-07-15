import '../entities/entites.dart';
import '../repositories/reporsitory.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({required String username, required String password}) {
    return repository.login(username: username, password: password);
  }
}
