import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api.dart';

class AdminHomeService {
  static Future addslot(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'addslot/',
      token: token,
      body: {"slot_name": name},
    );
    return response;
  }

  static Future addprice(String two, String four) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'updateprice/',
      token: token,
      body: {"two": two, "four": four},
    );
    return response;
  }

  static Future checkout(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().postWithHeader(
      'accept-check-out/$id/',
      token: token,
    );
    return response;
  }

  static Future checkoutdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'check-out/',
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

    static Future bookDatas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'book-slot/',
      token: token,
    );
    return response;
  }
  static Future pieData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'piedata/',
      token: token,
    );
    return response;
  }
  static Future revenue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'revenue/',
      token: token,
    );
    return response;
  }
  static Future getcomments(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    dynamic response = await Api().getWithHeader(
      'getcomment/?id=$id',
      token: token,
    );
    return response;
  }
}
