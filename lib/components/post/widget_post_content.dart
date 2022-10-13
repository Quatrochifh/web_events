import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:flutter/material.dart';   

class PostContent extends StatefulWidget{
  final Post post;

  PostContent({Key? key, required this.post}) : super(key : key);

  @override
  PostContentState createState() => PostContentState();

}

class PostContentState extends State<PostContent>{

  @override
  Widget build( BuildContext context ){
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(  
        minHeight: 65
      ),
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
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
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.7,
                    color: Colors.black54
                  )
                )
              ]
            ),
          ),
          (widget.post.hasAttachment) ? 
          Container(
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
              height: 300,
              fit: BoxFit.scaleDown,
            )
          ) : SizedBox.shrink(),
        
        ],
      )
    );
  }

}