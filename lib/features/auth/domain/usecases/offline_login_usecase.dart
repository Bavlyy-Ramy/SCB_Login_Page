import 'package:scb_login/features/auth/domain/repositories/auth_repository.dart';

class OfflineLoginUseCase {
  final AuthRepository repository;

  OfflineLoginUseCase(this.repository);

  Future<bool> call() async {
    return await repository.offlineLogin();
  }
}
