import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class DocumentLoader extends StatelessWidget {
  const DocumentLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: borderMainRadius
      ),
      height: 120,
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
          height: 120,
          decoration: BoxDecoration(
            gradient: shimmerGradient
          ),
        ),
      ],
    );
  }
}