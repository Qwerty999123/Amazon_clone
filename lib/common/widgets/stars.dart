import 'package:amazon_app/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 15,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      rating: rating,
      itemCount: 5,
      itemSize: size,
      itemBuilder: (context, _) => Icon(Icons.star, color: GlobalVariables.secondaryColor,)
    );
  }
}