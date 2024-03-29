// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_parking/pages/home/home_page.dart';


class PaymentPage extends StatefulWidget {
  int price;
  String pname;
  int id;
  int user;
  String email;
  PaymentPage({
    Key? key,
    required this.price,
    required this.pname,
    required this.id,
    required this.user,
    required this.email,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late ESewaPnp _esewaPnp;
  late ESewaConfiguration _configuration;

  Future paymentDetail(String method, int service, int user, int price, String pay) async {
    final http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/paymentapi/v1/paymentsuccess/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        <String, dynamic>{
          'service': service,
          'payment_method': method,
          'price': price,
          'user': user,
          'pay':pay,
        },
      ),
    );
    if (response.statusCode == 200) {
      var result = json.decode(response.body).toString();
      if (result == "Success") {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
    }
  }
  final SnackBar _snackBar = const SnackBar(
    content: Text('Appointment Booked!'),
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
                              paymentDetail("E-payment", widget.id, widget.user,
                                  widget.price, "True");
                            },
                            onFailure: (e) {},
                            color: const Color(0xFF60BB47), // Green background
                            labelBuilder: (amount, esewaLogo) {
                              return Text("Pay Rs. $amount with esewa",style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),);
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
                            paymentDetail("Cash", widget.id, widget.user,
                                widget.price,"False");
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
