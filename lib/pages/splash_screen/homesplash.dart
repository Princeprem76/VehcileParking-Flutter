import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';

class HomeSplashScreen extends StatefulWidget {
  const HomeSplashScreen({super.key});

  @override
  State<HomeSplashScreen> createState() => _HomeSplashScreenState();
}
class _HomeSplashScreenState extends State<HomeSplashScreen>{
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(homepage.route());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/images/running_car.json',
                      width: 300,
                      height: 300,
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vehicle Parking",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "This is a Car parking app for City Center, Here you can find Avalible slot and book your parking slot from any where with your mobile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          // Expanded(
          //     child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset(
          //       collegeLogo,
          //       width: 200,
          //     )
          //   ],
          // )),
        ]),
      ),
    );
  }
}
