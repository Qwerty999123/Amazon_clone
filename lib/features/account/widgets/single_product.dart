import 'package:flutter/material.dart';

class SingleProduct extends StatefulWidget {
  final String image;

  const SingleProduct({
    super.key,
    required this.image,
  });

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(212, 212, 212, 1),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Container(
          width: 210,
          padding: const EdgeInsets.all(8),
          child: Image.network(
            widget.image,
            fit: BoxFit.fitHeight,
            width: 210,
          )
        ),
      ),

    );
  }
}