import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_buttom_app_bar.dart';
import 'package:vehicle_parking/pages/home/account_details.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';
import 'package:vehicle_parking/pages/home/notification.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class BookingDataDetails extends StatefulWidget {
  const BookingDataDetails({
    Key? key,
  }) : super(key: key);

  @override
  _BookingDataDetailsState createState() => _BookingDataDetailsState();
}

class _BookingDataDetailsState extends State<BookingDataDetails> {
  List data = [];
  List data1 = [];

  void initState() {
    _bookingData();
    super.initState();
  }

  _bookingData() {
    HomeService.bookDataHistory().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);
        setState(() {
          data = vData['data'];
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
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        'Booking History',
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
                    _bookingData();
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
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
                                        'Vehicel Number: ${data[index]['vehicle']['vehicle_number']}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Parking Status: ${data[index]['parking_status']}',
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
                                      Text(
                                        'Check Out: ${data[index]['check_out']}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
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
