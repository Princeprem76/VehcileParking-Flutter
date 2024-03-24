import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_parking/pages/auth/login_page.dart';
import 'package:vehicle_parking/pages/splash_screen/services/splash_screen_service.dart';
import '../../../constants/global_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // autoLogin();
      Navigator.pushReplacement(context, LoginScreen.route());
    });
  }

  storeData(String token, String refresh) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('refresh', refresh);
  }

  autoLogin() {
    SplashScreenServices.autoLogin().then((response) {
      try {
        if (response is Exception) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('$response'),
              backgroundColor: GlobalVariables.primaryBlue,
            ),
          );
        } else if (response.statusCode == 200) {
          try {
            final Map<String, dynamic> responseData =
                json.decode(response.body.toString());
            storeData(
              responseData['access'],
              responseData['refresh'],
            );

            Navigator.pushReplacement(context, LoginScreen.route());
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('$e'),
                backgroundColor: GlobalVariables.primaryRed,
              ),
            );
          }
        } else {
          Navigator.pushReplacement(context, LoginScreen.route());
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('$e'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: GlobalVariables.backgroundBlack,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.5,
                height: width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: GlobalVariables.primaryBlue.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 15,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    width: width*1.5,
                    height: height*1.5,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Vehicle Parking',
                style: TextStyle(
                  color: GlobalVariables.primaryBlue,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.06),
              const CircularProgressIndicator(
                color: GlobalVariables.primaryRed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
