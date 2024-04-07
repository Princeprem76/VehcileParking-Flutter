import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/booking_history.dart';
import 'package:vehicle_parking/pages/home/payment.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_textfield.dart';
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
  TextEditingController _slotController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
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
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Column(
                        children: [
                          Row(children: [
                            InkWell(
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
                            SizedBox(width: height * 0.05),
                            const Text(
                              'Book Slot',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(
                              obscureText: false,
                              controller: _slotController,
                              enabled: false,
                              style: const TextStyle(color: Colors.blue),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                                labelText: "Slot Number",
                                hintText: "Slot Number",
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            SizedBox(
                              height: height * 0.08,
                              width: width,
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                hint: const Text('Select a Vehicle Type'),
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 181, 160, 208)),
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
                                items: <String>[
                                  'two',
                                  'four'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        )),
                                  );
                                }).toList(),
                              ),
                            ),
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
                            SizedBox(height: height * 0.02),
                            TextField(
                              obscureText: false,
                              controller: _priceController,
                              readOnly: true,
                              style: const TextStyle(color: Colors.blue),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                                labelText: 'Price per Hour',
                                hintText: 'Price',
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: PrimaryButton(
                                icon: Icons.person,
                                text: 'Book',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _book();
                                  }
                                },
                              ),
                            )
                          ],
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
