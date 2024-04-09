import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'userdetails/',
      token: token,
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
      'activate/',
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

  static Future customerpasswordVerifyCode(
    String email,
  ) async {
    dynamic response = await Api().post(
      'emailpw/',
      body: {
        'email': email,
      },
    );
    return response;
  }

  static Future customerPasswordVerify(
    String email,
    String otp,
  ) async {
    dynamic response = await Api().post(
      'activatepw/',
      body: {
        'email': email,
        'otp': otp,
      },
    );
    return response;
  }

  static Future forgetPasswordVerify(
    String old,
    String newpw,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'forgetpassword/',
      token: token,
      body: {
        'password': old,
        'repassword': newpw,
      },
    );
    return response;
  }
}
