import 'package:amazon_app/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              onTap: (){}, 
              text: 'Your Orders'
            ),
            AccountButton(
              onTap: (){}, 
              text: 'Turn Seller'
            ),
          ]
        ),
        Row(
          children: [
            AccountButton(
              onTap: (){}, 
              text: 'Log out'
            ),
            AccountButton(
              onTap: (){}, 
              text: 'Your wishlist'
            ),
          ]
        ),

      ],
    );
  }
}