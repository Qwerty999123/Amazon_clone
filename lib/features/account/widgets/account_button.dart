import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AccountButton({
    super.key,
    required this.onTap,
    required this.text,

  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(
                color: Color.fromRGBO(182, 181, 181, 1)
              )
            ),
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.9)
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ), 
      ),
    );
  }
}