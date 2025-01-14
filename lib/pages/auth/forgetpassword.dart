// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/auth/login_page.dart';
import 'dart:convert';

import 'package:vehicle_parking/pages/auth/services/authentication_services.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final password = TextEditingController();
  final repassword = TextEditingController();
  bool emptypw = false;
  bool pwseen = false;
  bool emptypw1 = false;
  bool pwseen1 = false;
  bool isWro = false;

  final SnackBar _snackBar = const SnackBar(
    content: Text('Password Updated!'),
    duration: Duration(seconds: 3),
  );
  _changepw() {
    AuthenticationService.forgetPasswordVerify(password.text, repassword.text)
        .then((response) async {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Password Updated'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
      }
    });
  }

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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vehcile Park Password Change",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: password,
                            obscureText: pwseen1 ? false : true,
                            onChanged: (val) {
                              emptypw1 = false;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              errorText: emptypw1
                                  ? 'Please enter your password!'
                                  : null,
                              suffixIcon: IconButton(
                                icon: pwseen1
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    if (pwseen1 == true) {
                                      pwseen1 = false;
                                    } else {
                                      pwseen1 = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: repassword,
                            obscureText: pwseen ? false : true,
                            onChanged: (val) {
                              emptypw = false;
                              isWro = false;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Re-Password',
                              hintText: 'Re-Enter Password',
                              errorText: emptypw
                                  ? 'Please re-enter your password!'
                                  : null,
                              suffixIcon: IconButton(
                                icon: pwseen
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    if (pwseen == true) {
                                      pwseen = false;
                                    } else {
                                      pwseen = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          isWro
                              ? const Text(
                                  'Password does not match!',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                )
                              : const Text(''),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (password.text.isEmpty) {
                              setState(() {
                                emptypw1 = true;
                              });
                            } else if (repassword.text.isEmpty) {
                              setState(() {
                                emptypw = true;
                              });
                            } else {
                              final String txtpass = password.text;
                              final String txtpassword = repassword.text;
                              if (txtpassword == txtpass) {
                                _changepw();
                              } else {
                                setState(() {
                                  isWro = true;
                                });
                                
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(3, 218, 197, 1),
                            fixedSize: const Size(160, 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Change",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
