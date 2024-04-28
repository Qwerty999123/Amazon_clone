import 'package:amazon_app/models/user.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatefulWidget {
  const AddressBox({super.key});

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Container(
      padding: EdgeInsets.only(left: 12.0),
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233)
          ]
        )
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Deliver to ${user.name} - ${user.address}',
              style: TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.arrow_drop_down
            ),
          ),
        ],
      )
    );
  }
}