import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/services/home_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/category';

  const CategoryScreen({
    super.key, 
    required this.category
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async{
    productList = await homeServices.getProducts(
      category: widget.category, 
      context: context
    );
    setState(() {});
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
          title: Text(
            '${widget.category}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        ),
      ),
      
      body: productList == null 
      ? Center(child: CircularProgressIndicator())
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
            child: Text(
              'Keep shopping for ${widget.category}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),  
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: productList!.length, 
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(
                      ProductDetails.routeName, 
                      arguments: productList![index]
                    );
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0, right: 8.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 0.5
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CarouselSlider(
                                items: productList![index].images.map(
                                  (i) {
                                    return Builder(
                                      builder: (context) {
                                        return Image.network(
                                          i,
                                          fit: BoxFit.fitHeight,
                                          height: 200
                                        );  
                                      },
                                    );
                                  }
                                ).toList(),
                              
                                options: CarouselOptions(
                                  viewportFraction: 1
                                ),
                              ),
                            ),
                          ),
                        ),
                          
                        Text(
                          productList![index].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                  
                        SizedBox(
                          height: 3
                        ),
                  
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            productList![index].description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ]
                          
                          
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
    
  }
}