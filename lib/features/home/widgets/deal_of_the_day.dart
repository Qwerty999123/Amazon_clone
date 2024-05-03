import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/loader.dart';
import 'package:amazon_app/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/services/home_services.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  List<String> listOfProductImages= [
    'https://plus.unsplash.com/premium_photo-1706625669518-664f071e02af?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1706625669518-664f071e02af?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1706625669518-664f071e02af?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1706625669518-664f071e02af?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D',
    
  ];

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async{
    product = await homeServices.dealOfTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null 
    ? Loader() 
    : product!.name.isEmpty 
      ? const SizedBox() 
      : GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(
            ProductDetails.routeName, 
            arguments: product
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Deal of the day',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 8.0),
                child: Image.network(
                  product!.images[0],
                  height: 250,
                  fit: BoxFit.fitHeight
                ),
              ),
              Text(
                '\$${product!.price.toString()}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              ),
              Text(
                product!.description,
                style: TextStyle(
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product!.images.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        product!.images[index],
                        fit: BoxFit.fitHeight
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0).copyWith(top: 16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'See all deals',
                    style: TextStyle(
                      color: GlobalVariables.selectedNavBarColor,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}