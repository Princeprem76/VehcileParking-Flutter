import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final String? hintText;
  final bool? obscureText;
  final double? borderRaduis;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool? showCursor;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.onTap,
    this.keyboardType,
    this.fillColor,
    this.hintText,
    this.obscureText,
    this.borderRaduis,
    this.maxLines,
    this.suffixIcon,
    this.showCursor,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: GlobalVariables.regularWhite,
        fontSize: 17,
      ),
      controller: controller ?? TextEditingController(),
      keyboardType: keyboardType ?? TextInputType.multiline,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      showCursor: showCursor ?? true,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? GlobalVariables.primaryGrey,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText ?? '',
        hintStyle: const TextStyle(
          color: GlobalVariables.regularWhite,
          fontSize: 17,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis ?? 25),
          borderSide: const BorderSide(color: GlobalVariables.primaryPurple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis ?? 25),
          borderSide: const BorderSide(color: GlobalVariables.backgroundBlack),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis ?? 25),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis ?? 25),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
      onSaved: (value) {
        controller!.text = value!;
      },
    );
  }
}