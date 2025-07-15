import 'package:hive/hive.dart';
import '../../features/auth/data/models/user_model.dart';

class UserStorageHelper {
  static const String _boxName = 'userBox';

  /// Save a user by ID (can save multiple users)
  static Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(_boxName);
    await box.put(user.id, user); // 👈 store using ID as key
  }

  /// Get a user by ID
  static UserModel? getUserById(String id) {
    final box = Hive.box<UserModel>(_boxName);
    return box.get(id);
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
