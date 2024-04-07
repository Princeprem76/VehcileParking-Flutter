import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class ChangePassword extends StatefulWidget {
  String name;
  ChangePassword({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool pwseen = false;
  bool pwseen1 = false;
  bool pwseen2 = false;
  final oldpw = TextEditingController();
  final newpw = TextEditingController();
  final repw = TextEditingController();
  bool iscorrect = false;
  bool issame = false;

  updatepw(String oldpassword, String newpw) async {
    HomeService.changepw(oldpassword, newpw).then((response) async {
      if (response.statusCode == 200) {
        var result = json.decode(response.body).toString();
        if (result == "Password Updated") {
          Navigator.pop(context);
          setState(() {
            iscorrect = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        } else {
          setState(() {
            iscorrect = true;
            ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
          });
        }
      } else {}
    });
  }

  final SnackBar _snackBar = const SnackBar(
    content: Text('Password Changed!'),
    duration: Duration(seconds: 3),
  );
  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Server Error!'),
    duration: Duration(seconds: 3),
  );

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
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 350.0),
                              child: InkWell(
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 60.0,
                              foregroundImage:
                                  ExactAssetImage('assets/images/logo.png'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                            controller: oldpw,
                            obscureText: pwseen ? false : true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Old Password',
                              hintText: 'Enter Password',
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
                            controller: newpw,
                            obscureText: pwseen1 ? false : true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'New Password',
                              hintText: 'Enter Password',
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
                          TextField(
                            controller: repw,
                            obscureText: pwseen2 ? false : true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Re-Password',
                              hintText: 'Enter Password',
                              suffixIcon: IconButton(
                                icon: pwseen2
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    if (pwseen2 == true) {
                                      pwseen2 = false;
                                    } else {
                                      pwseen2 = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          issame
                              ? const Text(
                                  "Password doesn't match!",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                )
                              : iscorrect
                                  ? const Text('Current password is wrong!')
                                  : const Text(''),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 180,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                final String newpass = newpw.text;
                                final String oldpass = oldpw.text;
                                final String repass = repw.text;
                                if (newpass == repass) {
                                  setState(() {
                                    issame = false;
                                    updatepw(oldpass, newpass);
                                  });
                                } else {
                                  setState(() {
                                    issame = true;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(3, 218, 197, 1),
                                fixedSize: const Size(300, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Confirm",
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
