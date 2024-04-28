import 'package:amazon_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPass;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.isPass = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: TextFormField(
        maxLines: widget.maxLines,
        obscureText: widget.isPass,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: GlobalVariables.backgroundColor,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 149, 149, 151),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 149, 149, 151),
            ),
          ),
        ),
        validator: (val) {
          if(val == null || val.isEmpty){
            return 'Enter your ${widget.hint}';
          }
          return null;
        },
      ),
    );
  }
}