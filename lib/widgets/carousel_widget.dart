import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class MyCaro extends StatefulWidget {
  @override
  _MyCaroState createState() => _MyCaroState();
}

class _MyCaroState extends State<MyCaro> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Carousel(
        indicatorBgPadding: 5,
        dotPosition: DotPosition.topRight,
        dotBgColor: Colors.transparent,
        images: [
          Image.asset(
            "images/one.png",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/second.png",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "images/third.png",
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
