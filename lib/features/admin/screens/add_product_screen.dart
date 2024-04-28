import 'dart:io';

import 'package:amazon_app/common/widgets/custom_button.dart';
import 'package:amazon_app/common/widgets/custom_textfield.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/utils.dart';
import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  List<String> productCategoryItems = GlobalVariables.categoryImages.map((i) => i['title']!).toList();
  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  void sellProduct() async{
    if(_addProductFormKey.currentState!.validate() && images.isNotEmpty){
    
      setState(() {
        isLoading = true;
      });
    
      adminServices.sellProduct(
        context: context, 
        name: productNameController.text, 
        description: descriptionController.text, 
        price: double.parse(priceController.text), 
        quantity: int.parse(quantityController.text), 
        category: category, 
        images: images
      );
      
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectImages() async{
    var res = await pickImages();
    if(res.isNotEmpty){
      setState(() {
      images = res;
    });
    }
    
  }

  @override
  void dispose(){
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Text('Add product'),
          centerTitle: true,
          
        ),
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: selectImages,
                  child: images.isNotEmpty 
                  ? CarouselSlider(
                      items: images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              );
                            },
                          );
                        }
                      ).toList(), 
                      options: CarouselOptions(
                        viewportFraction: 1,
                      )
                    )
                  : DottedBorder(
                    borderType: BorderType.RRect,
                    borderPadding: EdgeInsets.all(12.0),
                    dashPattern: [15, 8],
                    strokeWidth: 1.5,
                    radius: Radius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Icon(Icons.folder_open_rounded, size: 50),
                          const SizedBox(height: 10,),
                          Text(
                            'Select product images',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54
                            ),
                          )
                        ] 
                      ),
                    )
                  ),
                ),
                const SizedBox(
                  height: 30
                ),
                CustomTextField(
                  controller: productNameController, 
                  hint: 'Product Name'
                ),
                const SizedBox(
                  height: 7
                ),
                CustomTextField(
                  controller: descriptionController, 
                  hint: 'Description',
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 7
                ),
                CustomTextField(
                  controller: priceController, 
                  hint: 'Price'
                ),
                const SizedBox(
                  height: 7
                ),
                CustomTextField(
                  controller: quantityController, 
                  hint: 'Quantity'
                ),
                const SizedBox(
                  height: 7
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton(
                      iconSize: 30,
                      value: category,
                      items: productCategoryItems.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16
                            )
                          )
                        )
                      ).toList(), 
                      onChanged: (String? newVal){
                        setState(() {
                          category = newVal!;
                        });
                      }
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7
                ),
                CustomButton(
                  text: 'Submit', 
                  onTap: sellProduct,
                  isLoading: isLoading,
                  
                ),
                
              ],
            ),
          )
        )
      )

    );
  }
}