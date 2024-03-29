import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/booking_page.dart';

class CustomBoxButton extends StatelessWidget {
  final String? buttonTitle;
  final String id;

  const CustomBoxButton({
    super.key,
    required this.buttonTitle,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.13,
      width: width * 0.001,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.0),
        border: Border.all(color: Colors.white, width: 3.0),
      ),
      child: ElevatedButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingPage(sid: id)),
          ),
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const Icon(
                Icons.emoji_transportation_rounded,
                size: 45,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                buttonTitle!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
