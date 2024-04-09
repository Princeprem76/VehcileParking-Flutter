import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_parking/pages/admin/admin_home.dart';
import 'package:vehicle_parking/pages/auth/email_page.dart';
import 'package:vehicle_parking/pages/auth/register_page.dart';
import 'package:vehicle_parking/pages/home/booking_history.dart';
import 'package:vehicle_parking/pages/splash_screen/homesplash.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import './services/authentication_services.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, animation2) {
        return const LoginScreen();
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

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogging = false;
  bool _isPasswordVisible = false;

  storeData(String token, String refresh, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('refresh', refresh);
    prefs.setString('name', name);
  }

  _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _login() {
    AuthenticationService.login(
      _emailController.text,
      _passwordController.text,
    ).then((response) async {
      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseData =
              json.decode(response.body.toString());

          setState(() {
            _isLogging = false;
            storeData(
              responseData['access'],
              responseData['refresh'],
              responseData['user_data']['name'],
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Login successful'),
                  backgroundColor: GlobalVariables.primaryGrey,
                ),
              );
              if (responseData['user_type'] == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const adminhomepage()),
                );
              } else {
                if (responseData['booking'] == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookingDetails()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeSplashScreen()),
                  );
                  
                }
              }
            });
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('$e'),
              backgroundColor: GlobalVariables.primaryRed,
            ),
          );
          setState(() {
            _isLogging = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
            backgroundColor: GlobalVariables.primaryRed,
          ),
        );
        setState(() {
          _isLogging = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundBlack,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    width: width * 1.5,
                    height: height * 1.5,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Vehicle Parking',
                style: TextStyle(
                  color: GlobalVariables.regularWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        borderRaduis: 15,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        borderRaduis: 15,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isPasswordVisible
                                ? GlobalVariables.primaryBlue
                                : GlobalVariables.regularWhite,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(left: 200.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetEmail(),
                                ),
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.blueAccent[700],
                                    fontSize: 20),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      _isLogging
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: GlobalVariables.primaryRed,
                              ),
                            )
                          : Center(
                              child: PrimaryButton(
                                icon: Icons.person,
                                text: 'LOG IN',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLogging = true;
                                    });
                                    _login();
                                  }
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "---------- OR ----------",
                          style: TextStyle(
                            color: GlobalVariables.primarySky,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "New User?",
                            style: TextStyle(
                                color: GlobalVariables.primarySky,
                                fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signup(),
                              ),
                            ),
                            child: const Text(
                              ' Sign Up',
                              style: TextStyle(
                                  color: GlobalVariables.primaryPurple,
                                  fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
