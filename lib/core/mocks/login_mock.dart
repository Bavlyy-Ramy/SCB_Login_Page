class LoginMock {
  static Future<Map<String, dynamic>> loginSuccess() async {
    await Future.delayed(Duration(seconds: 2));
    return {
      "status": true,
      "message": "success login",
      "data": {
        "username": "bavly",
        "id": 123,
      },
    };
  }

  static Future<Map<String, dynamic>> loginFailure() async {
    await Future.delayed(Duration(seconds: 2));
    return {
      "status": false,
      "message": "something went wrong",
    };
  }
}
