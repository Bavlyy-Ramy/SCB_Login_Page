import 'package:scb_login/core/utils/user_storage_helper.dart';

class LoginUseCase {
  Future<bool> call(String email, String password) async {
    return UserStorageHelper.validateLogin(email, password);
  }
}
