// ignore_for_file: import_of_legacy_library_into_null_safe, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_buttom_app_bar.dart';
import 'package:vehicle_parking/common/widgets/custom_content_box.dart';
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

  // ignore: unnecessary_overrides
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
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
                        height: screenHeight * 0.85,
                        width: 510,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, right: 10.0, left: 15, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                'Welcome,',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Available Slot',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  left: 30.0,
                                ),
                              ),
                              RefreshIndicator(
                                onRefresh: () async {
                                  _vehicleData();
                                },
                                child: SizedBox(
                                  height: screenHeight*0.54,
                                  child: data.isNotEmpty
                                      ? ListView.separated(
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CustomBoxButton(
                                                buttonTitle: data[index]
                                                    ['slot_name'],
                                                id: data[index]['id']
                                                    .toString());
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                        )
                                      : const Center(
                                          child: Text('No Slot Available'),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const ButtomAppBar(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
