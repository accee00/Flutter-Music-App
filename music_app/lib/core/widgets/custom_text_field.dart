import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.isReadOnly = false,
    this.onTap,
  });
  final String hintText;
  final TextEditingController? controller;
  final bool isObscureText;
  final bool isReadOnly;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: isReadOnly,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      obscureText: isObscureText,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
