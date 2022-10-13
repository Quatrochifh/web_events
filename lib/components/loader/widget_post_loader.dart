import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PostLoader extends StatelessWidget {
  const PostLoader({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 220,
      margin: EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              Expanded(
                child: _buildText()
              )
            ],
          ),
          _buildImage()
        ]
      )
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: 130,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: shimmerGradient,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox.shrink()
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        gradient: shimmerGradient,
        borderRadius: BorderRadius.circular(100),
      ),
      child: SizedBox.shrink()
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 18,
          decoration: BoxDecoration(
            gradient: shimmerGradient,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 250,
          height: 9,
          decoration: BoxDecoration(
            color: Colors.black,
            gradient: shimmerGradient,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }
}