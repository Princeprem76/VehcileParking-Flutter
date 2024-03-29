import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/booking_history.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';

class ButtomAppBar extends StatelessWidget {
  const ButtomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
          //        Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const notification();
          //   ),
          // );
              },
            ),
            IconButton(
              icon: const Icon(Icons.timelapse_sharp),
              onPressed: () {
                 Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookingDetails()
            ),
          );
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {
          //        Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const account()
          //   ),
          // );
              },
            )
          ],
        ),
      ),
    );
  }
}
