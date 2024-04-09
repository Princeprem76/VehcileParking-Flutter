// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/auth/login_page.dart';
import 'package:vehicle_parking/pages/auth/services/authentication_services.dart';

class Signupp extends StatefulWidget {
  final String email;
  const Signupp({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignuppState createState() => _SignuppState();
}

class _SignuppState extends State<Signupp> {
  String _myActivity = '';
  String _myActivityResult = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController phonec = TextEditingController();
  final TextEditingController fname = TextEditingController();
  final TextEditingController address = TextEditingController();
  bool presentphone = false;
  bool emptyphone = false;
  bool emptyfname = false;
  bool emptyaddress = false;
  late int data;

  @override
  void initState() {
    _myActivity = '';
    _myActivityResult = '';
    super.initState();
  }

  _userdetails() {
    AuthenticationService.customerDetails(
      fname.text,
      address.text,
      phonec.text,
    ).then((response) async {
      if (response.statusCode == 200) {
        presentphone = false;
        // ignore: use_build_context_synchronously

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      }
    });
  }

  final SnackBar _snackBar = const SnackBar(
    content: Text('Account Created!'),
    duration: Duration(seconds: 3),
  );
  // ignore: unused_field
  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Server Error!'),
    duration: Duration(seconds: 3),
  );

  // ignore: unused_element
  _saveForm() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundBlack,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.5,
                height: width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: GlobalVariables.primaryBlue.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 15,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    width: width * 1.5,
                    height: height * 1.5,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Vehicle Parking ',
                style: TextStyle(
                  color: GlobalVariables.regularWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextField(
                      obscureText: false,
                      controller: fname,
                      onChanged: (val) {
                        emptyfname = false;
                      },
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Name',
                        hintText: 'Name',
                        errorText:
                            emptyfname ? 'Please provide your Name!' : null,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: false,
                      controller: phonec,
                      onChanged: (val) {
                        emptyphone = false;
                        presentphone = false;
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Phone',
                        hintText: 'Phone Number',
                        errorText: emptyphone
                            ? 'Please provide a phone number!'
                            : presentphone
                                ? 'This phone number is already present!'
                                : null,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: false,
                      controller: address,
                      onChanged: (val) {
                        emptyaddress = false;
                      },
                      keyboardType: TextInputType.streetAddress,
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        labelText: 'Address',
                        hintText: 'Address',
                        errorText: emptyaddress
                            ? 'Please provide your address!'
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 210),
                      child: ElevatedButton(
                        onPressed: () {
                          if (fname.text.isEmpty) {
                            setState(() {
                              emptyfname = true;
                            });
                          } else if (address.text.isEmpty) {
                            setState(() {
                              emptyaddress = true;
                            });
                          } else if (phonec.text.isEmpty) {
                            setState(() {
                              emptyphone = true;
                            });
                          } else {
                            setState(
                              () {
                                _userdetails();
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(3, 218, 197, 1),
                          fixedSize: const Size(140, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.face,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Done",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
