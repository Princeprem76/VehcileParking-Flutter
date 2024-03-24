import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';

class CustomBackIcon extends StatelessWidget {
  final void Function()? onPressed;
  const CustomBackIcon({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ??
          () {
            Navigator.of(context).pop();
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
                Icons.arrow_back_ios,
                color: GlobalVariables.backgroundBlack,
              ),
      ),
    );
  }
}
