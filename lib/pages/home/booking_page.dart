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
  const BookingPage({
    super.key,
    required this.sid,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _vnumberController = TextEditingController();
  String dropdownValue = _data.keys.first;
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
                'Vehicle Parking',
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
                      SizedBox(
                        height: height * 0.08,
                        width: width,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          hint: const Text('Select a Vehicle Type'),
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['two', 'four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormField(
                        controller: _vnumberController,
                        hintText: 'Vehcile Number',
                        keyboardType: TextInputType.text,
                        borderRaduis: 15,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your vehicle number';
                          }
                          return null;
                        },
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
    );
  }
}
