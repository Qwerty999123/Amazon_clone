import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/home/screens/category_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/category', arguments: GlobalVariables.categoryImages[index]['title']);
                  }, 
                  icon: Image.asset(
                    '${GlobalVariables.categoryImages[index]['image']}',
                    height: 50,
                    //color: GlobalVariables.backgroundColor
                  ),
                ),
                Text(
                  '${GlobalVariables.categoryImages[index]['title']}'
                ),
              ],
            ),
          );
        }
      )
    );
  }
}