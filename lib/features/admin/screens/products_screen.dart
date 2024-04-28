import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/loader.dart';
import 'package:amazon_app/features/admin/screens/add_product_screen.dart';
import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:amazon_app/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  AdminServices adminServices = AdminServices();
  List<Product>? products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async{
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
      context: context, 
      product: product, 
      onSuccess: (){
        products!.removeAt(index);
        setState(() {});
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return products == null 
    ? Loader() 
    : Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddProductScreen.routeName);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        tooltip: 'Add a product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 5,
            childAspectRatio: 1
          ),
          itemCount: products!.length, 
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 129,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Colors.black38,
                        
                      )
                    ),
                    child: CarouselSlider(
                      items: products![index].images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network(
                                i,
                                fit: BoxFit.fitHeight,
                              );
                            },
                          );
                        }
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                      ),
                    )
                    
                    // Image.asset(
                    //   GlobalVariables.categoryImages[index]['image']!,
                    //   fit: BoxFit.fitHeight,
                    // ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      Expanded(
                        child: Text(
                          products![index].description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteProduct(products![index], index);
                        }, 
                        icon: Icon(Icons.delete_outline)
                      )
                    ],
                  )
                ],
              ),
            );
          }
        ),
      )
    );
  }
}