import 'package:hive/hive.dart';
import 'package:scb_login/features/auth/domain/entities/entites.dart';
import 'package:scb_login/core/utils/crypto_helper.dart'; // <- add this

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String encryptedEmail;

  @HiveField(3)
  final String encryptedPassword;

  const UserModel({
    required this.id,
    required this.name,
    required this.encryptedEmail,
    required this.encryptedPassword,
  }) : super(
            id: id,
            name: name,
            encryptedEmail: encryptedEmail,
            encryptedPassword: encryptedPassword);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      encryptedEmail: entity.encryptedEmail,
      encryptedPassword: entity.encryptedPassword,
    );
  }

  /// ✅ Add this
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      encryptedEmail: json['email'],
      encryptedPassword: json['password'],
    );
  }
 UserModel copyWith({
  String? id,
  String? name,
  String? encryptedEmail,
  String? encryptedPassword,
}) {
  return UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    encryptedEmail: encryptedEmail ?? this.encryptedEmail,
    encryptedPassword: encryptedPassword ?? this.encryptedPassword,
  );
}


  /// ✅ And this
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': encryptedEmail,
      'password': encryptedPassword,
    };
  }
}
