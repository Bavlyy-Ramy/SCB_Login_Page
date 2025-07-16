import 'package:hive/hive.dart';
import 'package:scb_login/features/auth/domain/entities/entites.dart';


part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  }) : super(id: id, name: name, email: email, password: password);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }
    /// ✅ Add this
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
  UserModel copyWith({
  String? id,
  String? name,
  String? email,
  String? password,
}) {
  return UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    password: password ?? this.password,
  );
}


  /// ✅ And this
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
