abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> offlineLogin();
}
