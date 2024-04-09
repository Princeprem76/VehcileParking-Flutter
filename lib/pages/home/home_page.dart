// ignore_for_file: import_of_legacy_library_into_null_safe, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_app_bar.dart';
import 'package:vehicle_parking/common/widgets/custom_buttom_app_bar.dart';
import 'package:vehicle_parking/common/widgets/custom_content_box.dart';
import 'package:vehicle_parking/common/widgets/parking_slots.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/home/account_details.dart';
import 'package:vehicle_parking/pages/home/booking_history.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/notification.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

const Color backgroundColor = Color(0xFF4A4A58);

class homepage extends StatefulWidget {
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, animation2) {
        return const homepage();
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

  const homepage({
    Key? key,
  }) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  List data = [];
  late String username;

  @override
  void initState() {
    username = '';
    _checkData();
    _vehicleData();

    super.initState();
  }

  _vehicleData() {
    HomeService.slots().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);

        setState(() {
          data = vData['space'];
        });
      }
    });
  }

  _checkData() {
    HomeService.checkdata().then((response) async {
      if (response.statusCode == 200) {
        var newdata = json.decode(response.body);
        if (newdata['booking'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookingDetails()),
          );
        } else {}
      }
    });
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
                          height: screenHeight,
                          width: 510,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, right: 10.0, left: 15, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Available Slots,',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(
                                    child: RefreshIndicator(
                                  onRefresh: () async {
                                    _vehicleData();
                                  },
                                  child: SizedBox(
                                    height: screenHeight * 0.9,
                                    width: screenWidth * 1,
                                    child: data.isNotEmpty
                                        ? GridView.count(
                                            crossAxisCount: 2,
                                            childAspectRatio: 2.0,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 20,
                                            children: List.generate(data.length,
                                                (index) {
                                              return ParkingSlot(
                                                  isBooked: data[index]
                                                      ['status'],
                                                  slotName: data[index]
                                                      ['slot_name'],
                                                  slotId: data[index]['id']
                                                      .toString());
                                            }),
                                          )
                                        : const Center(
                                            child: Text('No Slot Available'),
                                          ),
                                  ),
                                ))
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
                        builder: (context) => const homepage(),
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
                        builder: (context) => const NotifyDetails(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.timelapse_sharp),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookingDataDetails()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountDetails()),
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
