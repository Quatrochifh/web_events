import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PostComments extends StatefulWidget{ 

  final User user;

  final List? comments;

  PostComments({Key? key, required this.user, required this.comments}) : super(key: key);

  @override
  PostCommentsState createState() => PostCommentsState();

}

class PostCommentsState extends State<PostComments>{

  @override
  Widget build( BuildContext context ){
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 5,
        right: 5
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderMainRadius,
        boxShadow: const [ligthShadow]
      ),  
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 0
      ), 
      child: Column(  
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              
            ),
            margin: EdgeInsets.only(
              bottom: 20
            ),
            child: Text(
              "Comentários",
              style: TextStyle(
                fontSize: 22.4,
                letterSpacing: -0.5,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          (widget.comments != null && widget.comments!.isEmpty)
            ?
              Message(
                textAlign: TextAlign.center, 
                iconColor: grey165Color,
                margin: EdgeInsets.all(10),
                bgColor:  Colors.transparent,
                text: globalMessages['FIRST_COMMENT'],
                textColor: grey165Color,
                fontSize: 16,
              )
            :
              (widget.comments == null) 
                ? 
                  LoadingBlock(transparent: true)
                :
                  SizedBox.shrink(),
        ] + List<Widget>.from(widget.comments ?? []),
      )
    );
  }

}