// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:vehicle_parking/pages/auth/services/authentication_services.dart';
import 'package:vehicle_parking/pages/auth/signup_page.dart';

class Verify extends StatefulWidget {
  final String email;
  const Verify({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final TextEditingController codec = TextEditingController();
  bool matchcode = false;
  bool emptycode = false;
  int codde = 0;

  @override
  void initState() {
    super.initState();
  }

  sendcode() {
    AuthenticationService.customerVerify(
      widget.email,
      codec.text,
    ).then((response) async {
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        matchcode = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Signupp(
              email: widget.email,
            ),
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      } else {
        setState(() {
          matchcode = true;
          ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
        });
      }
    });
  }

  _resendcode() {
    AuthenticationService.customerResendCode(widget.email)
        .then((response) async {
      if (response.statusCode == 200) {}
    });
  }

  final SnackBar _snackBar = const SnackBar(
    content: Text('Email Verified!'),
    duration: Duration(seconds: 3),
  );
  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Wrong Code!'),
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Verify Email',
                  style: TextStyle(fontSize: 35),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Please check Email for 4 digit Verification Code!',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: PinCodeFields(
                    length: 4,
                    animationDuration: const Duration(milliseconds: 200),
                    animationCurve: Curves.easeInOut,
                    switchInAnimationCurve: Curves.easeIn,
                    switchOutAnimationCurve: Curves.easeOut,
                    animation: Animations.slideInRight,
                    controller: codec,
                    onComplete: (String value) {},
                  ),
                ),
                matchcode
                    ? const SizedBox(
                        height: 20,
                        child: Text(
                          "Code doesn't match",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : const Text(''),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.restart_alt_rounded,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                          GestureDetector(
                            onTap: () => _resendcode(),
                            child: Text(
                              ' Resend Code!',
                              style: TextStyle(
                                  color: Colors.blueAccent[700], fontSize: 22),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: 70,
              right: 20,
            ),
            child: SizedBox(
              width: 130,
              height: 53,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (codec.text.isNotEmpty) {
                    setState(() {
                      emptycode = false;
                      if (int.parse(codec.text) == codde) {
                        setState(() {
                          emptycode = false;
                          matchcode = false;
                          sendcode();
                        });
                      } else {
                        setState(() {
                          matchcode = true;
                        });
                      }
                    });
                  } else {
                    setState(() {
                      emptycode = true;
                    });
                  }
                },
                label: const Row(
                  children: <Widget>[
                    Icon(
                      Icons.verified,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Verify ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ],
                ),
                backgroundColor: const Color.fromRGBO(3, 218, 197, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
