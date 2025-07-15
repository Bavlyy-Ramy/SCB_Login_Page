import 'package:scb_login/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(String username, String password) async {
    
    await Future.delayed(const Duration(seconds: 1));

    if (username == 'bavly' && password == 'bavly123') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> offlineLogin() async {
    // For now, simulate failed offline login
    await Future.delayed(const Duration(milliseconds: 800));
    return false;
  }
}
