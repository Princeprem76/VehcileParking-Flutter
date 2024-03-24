import '../../../api/api.dart';

class AuthenticationService {
  static Future login(
    String email,
    String password,
  ) async {
    dynamic response = await Api().post(
      'login/',
      body: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }

  static Future customerRegister(
    String email,
    String password,
  ) async {
    dynamic response = await Api().post(
      'register/',
      body: {
        'email': email,
        'password': password,
        'user_type': 3,
      },
    );
    return response;
  }
}
