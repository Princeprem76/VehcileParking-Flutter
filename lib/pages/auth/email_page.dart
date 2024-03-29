
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgetEmail extends StatefulWidget {
  const ForgetEmail({Key? key}) : super(key: key);

  @override
  _ForgetEmailState createState() => _ForgetEmailState();
}

class _ForgetEmailState extends State<ForgetEmail> {
  bool emptyuser = false;
  final useremail = TextEditingController();
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 100.0,
                    right: 15.0,
                    left: 15,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Vehicle Park",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 35),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Please Provide Email for Password Reset Code!',
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: TextField(
                          controller: useremail,
                          obscureText: false,
                          onChanged: (val) {
                            emptyuser = false;
                          },
                          style: const TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            errorText:
                                emptyuser ? 'Please provide an Email!' : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 160,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (useremail.text != '') {
                              setState(() {
                                emptyuser = false;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ,
                              //   ),
                              // );
                            } else {
                              setState(() {
                                emptyuser = true;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(3, 218, 197, 1),
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
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Send Code",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
