import 'package:appweb3603/components/widget_title_colored.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class SectionMain extends StatefulWidget {

  final String? title;

  final IconData? icon;

  final Widget child;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final BorderRadius? borderRadius;

  final double? height;

  final Color? background;

  final Color? borderColor;

  final bool? boxShadow;

  SectionMain({
    Key? key,
    this.boxShadow,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.background,
    this.margin,
    this.title,
    this.icon,
    required this.child,
    this.height}) : super(key: key);

  @override
  SectionMainState createState() => SectionMainState();
}


class SectionMainState extends State<SectionMain> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding ?? EdgeInsets.all(0),
      margin: widget.margin ?? EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: borderMainRadius,
        color: widget.background ?? Colors.transparent,
        border: Border.all(color: widget.borderColor ?? Colors.transparent, width: 0.5),
        boxShadow: widget.background != null && widget.boxShadow != false ? const [ligthShadow] : null
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (widget.title != null) ?
            TitleColored(
              title: widget.title!,
              fontSize: 16,
              color: Colors.grey,
              icon: widget.icon,
            )
          :
            SizedBox.shrink(),
          widget.child
        ],
      ),
    );
  
  }

}