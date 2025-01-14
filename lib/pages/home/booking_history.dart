import 'dart:convert';
import 'package:flutter/material.dart';
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
  late List comments = [];
  final _commentControl = TextEditingController();

  @override
  void initState() {
    _bookingData();
    _getcomment();
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

  _addcomment(String id, String comment) {
    HomeService.addcomment(id, comment).then((response) async {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingDetails()),
        );
      }
    });
  }

  _getcomment() {
    HomeService.getcomments().then((response) async {
      if (response.statusCode == 200) {
        var cmtData = json.decode(response.body);
        var commentsList = cmtData['comments'];
        if (commentsList != null) {
          setState(() {
            comments = commentsList;
          });
        }
        else{
          setState(() {
            comments = commentsList;
          });
        }
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/parkings.png',
                          width: 300,
                          height: 190,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    RefreshIndicator(
                      onRefresh: () async {
                        _bookingData();
                      },
                      child: SizedBox(
                        height: 500,
                        child: data.isNotEmpty
                            ? ListView.separated(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Your Slot Name",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color:
                                                    GlobalVariables.blueColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  data[index]['parking_spot']
                                                      ['slot_name'],
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Parking Date time: ${data[index]['parking_time']}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Vehicle Number: ${data[index]['vehicle']['vehicle_number']}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Parking Status: ${data[index]['parking_status']}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Price",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.currency_rupee,
                                                      size: 30,
                                                      color: GlobalVariables
                                                          .blueColor,
                                                    ),
                                                    Text(
                                                      data[index]['price']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: GlobalVariables
                                                            .blueColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _checkout(
                                                    data[index]['price']
                                                        .toString(),
                                                    data[index]['parking_spot']
                                                        ['slot_name'],
                                                    data[index]['id']
                                                        .toString());
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 60,
                                                        vertical: 20),
                                                decoration: BoxDecoration(
                                                  color:
                                                      GlobalVariables.blueColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Text(
                                                  "Check Out",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // Display comment box if there are no comments
                                        
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: _commentControl,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Add a comment...',
                                                    suffixIcon: IconButton(
                                                      // ignore: prefer_const_constructors
                                                      icon: Icon(Icons.send),
                                                      onPressed: () => {
                                                        _addcomment(
                                                            data[index]['id']
                                                                .toString(),
                                                            _commentControl
                                                                .text)
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 10),

                                        // Displaying comments and replies
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: comments.length,
                                          itemBuilder: (context, commentIndex) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comments[commentIndex]["name"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(comments[commentIndex]
                                                    ["comment"]),
                                                const SizedBox(height: 10),
                                                // Display replies if available
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      comments[commentIndex]
                                                          ["replies"]
                                                          .length,
                                                  itemBuilder:
                                                      (context, replyIndex) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          
                                                          Text(
                                                            comments[
                                                                    commentIndex]
                                                                ["replies"][
                                                                    replyIndex]
                                                                ["name"],
                                                            style: const TextStyle(
                                                              color: Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(comments[
                                                                  commentIndex]
                                                              ["replies"][
                                                                  replyIndex]
                                                              ["reply"]),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                
                                                const SizedBox(height: 10),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
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
        ],
      ),
    );
  }
}
