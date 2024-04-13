// ignore_for_file: import_of_legacy_library_into_null_safe, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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
import 'package:vehicle_parking/pages/admin/services/admin_services.dart';
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
  late String daily;
  late String monthly;
  late Future<Map<String, double>> dataMapFuture;
  final colorList = <Color>[
    Colors.redAccent,
    Colors.deepOrange,
    Colors.greenAccent,
  ];
  Future<Map<String, double>> _loadData() async {
    final response = await AdminHomeService.pieData();
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Map<String, double>.from(
          jsonData.map((key, value) => MapEntry(key, value.toDouble())));
    } else {
      throw Exception('Failed to load data');
    }
  }

  _revenue() {
    AdminHomeService.revenue().then((response) async {
      if (response.statusCode == 200) {
        setState(() {
          var resJson = jsonDecode(response.body);
          daily = resJson['daily'].toString();
          monthly = resJson['monthly'].toString();
        });
      }
    });
  }

  @override
  void initState() {
    username = '';
    
    daily = '0';
    monthly = '0';
    _revenue();
    super.initState();
    dataMapFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              automaticallyImplyLeading: false,
              backgroundColor: GlobalVariables.blueColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                title: const Text("Vehicle Park",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                background: Image.asset(
                  "assets/images/car.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: screenHeight,
                    width: 510,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 10.0, left: 15, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Availibilty Chart,',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Expanded(
                            child: FutureBuilder<Map<String, double>>(
                              future: dataMapFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.hasData) {
                                  return PieChart(
                                    dataMap: snapshot.data ?? {},
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 32,
                                    centerText: "Occupancy",
                                    legendOptions: const LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: true,
                                      legendShape: BoxShape.circle,
                                      legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartValuesOptions:
                                        const ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Revenue Details,',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Monthly Revenue:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Rs $monthly', // Replace with actual monthly revenue
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Daily Revenue:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Rs $daily', // Replace with actual daily revenue
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'More Features,',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: const Color.fromARGB(255, 75, 215, 206),
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
                                            color: Colors.blue
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'Check Slot',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue
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
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: const Color.fromARGB(255, 75, 215, 206),
                                        width: 3.0),
                                  ),
                                  child: TextButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddSlot()),
                                      ),
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.add_box_rounded,
                                            size: 45,
                                            color: Colors.blue
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            'Add Slot',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue
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
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: const Color.fromARGB(255, 75, 215, 206),
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
                                            color: Colors.blue
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Parking Status',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue
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
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: const Color.fromARGB(255, 75, 215, 206),
                                        width: 3.0),
                                  ),
                                  child: TextButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddPrice()),
                                      ),
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.monetization_on,
                                            size: 45,
                                            color: Colors.blue
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            'Add Price',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue
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
