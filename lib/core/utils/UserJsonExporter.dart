import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../features/auth/data/models/user_model.dart';

class UserJsonExporter {
  static Future<void> exportUsersToJsonFile() async {
    final box = Hive.box<UserModel>('userBox');
    final users = box.values.map((u) => u.toJson()).toList();

    final jsonString = const JsonEncoder.withIndent('  ').convert(users);

    // ✅ Get a writable directory
    final dir = await getApplicationDocumentsDirectory();

    // Create a path like: /.../Documents/data/users.json
    final filePath = p.join(dir.path, 'data', 'users.json');
    final file = File(filePath);

    // ✅ Create directories if they don't exist
    await file.create(recursive: true);

    await file.writeAsString(jsonString);
    print('✅ Exported users to $filePath');
  }
}
