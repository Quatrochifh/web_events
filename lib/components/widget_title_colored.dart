import 'package:flutter/material.dart';

class TitleColored extends StatelessWidget{

  final String title;

  final IconData? icon;

  final Color? color;

  final double? fontSize;

  TitleColored ({Key? key, this.color, this.fontSize, required this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      decoration: BoxDecoration(
        //color: primaryColorLigther,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (icon != null)
            ?
              Container(
                margin: EdgeInsets.only(right: 7.5),
                child: Icon(icon, size: fontSize ?? 20, color: color ?? Colors.black)
              )
            :
              SizedBox.shrink(),
          Text(
            title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize != null ? (fontSize! * 0.8) : 14.6,
              color: color ?? Colors.black,
              overflow: TextOverflow.ellipsis
            )
          )
        ]
      )
    );
  }
}