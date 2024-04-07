import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_button.dart';
import 'package:vehicle_parking/pages/admin/admin_account.dart';
import 'package:vehicle_parking/pages/admin/admin_booking_history.dart';
import 'package:vehicle_parking/pages/admin/admin_home.dart';
import 'package:vehicle_parking/pages/admin/admin_notification.dart';
import 'package:vehicle_parking/pages/admin/services/admin_services.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/payment.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class CheckOutBooking extends StatefulWidget {
  const CheckOutBooking({
    Key? key,
  }) : super(key: key);

  @override
  _CheckOutBookingState createState() => _CheckOutBookingState();
}

class _CheckOutBookingState extends State<CheckOutBooking> {
  List data = [];
  List data1 = [];

  void initState() {
    _bookingData();
    super.initState();
  }

  _bookingData() {
    AdminHomeService.checkoutdata().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);
        setState(() {
          data = vData['data'];
        });
      }
    });
  }

  _checkout(String id) {
    AdminHomeService.checkout(id).then((response) async {
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CheckOutBooking()),
        );
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
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.black,
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const adminhomepage()),
                                  );
                                });
                              },
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.05),
                            const Text(
                              'Check Out Request',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      _bookingData();
                    },
                    child: SizedBox(
                      height: 650,
                      child: data.isNotEmpty
                          ? ListView.separated(
                              itemCount: data.length,
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
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Parking Date time: ${data[index]['parking_time']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'User: ${data[index]['user_name']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Vehicel Number: ${data[index]['vehicle']['vehicle_number']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Vehcile Type: ${data[index]['vehicle']['vehicle_type'].toString().toUpperCase()} Wheeler',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Parking Spot: ${data[index]['parking_spot']['slot_name']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Check Out Time: ${data[index]['check_out_time']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Price: ${data[index]['price']}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Center(
                                          child: PrimaryButton(
                                              icon: Icons.person,
                                              text: 'Check Out',
                                              onPressed: () {
                                                _checkout(data[index]['id']
                                                    .toString());
                                              }),
                                        ),
                                      ],
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
