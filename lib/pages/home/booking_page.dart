import 'dart:convert';

import 'package:flutter/material.dart';
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
            dropdownValue, _vnumberController.text, widget.sid as int)
        .then((response) async {
      if (response.statusCode == 200) {
        setState(() {
              
              Navigator.of(context).pushReplacement(PaymentPage.route());
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
                      DropdownButton<String>(
                        value: _data.values.first,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        items: _data.entries.map<DropdownMenuItem<String>>(
                            (MapEntry<String, String> entry) {
                          return DropdownMenuItem<String>(
                            value: entry.value,
                            child: Text(entry.key),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Update the selected value when the dropdown changes
                          if (value != null) {
                            // Find the corresponding key for the selected value
                            dropdownValue = _data.keys
                                .firstWhere((key) => _data[key] == value);
                          }
                        },
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
