import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/booking_history.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';
import 'package:lottie/lottie.dart';
import '../../constants/global_variables.dart';

const Map<String, String> _data = {
  'two': 'Two Wheeler',
  'four': 'Four Wheeler',
};

class BookingPage extends StatefulWidget {
  final String sid;
  final String sname;
  const BookingPage({
    super.key,
    required this.sid,
    required this.sname,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _vnumberController = TextEditingController();
  final TextEditingController _slotController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String dropdownValue = _data.keys.first;
  bool emptyname = false;
  var price;
  @override
  void initState() {
    _checkprice();
    _slotController.text = widget.sname;
    super.initState();
  }

  _book() {
    HomeService.bookSlot(
            dropdownValue, _vnumberController.text, widget.sid.toString())
        .then((response) async {
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vehcile Parking Booked!'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookingDetails()),
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

  _checkprice() {
    HomeService.checkprice().then((response) async {
      if (response.statusCode == 200) {
        var newdata = json.decode(response.body);
        print(newdata);
        setState(() {
          price = newdata;
          _priceController.text =
              newdata['data']['two_wheeler_price'].toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.blueColor,
        title: const Text(
          "BOOK SLOT",
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/images/running_car.json',
                        width: 300,
                        height: 200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: GlobalVariables.blueColor,
                  ),
                  SizedBox(height: height * 0.035),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              height: height * 0.09,
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Select Vehicle Type",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    hint: const Text('Select a Vehicle Type'),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 181, 160, 208)),
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        if (dropdownValue == "four") {
                                          _priceController.text = price['data']
                                                  ['four_wheeler_price']
                                              .toString();
                                        } else {
                                          _priceController.text = price['data']
                                                  ['two_wheeler_price']
                                              .toString();
                                        }
                                      });
                                    },
                                    items: <String>['two', 'four']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            )),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            obscureText: false,
                            controller: _vnumberController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter vehicle number';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              labelText: 'Vehicle Number',
                              hintText: 'Vehicle Number',
                              errorText: emptyname
                                  ? 'Please provide vehicle number'
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Slot Name",
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: GlobalVariables.blueColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.sname,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text("Price Per Hour"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 30,
                                        color: GlobalVariables.blueColor,
                                      ),
                                      Text(
                                        _priceController.text,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          color: GlobalVariables.blueColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _book();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: GlobalVariables.blueColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Book Now",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
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
    );
  }
}
