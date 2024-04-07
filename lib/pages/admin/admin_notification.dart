import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_buttom_app_bar.dart';
import 'package:vehicle_parking/pages/admin/admin_account.dart';
import 'package:vehicle_parking/pages/admin/admin_booking_history.dart';
import 'package:vehicle_parking/pages/admin/admin_home.dart';
import 'package:vehicle_parking/pages/admin/check_out.dart';
import 'package:vehicle_parking/pages/home/account_details.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class AdminNotifyDetail extends StatefulWidget {
  const AdminNotifyDetail({
    Key? key,
  }) : super(key: key);

  @override
  _AdminNotifyDetailState createState() => _AdminNotifyDetailState();
}

class _AdminNotifyDetailState extends State<AdminNotifyDetail> {
  List notify = [];

  void initState() {
    _NotifyData();
    super.initState();
  }

  _NotifyData() async {
    HomeService.notificationData().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);
        setState(() {
          notify = vData;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(
                14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // InkWell(
                      //   child: const Icon(Icons.arrow_back_ios_new_outlined,
                      //       color: Colors.black),
                      //   onTap: () {
                      //     setState(() {
                      //       Navigator.pop(context);
                      //     });
                      //   },
                      // ),
                      // const SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    _NotifyData();
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
                    child: notify.isNotEmpty
                        ? ListView.separated(
                            itemCount: notify.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                ),
                                child: ListTile(
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        notify[index]['created'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notify[index]['content'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          )
                        : const Center(child: Text('No items')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]),
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
