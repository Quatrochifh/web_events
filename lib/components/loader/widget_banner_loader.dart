import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class BannerLoader extends StatelessWidget {
  const BannerLoader({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 220,
      margin: EdgeInsets.only(right: 15, left: 15),
      child: _buildImage()
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: 170,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: shimmerGradient,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox.shrink()
    );
  }
}