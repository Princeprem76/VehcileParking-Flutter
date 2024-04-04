import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        // } else if (result == "Email exists") {
        //   empresent = true;
        // } else {
        //   invaemail = true;
        // }
      } else {}
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
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vehicle Parking Sign Up',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      '1 of 2 Steps',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextField(
                            obscureText: false,
                            controller: emailco,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (val) {
                              empresent = false;
                              invaemail = false;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              errorText: emptyem
                                  ? 'Please provide email!'
                                  : invaemail
                                      ? 'Invalid Email Address'
                                      : empresent
                                          ? 'Email already exists!'
                                          : null,
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
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
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
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Re-Password',
                              hintText: 'Confirm Password',
                              errorText:
                                  pass ? null : "Password doesn't match!",
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
                              left: 170,
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
                                          print("A");
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
                    )
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
