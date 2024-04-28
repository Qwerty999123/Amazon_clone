import 'package:amazon_app/common/widgets/stars.dart';
import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/constants/loader.dart';
import 'package:amazon_app/features/home/widgets/address_box.dart';
import 'package:amazon_app/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_app/features/search/services/search_services.dart';
import 'package:amazon_app/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  static const String routeName = '/Search';

  const SearchScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchServices searchServices = SearchServices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async{
    products = await searchServices.fetchsearchedProducts(
      searchQuery: widget.searchQuery, 
      context: context
    );
    setState(() {});
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

      body: products == null 
      ? const Loader()
      : Column(
        children: [
          AddressBox(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: products!.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(
                      ProductDetails.routeName, 
                      arguments: products![index]
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 135,
                          width: MediaQuery.of(context).size.width/2.3,
                          child: CarouselSlider(
                            items: products![index].images.map(
                              (i) {
                                return Builder(
                                  builder: (context){
                                    return Image.network(
                                      i,
                                      fit: BoxFit.fitWidth,
                                    );
                                  },
                                );
                              }
                            ).toList(), 
                            options: CarouselOptions(
                              viewportFraction: 1
                            )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products![index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                                  child: RatingStars(rating: 3,),
                                ),
                                Text(
                                  '\$${products![index].price.toString()}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                Text(
                                  'Eligible for free delivery'
                                ),
                                products![index].quantity != 0 
                                ? Text(
                                  'In stock',
                                  style: TextStyle(
                                    color: GlobalVariables.selectedNavBarColor
                                  )
                                )
                                : Text(
                                  'Out of stock',
                                  style: TextStyle(
                                    color: Colors.red
                                  )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}