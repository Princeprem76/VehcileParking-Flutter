import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';

class CustomSnackbar {
  static show({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Text(
          message,
          style: const TextStyle(color: GlobalVariables.regularWhite),
        ),
        backgroundColor: GlobalVariables.primaryRed,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
