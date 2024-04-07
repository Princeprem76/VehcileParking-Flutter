import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/admin/admin_home.dart';
import 'package:vehicle_parking/pages/admin/services/admin_services.dart';

class AddPrice extends StatefulWidget {
  AddPrice({
    Key? key,
  }) : super(key: key);

  @override
  _AddPriceState createState() => _AddPriceState();
}

class _AddPriceState extends State<AddPrice> {
  final two = TextEditingController();
  final four = TextEditingController();

  _updateprice() {
    AdminHomeService.addprice(
            two.text, four.text)
        .then((response) async {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Price Updated!'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const adminhomepage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong'),
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Add Price",
                              style: TextStyle(
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
                          TextFormField(
                            controller: two,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Two Wheeler Price',
                              hintText: 'Two Wheeler Price',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a price';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: four,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              labelText: 'Four Wheeler Price',
                              hintText: 'Four Wheeler Price',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a price';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 180,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _updateprice();
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
