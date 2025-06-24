import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  const BaseTextFormField({
    super.key,
    this.controller,
    this.decoration,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}
