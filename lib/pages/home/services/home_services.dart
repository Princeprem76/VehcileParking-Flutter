import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api.dart';

class HomeService {
  static Future slots() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'available-slot/',
      token: token,
    );
    return response;
  }

  static Future bookSlot(
    String vehicleType,
    String vehicleNumber,
    String parkingSpace,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'book-slot/',
      token: token,
      body: {
        'parking_space': parkingSpace,
        'vehicle_type': vehicleType,
        'vehicle_number': vehicleNumber,
      },
    );
    return response;
  }

  static Future bookHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'book-slot/',
      token: token,
    );
    return response;
  }

  static Future bookDataHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'history/',
      token: token,
    );
    return response;
  }

  static Future notificationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'notify/',
      token: token,
    );
    return response;
  }

  static Future userData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'userdetails/',
      token: token,
    );
    return response;
  }

  static Future updateUserData(
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

  static Future changepw(
    String oldpassword,
    String newpw,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'changepassword/',
      token: token,
      body: {
        'oldpassword': oldpassword,
        'password': newpw,
      },
    );
    return response;
  }

  static Future checkout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'check-out/',
      token: token,
    );
    return response;
  }

  static Future payments(
    String price,
    String method,
    String service,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'payment/',
      token: token,
      body: {
        'price': price,
        'payment_method': method,
        'service': service,
      },
    );
    return response;
  }

  static Future checkdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'check-data/',
      token: token,
    );
    return response;
  }

  static Future checkprice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'price/',
      token: token,
    );
    return response;
  }

  static Future addreply(String id, String comment) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'add-reply/',
      token: token,
      body: {
        'id': id,
        'comment': comment,
      },
    );
    return response;
  }

  static Future addcomment(String id, String comment) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'add-comment/',
      token: token,
      body: {
        'id': id,
        'comment': comment,
      },
    );
    return response;
  }

  static Future getcomments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'getcomment/',
      token: token,
    );
    return response;
  }
}
