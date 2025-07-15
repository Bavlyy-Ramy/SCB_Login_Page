import '../../../../core/mocks/login_mock.dart';

abstract class LoginRemoteDataSource {
  Future<Map<String, dynamic>> login({required String username, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<Map<String, dynamic>> login({required String username, required String password}) async {
    if (username == 'bavly') {
      return await LoginMock.loginSuccess();
    } else {
      return await LoginMock.loginFailure();
    }
  }
}
