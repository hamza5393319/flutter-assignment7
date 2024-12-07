import 'package:flutter/material.dart';

class TextFieldReusable extends StatelessWidget {
  const TextFieldReusable({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue,
              width: 1
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),

        ),

        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
      validator: validator,
    );
  }
}
