import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class ListItemPersonAvatarNameLoader extends StatelessWidget {
  const ListItemPersonAvatarNameLoader({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.only(
        right: 15,
        left: 15,
        top: 10
      ),
      child: Row(
        children:[ 
          _buildAvatar(),
          Expanded(
            child: _buildText()
          )
        ]
      )
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

  Widget _buildAvatar() {
    return Container(
      width:  55,
      height: 55,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: shimmerGradient,
        borderRadius: BorderRadius.circular(100),
      ),
      child: SizedBox.shrink()
    );
  }}