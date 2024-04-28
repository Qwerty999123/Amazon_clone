import 'package:amazon_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  bool isLoading;
  Color color;
  double borderRadius;
  Color fontColor;

  CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.color = GlobalVariables.secondaryColor,
    this.borderRadius = 5,
    this.fontColor = GlobalVariables.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)
          )
        ),
        onPressed: onTap, 
        child: isLoading!
        ? CircularProgressIndicator() 
        : Text(
          text,
          style: TextStyle(
            color: fontColor,
            fontSize: 16
          ),
        )
      ),
    );
  }
}