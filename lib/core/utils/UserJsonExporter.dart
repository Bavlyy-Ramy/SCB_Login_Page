import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../../features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

class UserJsonExporter {
  static Future<void> exportUsersToJsonFile() async {
    final box = Hive.box<UserModel>('userBox');
    final users = box.values.map((u) => u.toJson()).toList();

    final jsonString = const JsonEncoder.withIndent('  ').convert(users);

    final file = File('assets/data/users.json');
    await file.create(recursive: true);
    await file.writeAsString(jsonString);
    print('✅ Exported users to assets/data/users.json');
  }
}
