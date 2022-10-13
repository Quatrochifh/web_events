import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class ButtonChiclete extends StatefulWidget{ 
 
  final Function onClick; 

  final IconData? icon;

  final double? size; 

  final Color? iconColor; 

  final Color? bgColor;  

  ButtonChiclete({Key? key, this.icon, this.iconColor, this.bgColor, this.size, required this.onClick}) : super(key: key);

  @override
  ButtonChicleteState createState() => ButtonChicleteState();
}


class ButtonChicleteState extends State<ButtonChiclete>{

  @override
  void initState() { 
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) { 
    return PrimaryButton(
      onClick: widget.onClick,  
      width: 35, 
      height: 35, 
      icon: widget.icon,  
      borderRadius: 100,
      fontSize: widget.size ?? 22,
      iconSize: widget.size ?? 22,
      onlyIcon: true,
      padding: noPadding,
      textColor: widget.iconColor ?? Color.fromRGBO(255, 255, 255, 0.45),
      backgroundColor: widget.bgColor ?? Colors.transparent
    );

  }
}