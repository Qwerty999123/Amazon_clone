import 'package:amazon_app/common/widgets/bottom_bar.dart';
import 'package:amazon_app/features/admin/screens/add_product_screen.dart';
import 'package:amazon_app/features/home/screens/category_screen.dart';
import 'package:amazon_app/features/home/screens/home_screen.dart';
import 'package:amazon_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_app/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_app/features/search/screens/search_screen.dart';
import 'package:amazon_app/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen()
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen()
      );
    
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar()
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen()
      );

    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryScreen(category: category)
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery)
      );

    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(product: product,)
      );

    default: 
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page does not Exist')
        )
      )
    );
  }
}
