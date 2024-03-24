import 'dart:io';
import 'package:flutter/material.dart';

import '../api/api.dart';

class FCMServices {
  Future postDeviceDetails({
    required String fcmToken,
    required String accessToken,
  }) async {
    try {
      if (Platform.isAndroid) {
        var data = {
          'registration_id': fcmToken,
          'type': 'android',
          'active': 'true',
          'cloud_message_type': 'FCM',
        };
        return Api().postWithHeader(
          'devices/gcm/',
          token: accessToken,
          body: data,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
