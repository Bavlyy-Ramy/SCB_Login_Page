import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:scb_login/core/utils/crypto_helper.dart'; // ✅ Add this
import 'package:scb_login/features/auth/domain/entities/entites.dart';
import '../../features/auth/data/models/user_model.dart';

class UserStorageHelper {
  static const String _boxName = 'userBox';

  /// Save a user by ID
  static Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(_boxName);
    await box.put(user.id, user);
  }

// Encrypts a user and then save it
  static Future<void> saveFromEntity(UserEntity entity) async {
    final encryptedEmail = CryptoHelper.encrypt(entity.encryptedEmail);
    final encryptedPassword = CryptoHelper.encrypt(entity.encryptedPassword);

    log('🔐 Encrypted email ${entity.encryptedEmail} -> $encryptedEmail');
    log('🔐 Encrypted password ${entity.encryptedPassword} -> : $encryptedPassword');

    final encryptedUser = UserModel(
      id: entity.id,
      name: entity.name,
      encryptedEmail: encryptedEmail,
      encryptedPassword: encryptedPassword,
    );

    await saveUser(encryptedUser);
  }

  /// Get a user by ID (decryption is handled in the model)
  static UserModel? getUserById(String id) {
    final box = Hive.box<UserModel>(_boxName);
    return box.get(id);
  }

  /// Login validation (must encrypt input before compare)
  static bool validateLogin(String email, String password) {
    final box = Hive.box<UserModel>(_boxName);
    final encryptedEmail = CryptoHelper.encrypt(email);
    final encryptedPassword = CryptoHelper.encrypt(password);

    try {
      return box.values.any(
        (user) =>
            user.encryptedEmail == encryptedEmail &&
            user.encryptedPassword == encryptedPassword,
      );
    } catch (_) {
      return false;
    }
  }

  /// Reset password (encrypts new password before saving)
  static Future<bool> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final box = Hive.box<UserModel>(_boxName);
    final encryptedEmail = CryptoHelper.encrypt(email);
    final encryptedNewPassword = CryptoHelper.encrypt(newPassword);

    final userList = box.values.toList();

    for (var user in userList) {
      if (user.encryptedEmail == encryptedEmail) {
        final updatedUser = user.copyWith(
          encryptedPassword: encryptedNewPassword,
        );
        await box.put(user.id, updatedUser);
        return true;
      }
    }

    return false;
  }

  /// Get all saved users
  static List<UserModel> getAllUsers() {
    final box = Hive.box<UserModel>(_boxName);
    return box.values.toList();
  }

  /// Delete a specific user
  static Future<void> deleteUser(String id) async {
    final box = Hive.box<UserModel>(_boxName);
    await box.delete(id);
  }

  /// Clear all users
  static Future<void> clearAllUsers() async {
    final box = Hive.box<UserModel>(_boxName);
    await box.clear();
  }
}
