import 'dart:convert';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

void handlePaymentSuccess(
    EsewaPaymentSuccessResult data, price, id, BuildContext context) {
  const SnackBar _snackBar = SnackBar(
    content: Text('Payment Completed!'),
    duration: Duration(seconds: 3),
  );
  const SnackBar _snackBar1 = SnackBar(
    content: Text('Server Error!'),
    duration: Duration(seconds: 3),
  );

  HomeService.payments(price.toString(), "esewa", id.toString())
      .then((response) async {
    if (response.statusCode == 201) {
      var result = json.decode(response.body).toString();

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const homepage(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
    }
  });
}

class Esewa {
  pay(String price, String pname, String id, BuildContext context) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
          secretId: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        ),
        esewaPayment: EsewaPayment(
          productId: id,
          productName: pname,
          productPrice: price,
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          // _paymentDetail("esewa");
          handlePaymentSuccess(data, price, id, context);
        },
        onPaymentFailure: (data) {},
        onPaymentCancellation: (data) {},
      );
    } on Exception catch (e) {}
  }
}
