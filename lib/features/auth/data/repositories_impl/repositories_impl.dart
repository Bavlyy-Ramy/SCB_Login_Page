import '../../domain/entities/entites.dart';
import '../../domain/repositories/reporsitory.dart';
import '../data_sources/data_sources.dart';
import '../models/models.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({required String username, required String password}) async {
    final response = await remoteDataSource.login(username: username, password: password);

    if (response['status'] == true) {
      return UserModel.fromJson(response['data']);
    } else {
      throw Exception(response['message']);
    }
  }
}
