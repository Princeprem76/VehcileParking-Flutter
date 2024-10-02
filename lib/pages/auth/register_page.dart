import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/auth/services/authentication_services.dart';
import 'package:vehicle_parking/pages/auth/verify.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailco = TextEditingController();
  final TextEditingController passwordco = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool pass = true;
  bool empresent = false;
  bool emptypw = false;
  bool emptyem = false;
  bool lesspw = false;
  bool invaemail = false;
  bool pwseen = false;
  bool pwseen1 = false;

  _createuser() {
    AuthenticationService.customerRegister(
      emailco.text,
      passwordco.text,
    ).then((response) async {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verify(
              email: emailco.text,
            ),
          ),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Wrong Email'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Email already exists'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
      }
    });
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
                'Vehicle Parking Registration',
                style: TextStyle(
                  color: GlobalVariables.regularWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        obscureText: false,
                        controller: emailco,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: 'Email',
                          hintText: 'Please Provide Email',
                          errorText: emptyem ? 'Please provide Email' : null,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: pwseen ? false : true,
                        controller: passwordco,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: Colors.blue),
                        onChanged: (val) {
                          emptypw = false;
                          lesspw = false;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          errorText: emptypw
                              ? 'Please enter 6 character long password!'
                              : lesspw
                                  ? 'Password must be 6 character long!'
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
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        obscureText: pwseen1 ? false : true,
                        controller: rePassword,
                        style: const TextStyle(color: Colors.blue),
                        onChanged: (val) {
                          pass = true;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: 'Re-Password',
                          hintText: 'Confirm Password',
                          errorText: pass ? null : "Password doesn't match!",
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
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 220,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (emailco.text == '') {
                              setState(() {
                                emptyem = true;
                              });
                            } else if (passwordco.text.isEmpty) {
                              setState(() {
                                emptypw = true;
                              });
                            } else {
                              if (passwordco.text.length < 6) {
                                setState(() {
                                  lesspw = true;
                                });
                              } else {
                                if (passwordco.text == rePassword.text) {
                                  setState(
                                    () {
                                      pass = true;

                                      _createuser();
                                    },
                                  );
                                } else {
                                  setState(() {
                                    pass = false;
                                  });
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(3, 218, 197, 1),
                            fixedSize: const Size(140, 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
