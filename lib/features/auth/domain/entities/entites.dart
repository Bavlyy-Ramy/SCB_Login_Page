class UserEntity {
  final String id;
  final String name;
  final String encryptedEmail;
  final String encryptedPassword;

  const UserEntity({
    required this.id,
    required this.name,
    required this.encryptedEmail,
    required this.encryptedPassword,
  });
}
