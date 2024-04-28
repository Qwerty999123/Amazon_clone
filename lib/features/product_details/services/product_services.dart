import 'dart:convert';

import 'package:amazon_app/constants/error_handling.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductServices{
  void rateProduct({
    required Product product,
    required BuildContext context,
    required double rating
  }) async{
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    try{
      http.Response res = await http.post(
        Uri.parse('$uri/api/product-rating'),
        headers: <String, String> {
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating
        })
      );

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){}
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}