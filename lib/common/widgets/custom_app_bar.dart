import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';
import 'custom_back_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function()? onBackButtonPressed;
  final List<Widget>? action;

  const CustomAppBar({
    Key? key,
    this.title,
    this.onBackButtonPressed,
    this.action,
  })  : prefferedSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final Size prefferedSize;

  @override
  Size get preferredSize => prefferedSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: GlobalVariables.backgroundBlack,
      leading: CustomBackIcon(onPressed: onBackButtonPressed),
      leadingWidth: 100,
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: GlobalVariables.regularWhite,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: action,
    );
  }
}
