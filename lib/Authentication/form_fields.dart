import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  final String label;
  final FormFieldValidator<String> formValidation;
  final bool filled;
  final String hint;
  final Function change;
  final IconButton iconType;
  final bool obscure;
  final TextInputType typeOfKeyboard;

  InputFields({
    this.label,
    this.formValidation,
    this.filled,
    this.hint,
    this.change,
    this.iconType,
    @required this.obscure,
    this.typeOfKeyboard,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextFormField(
        keyboardType: typeOfKeyboard,
        onChanged: change,
        obscureText: obscure,
        validator: formValidation,
        decoration: InputDecoration(
          suffixIcon: iconType,
          labelText: label,
          filled: filled,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(fontWeight: FontWeight.w300),
          labelStyle: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
