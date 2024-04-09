import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_button.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/payment.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({
    Key? key,
  }) : super(key: key);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  List data = [];
  List data1 = [];

  void initState() {
    _bookingData();
    super.initState();
  }

  _bookingData() {
    HomeService.bookHistory().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);
        setState(() {
          data = vData['data'];
        });
      }
    });
  }

  _checkout(String price, String pname, String id) {
    HomeService.checkout().then((response) async {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentPage(
                    price: price,
                    pname: pname,
                    id: id,
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalVariables.blueColor,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookingDataDetails()),
              );
            },
          ),
          title: const Text(
            "BOOKING STATUS",
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
        body: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                          Center(
                                            child: PrimaryButton(
                                                icon: Icons.person,
                                                text: 'Check Out',
                                                onPressed: () {
                                                  _checkout(
                                                      data[index]['price']
                                                          .toString(),
                                                      data[index]
                                                              ['parking_spot']
                                                          ['slot_name'],
                                                      data[index]['id']
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
        ]));
  }
}
