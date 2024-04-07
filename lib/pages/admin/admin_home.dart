// ignore_for_file: import_of_legacy_library_into_null_safe, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_app_bar.dart';
import 'package:vehicle_parking/common/widgets/custom_buttom_app_bar.dart';
import 'package:vehicle_parking/common/widgets/custom_content_box.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/admin/add_price.dart';
import 'package:vehicle_parking/pages/admin/add_slot.dart';
import 'package:vehicle_parking/pages/admin/admin_account.dart';
import 'package:vehicle_parking/pages/admin/admin_booking_history.dart';
import 'package:vehicle_parking/pages/admin/admin_notification.dart';
import 'package:vehicle_parking/pages/admin/check_out.dart';
import 'package:vehicle_parking/pages/admin/check_slot.dart';
import 'package:vehicle_parking/pages/admin/parking_status.dart';
import 'package:vehicle_parking/pages/home/account_details.dart';
import 'package:vehicle_parking/pages/home/booking_history.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/notification.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

const Color backgroundColor = Color(0xFF4A4A58);

class adminhomepage extends StatefulWidget {
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, animation2) {
        return const adminhomepage();
      },
      transitionsBuilder: (context, animation, animation2, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      fullscreenDialog: true,
    );
  }

  const adminhomepage({
    Key? key,
  }) : super(key: key);

  @override
  _adminhomepageState createState() => _adminhomepageState();
}

class _adminhomepageState extends State<adminhomepage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  late String username;

  @override
  void initState() {
    username = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Material(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.95,
                        width: 510,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, right: 10.0, left: 15, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Vehicle Park',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Welcome Admin,',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                  // height: screenHeight * 0.5,
                                  // width: screenWidth * 1,
                                  child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 169, 14, 14),
                                            width: 3.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const slotpage()),
                                          ),
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.local_parking_outlined,
                                                size: 45,
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                'Check Slot',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      height: 150,
                                      width: 150,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 169, 14, 14),
                                            width: 3.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddSlot()),
                                          ),
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.add_box_rounded,
                                                size: 45,
                                              ),
                                              SizedBox(
                                                height: 35,
                                              ),
                                              Text(
                                                'Add Slot',
                                                style: TextStyle(
                                                  fontSize: 20,
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
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 169, 14, 14),
                                            width: 3.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminParkingStatus()),
                                          ),
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.confirmation_number,
                                                size: 45,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Parking Status',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      height: 150,
                                      width: 150,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 169, 14, 14),
                                            width: 3.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPrice()),
                                          ),
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.monetization_on,
                                                size: 45,
                                              ),
                                              SizedBox(
                                                height: 35,
                                              ),
                                              Text(
                                                'Add Price',
                                                style: TextStyle(
                                                  fontSize: 20,
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
                              ])),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const adminhomepage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminNotifyDetail(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckOutBooking()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.timelapse_sharp),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminBookingData()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminAccountDetails()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
