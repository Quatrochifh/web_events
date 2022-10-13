import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class TitleH3 extends StatelessWidget {

  final String title;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final double? fontSize;
  final Color? fontColor;
  final EdgeInsets? margin;
  final int? maxLines;
  final FontWeight? fontWeight;

  const TitleH3({
    Key? key,
    required this.title,
    this.padding,
    this.alignment,
    this.fontSize,
    this.fontColor,
    this.margin,
    this.maxLines,
    this.fontWeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.centerLeft,
      padding: padding,
      margin: margin ?? EdgeInsets.only(
        bottom: 15
      ),
      child: Text(
        title,
        maxLines: maxLines,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: fontColor ?? Colors.black,
          fontSize: fontSize ?? 15.6,
          fontWeight: fontWeight ?? FontWeight.bold,
          letterSpacing: primaryLetterSpacing
        ),
      )
    );
  }
}