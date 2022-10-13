import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class TransmissionLoader extends StatelessWidget {
  const TransmissionLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: borderMainRadius
      ),
      height: 170,
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
          height: 170,
          decoration: BoxDecoration(
            gradient: shimmerGradient
          ),
        ),
      ],
    );
  }
}