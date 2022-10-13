import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart'; 
import 'package:flutter/cupertino.dart';

class ButtonViewPost extends StatefulWidget {
 
  final Function callback;

  final int countReplies;

  ButtonViewPost({
    Key? key,
    required this.callback,
    required this.countReplies
  }) : super(key: key);

  @override
  ButtonViewPostState createState() => new ButtonViewPostState();
}


class ButtonViewPostState extends State<ButtonViewPost>{  

  String replies = "";
  
  void _clickAction(context){
    setState(() {   
      widget.callback(context);   
    });
  }

  @override 
  void initState(){
    super.initState();
    replies = shortNumber(widget.countReplies.toDouble());
  }

  @override
  Widget build(BuildContext context) {

    return PrimaryButton(
      onClick: () => _clickAction(context),
      title: "$replies Comentários",
      width: 160,
      height: 37,
      backgroundColor: postButtonBgColor,
      borderRadius: 5,
      iconSize: 18,
      fontSize: 15.6,
      iconMargin: noMargin,
      icon: CupertinoIcons.chat_bubble_2,
      iconColor: postButtonTextColor,
      textColor: postButtonTextColor
    );
  }
}