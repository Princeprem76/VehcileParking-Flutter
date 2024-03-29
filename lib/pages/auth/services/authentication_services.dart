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
        'user_type': '3',
      },
    );
    return response;
  }

  static Future customerDetails(
    String name,
    String address,
    String phone,
  ) async {
    dynamic response = await Api().post(
      'userdetails/',
      body: {
        'name': name,
        'address': address,
        'phone': phone,
      },
    );
    return response;
  }
  static Future customerVerify(
    String email,
    String otp,
  ) async {
    dynamic response = await Api().post(
      'userdetails/',
      body: {
        'email': email,
        'otp': otp,
      },
    );
    return response;
  }
  static Future customerResendCode(
    String email,
  ) async {
    dynamic response = await Api().post(
      'reotp/',
      body: {
        'email': email,
      },
    );
    return response;
  }
}
