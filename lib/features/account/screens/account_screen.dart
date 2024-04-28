import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/account/widgets/below_appbar.dart';
import 'package:amazon_app/features/account/widgets/orders.dart';
import 'package:amazon_app/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Image.asset(
            'assets/images/amazon_in.png',
            height: 40,
            color: Colors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.notifications_none)
            ),
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.search)
            ),
            const SizedBox(
              width: 8,
            ),
            
          ],
        ),
      ),

      body: Column(
        children: [
          BelowAppBar(),
          TopButtons(),
          Orders(),
        ],
      )
    );
  }
}