import 'package:flutter/material.dart';
import 'package:vehicle_parking/pages/home/account_details.dart';
import 'package:vehicle_parking/pages/home/bookings_data.dart';
import 'package:vehicle_parking/pages/home/home_page.dart';
import 'package:vehicle_parking/pages/home/notification.dart';

class ButtomAppBar extends StatelessWidget {
  const ButtomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: BottomAppBar(
        color: const Color.fromARGB(255, 123, 232, 219),
        shape: const CircularNotchedRectangle(),
        notchMargin: 1.0,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(bottom: 0), // Adjust the padding
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home, size: 24), // Adjust the icon size
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
                icon: const Icon(Icons.notifications,
                    size: 24), // Adjust the icon size
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
                icon: const Icon(Icons.timelapse_sharp,
                    size: 24), // Adjust the icon size
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookingDataDetails()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_outlined,
                    size: 24), // Adjust the icon size
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
    );
  }
}
