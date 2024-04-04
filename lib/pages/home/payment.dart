// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class PaymentPage extends StatefulWidget {
  String price;
  String pname;
  String id;

  PaymentPage({
    Key? key,
    required this.price,
    required this.pname,
    required this.id,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late ESewaPnp _esewaPnp;
  late ESewaConfiguration _configuration;

  _paymentDetail(String method) {
    HomeService.payments(widget.price.toString(), method, widget.id.toString())
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

  final SnackBar _snackBar = const SnackBar(
    content: Text('Payment Completed!'),
    duration: Duration(seconds: 3),
  );
  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Server Error!'),
    duration: Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();

    _configuration = ESewaConfiguration(
      clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
      secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
      environment: ESewaConfiguration.ENVIRONMENT_TEST,
    );
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  double amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.black),
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: ESewaPaymentButton(
                            _esewaPnp,
                            amount: double.parse(widget.price.toString()),
                            callBackURL: "https://example.com",
                            productId: widget.id.toString(),
                            productName: widget.pname,
                            onSuccess: (result) {
                              _paymentDetail("E-payment");
                            },
                            onFailure: (e) {},
                            color: const Color(0xFF60BB47), // Green background
                            labelBuilder: (amount, esewaLogo) {
                              return Text(
                                "Pay Rs. $amount with esewa",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              );
                            },
                            width: 300.0,
                            height: 70.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _paymentDetail("Cash");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF60BB47),
                            fixedSize: const Size(300, 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.cashRegister,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Cash Payment",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
