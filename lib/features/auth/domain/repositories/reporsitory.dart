import '../entities/entites.dart';

abstract class LoginRepository {
  Future<UserEntity> login({required String username, required String password});
}