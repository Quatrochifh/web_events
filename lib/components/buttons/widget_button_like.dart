import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLike extends StatefulWidget{ 
 
  final Function callback; 
 
  final bool liked;

  final bool onlyIcon;

  final EdgeInsets? margin;

  ButtonLike({
    Key? key,
    this.margin,
    required this.liked,
    required this.callback,
    this.onlyIcon = false
  }) : super(key: key);

  @override
  ButtonLikeState createState() => ButtonLikeState();
}


class ButtonLikeState extends State<ButtonLike>{ 

  bool     _liked      =  false;

  /* 
    Clique do botao do curtir.
  */
  void _clickAction() {
    widget.callback();

    this._updateStatus();
  }

  @override
  void initState() { 
    super.initState();
    
    setState(() {   
      this._liked = widget.liked;
    });
  }

  void _updateStatus() {
    setState(() {
      _liked = !_liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onClick: _clickAction,
      title: _liked ? "Curtiu" : "Curtir",
      width: 110,
      height: 37,
      backgroundColor: postButtonBgColor,
      borderRadius: 5,
      fontSize: 15.6,
      iconSize: 18,
      iconMargin: noMargin,
      icon: _liked ? CupertinoIcons.heart_fill : Icons.favorite,
      iconColor: _liked ? likeBgColor : postButtonTextColor,
      textColor: _liked ? likeBgColor : postButtonTextColor
    );
  }
}