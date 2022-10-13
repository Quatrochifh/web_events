import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget{ 

  final List<Widget> children;

  final Function onClick; 

  final double? height;

  final EdgeInsets? padding;

  final bool? shadow;

  ListItem({Key? key, this.shadow, this.padding, this.height, required this.onClick, required this.children}) : super(key : key);
  

  @override
  Widget build( BuildContext context ){ 
    return InkWell(
      onTap:(){ onClick(); },
      child: Container( 
        width: double.infinity, 
        height: height, 
        margin: EdgeInsets.all(3.5),
        padding: padding ?? EdgeInsets.all(5),
        decoration: BoxDecoration( 
          color: Colors.white, 
          border: Border.all(
            width: 0.4,
            color: Colors.black.withOpacity(0.125)
          ),
          borderRadius:borderMainRadius,
          boxShadow: shadow == true ? const [ darkShadow ] : null
        ), 
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        )
      ),
    );
  }

}