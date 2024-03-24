import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function()? onPressed;
  final double? buttonHeight;
  final double? borderRadius;
  const PrimaryButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.buttonHeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: onPressed,
      color: GlobalVariables.primaryBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 50),
      ),
      child: SizedBox(
        height: buttonHeight ?? height * 0.075,
        width: buttonHeight ?? width * 0.5,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: GlobalVariables.backgroundBlack,
                ),
              SizedBox(
                width: width * 0.02,
              ),
              Text(
                text ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppbarButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onPressed;

  const AppbarButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: width * 0.09,
        decoration: BoxDecoration(
          color: GlobalVariables.primaryBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            CircleAvatar(
              radius: width * 0.03,
              backgroundColor: GlobalVariables.regularWhite,
              child: Icon(
                icon,
                color: GlobalVariables.backgroundBlack,
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
