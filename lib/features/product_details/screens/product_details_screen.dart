import 'package:amazon_app/common/widgets/custom_button.dart';
import 'package:amazon_app/common/widgets/stars.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/product_details/services/product_services.dart';
import 'package:amazon_app/features/search/screens/search_screen.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  static const String routeName = '/product-details';
  
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductServices productServices = ProductServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for(int i=0; i<widget.product.rating!.length; i++){
      totalRating += widget.product.rating![i].rating;
      if(widget.product.rating![i].userId == Provider.of<UserProvider>(context, listen: false).user.id){
        myRating = widget.product.rating![i].rating;
      }
    }

    if(totalRating != 0){
      avgRating = totalRating/widget.product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 8.0),
            height: 45  ,
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
              ),
              child: TextField(
                onSubmitted: (query){
                  Navigator.of(context).pushNamed(
                    SearchScreen.routeName, 
                    arguments: query
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search Amazon.in',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: (){
                      print('iyvr');
                    },
                    icon: Icon(Icons.mic, color: Colors.grey[600]),
                  ),
                  fillColor: GlobalVariables.backgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(color: Colors.black38, width :1.0)
                  ),
                  contentPadding: const EdgeInsets.only(top: 8.0),
                ),
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.qr_code_scanner_rounded),
              ),
            ),
            
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      widget.product.id!,
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                        fontSize: 16
                      )
                    ),
                    Flexible(child: Container()),
                    Text(
                      avgRating.toString(),
                      style: TextStyle(
                        fontSize: 16
                      )
                    ),
                    RatingStars(rating: avgRating, size: 18),
                    
                  ],
                ),
              ),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 17
                )
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0),
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: widget.product.images.map(
                    (i) {
                      return Builder(
                        builder: (context){
                          return Image.network(
                            i,
                            fit: BoxFit.fitWidth
                          );
                        }
                      );
                    }
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 300
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black12,
                  thickness: 4,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Deal Price:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    TextSpan(
                      text: ' \$${widget.product.price}',
                      style: TextStyle(
                        color: Colors.red[600],
                        fontSize: 22,
                        fontWeight: FontWeight.w700
                      )
                    )
                  ]
                )
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 17
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black12,
                  thickness: 4,
                ),
              ),

              CustomButton(
                text: 'Add To Cart', 
                onTap: (){},
                fontColor: Colors.black,
                color: Colors.yellow[600]!,
                borderRadius: 50,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                text: 'Buy Now', 
                onTap: (){},
                borderRadius: 50,
                fontColor: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black12,
                  thickness: 4,
                ),
              ),
              Text(
                'Rate the Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              ),
              RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                
                itemBuilder: (context, _){
                  return Icon(
                    Icons.star, 
                    color: GlobalVariables.secondaryColor,
                  );
                }, 
                onRatingUpdate: (rating) {
                  productServices.rateProduct(
                    product: widget.product, 
                    context: context, 
                    rating: rating
                  );
                }
              )
            ],
          ),
        ),
      )
    );
  }
}