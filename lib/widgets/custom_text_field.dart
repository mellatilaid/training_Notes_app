import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class CustomTextField extends StatelessWidget {
  final double verPadding;
  final String labelText;
  final int maxLines;
  final Function(String?)? onSaved;
  const CustomTextField({
    super.key,
    this.verPadding = 16,
    required this.labelText,
    this.maxLines = 1,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Field required";
        } else {
          return null;
        }
      },
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: kPrimaryColor),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
        )),
      ),
    );
  }
}
