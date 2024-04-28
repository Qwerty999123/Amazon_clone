import 'dart:convert';

import 'package:amazon_app/constants/error_handling.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices{

  Future<List<Product>> getProducts({
    required String category,
    required BuildContext context
  }) async {
    List<Product> productList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    try{  
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          for(int i=0; i<jsonDecode(res.body).length; i++){
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        }
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }

    return productList;

  }
}