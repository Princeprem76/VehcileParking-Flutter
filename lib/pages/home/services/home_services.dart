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
    int parkingSpace,
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

}
