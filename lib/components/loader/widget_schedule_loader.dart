import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class ScheduleLoader extends StatelessWidget {
  const ScheduleLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderMainRadius
      ),
      height: 167,
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
          height: 167,
          decoration: BoxDecoration(
            gradient: shimmerGradient
          ),
        ),
      ],
    );
  }
}