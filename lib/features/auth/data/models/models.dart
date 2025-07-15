import '../../domain/entities/entites.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
    );
  }
}
