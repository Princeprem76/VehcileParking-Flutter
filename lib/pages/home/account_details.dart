import 'package:flutter/material.dart';
import 'package:vehicle_parking/common/widgets/custom_button.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/auth/login_page.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/change_pw.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';
import 'package:vehicle_parking/pages/home/notification.dart';
import 'dart:convert';

import 'package:vehicle_parking/pages/home/services/home_services.dart';
import 'package:vehicle_parking/pages/home/user_details.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({
    Key? key,
  }) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userdata();
  }

  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Server Error!'),
    duration: Duration(seconds: 3),
  );
  _userdata() {
    HomeService.userData().then((response) async {
      if (response.statusCode == 200) {
        var vData = json.decode(response.body);
        setState(() {
          name.text = vData['name'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.blueColor,
        title: const Text(
          "PROFILE",
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
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 60.0,
                              foregroundImage:
                                  ExactAssetImage('assets/images/logo.png'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              name.text,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: PrimaryButton(
                                text: 'Change Password',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePassword(name: name.text),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: PrimaryButton(
                                text: 'Edit Details',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Userdetails(),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: PrimaryButton(
                          text: 'Log Out',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully Logged out!'),
                                backgroundColor: GlobalVariables.primaryRed,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
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
