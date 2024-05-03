import 'dart:convert';
import 'dart:io';
import 'package:amazon_app/constants/error_handling.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices{
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    List<String> imageUrl = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('', ''); // Enter your own cloudinary info

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrl.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        images: imageUrl,
        category: category,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String> {
          'Content-type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token
        },

        body: product.toJson()
      );

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          showSnackBar(context, 'Product Added Successfully');
          Navigator.of(context).pop();
        }
      );


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> products = [];
    try{
      http.Response res = await http.get(Uri.parse('$uri/admin/get-products'), headers: <String, String> {
        'Content-type' : 'application/json; charset=UTF-8',
        'x-auth-token' : userProvider.user.token,
      });
      
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          for(int i=0; i<jsonDecode(res.body).length; i++){
            products.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i]
                )
              )
            );
          }
        }
      );

    }catch(e){
      showSnackBar(context, e.toString());
    }

    return products;  

  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try{
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-type' : 'application/json; charset=UTF-8',
          'x-auth-token' : userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id
        }),

      );

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: () {
          onSuccess();
        }
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}

