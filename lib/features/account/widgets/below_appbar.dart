import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatefulWidget {
  const BelowAppBar({super.key});

  @override
  State<BelowAppBar> createState() => _BelowAppBarState();
}

class _BelowAppBarState extends State<BelowAppBar> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              )
            ),
            TextSpan(
              text: user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25,
              )
            ),
          ]
        )
      ),
    );
  }
}