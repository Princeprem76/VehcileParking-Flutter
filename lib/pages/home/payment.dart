// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_parking/common/widgets/esewa.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
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
  }

  double amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalVariables.blueColor,
          title: const Text(
            "PAYMENT",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
        ),
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
                              padding: const EdgeInsets.only(top: 30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Esewa esewa = Esewa();
                                  esewa.pay(widget.price, widget.pname,
                                      widget.id, context);
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
                                      "Pay With Esewa",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
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
