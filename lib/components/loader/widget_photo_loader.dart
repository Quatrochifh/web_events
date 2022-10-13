import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PhotoLoader extends StatelessWidget {
  const PhotoLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderMainRadius
      ),
      width: 130,
      height: 130,
      child: Column(
        children:[
         _body()
        ]
      )
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            gradient: shimmerGradient
          ),
        ),
      ],
    );
  }
}