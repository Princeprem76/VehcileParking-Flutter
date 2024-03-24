import '../../../api/api.dart';

class HomeService {
  static Future slots() async {
    dynamic response = await Api().getWithHeader(
      'available-slot/',
    );
    return response;
  }

  static Future bookSlot(
    String vehicleType,
    String vehicleNumber,
    int parkingSpace,
  ) async {
    dynamic response = await Api().postWithHeader(
      'book-slot/',
      body: {
        'parking_space': parkingSpace,
        'vehicle_type': vehicleType,
        'vehicle_number': vehicleNumber,
      },
    );
    return response;
  }

  static Future bookHistory() async {
    dynamic response = await Api().getWithHeader(
      'book-slot/',
    );
    return response;
  }

}
