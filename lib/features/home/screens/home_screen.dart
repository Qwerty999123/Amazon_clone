import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/home/widgets/address_box.dart';
import 'package:amazon_app/features/home/widgets/carousel_image.dart';
import 'package:amazon_app/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_app/features/home/widgets/top_categories.dart';
import 'package:amazon_app/features/search/screens/search_screen.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            TopCategories(),
            CarouselImage(),
            DealOfTheDay(),
          ],
        ),
      )
      
    );
  }
}