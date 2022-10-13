import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:flutter/material.dart';   

class PostContentInline extends StatefulWidget{
  final Post post;

  PostContentInline({Key? key, required this.post}) : super(key : key);

  @override
  PostContentInlineState createState() => PostContentInlineState();

}

class PostContentInlineState extends State<PostContentInline>{

  @override
  Widget build( BuildContext context ){
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(  
        minHeight: 30
      ),
      child: Row(  
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (widget.post.hasAttachment) ? 
            Container(
              margin: EdgeInsets.all(10),
              width: 120,
              alignment: Alignment.center, 
              decoration: BoxDecoration( 
                border: Border.all(
                  width: 0.5, 
                  color: Color.fromRGBO(0, 0, 0, 0.125)
                ),
                borderRadius: BorderRadius.circular(3), 
                color: Colors.black,
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomImage(
                image : widget.post.attachment,
                width: MediaQuery.of(context).size.width,
                height: 115,
                fit: BoxFit.scaleDown,
              )
            ) :
          SizedBox.shrink(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 20
              ),
              child: Wrap(
                children: [
                  Text( 
                    widget.post.content,
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.7,
                      color: Colors.black54
                    )
                  )
                ]
              ),
            ),
          ),
        ],
      )
    );
  }

}