import 'package:appweb3603/components/post/widget_post_avatar.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostComment extends StatefulWidget{ 
 
  final User currentUser;

  final dynamic removeAction;

  final Post post;

  PostComment({Key? key, required this.currentUser, @required this.removeAction, required this.post}) : super(key : key);

  @override
  PostCommentState createState() => PostCommentState();

}

class PostCommentState extends State<PostComment>{ 
 
  @override
  Widget build( BuildContext context ){
    return Container(   
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        bottom: 15
      ),
      decoration: BoxDecoration(
        /*border: Border(
          top: BorderSide(
            color: bgWhiteBorderColor,
            width: 0.5
          ),
          bottom: BorderSide(
            color: bgWhiteBorderColor,
            width: 0.5
          )
        )*/
      ),
      child: Row( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostAvatar(user: widget.post.user, width: 45, height: 45),
          Expanded(
            flex: 5, 
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Row( 
                  children: [ 
                    Text( widget.post.user.name , style: GoogleFonts.lato( fontSize: 15 , fontWeight: FontWeight.bold ), overflow: TextOverflow.ellipsis),
                    Text( " comentou ", style: GoogleFonts.lato( fontSize: 13, color: Colors.grey  ), overflow: TextOverflow.ellipsis),
                  ],
                ),
                Text(
                 widget.post.publishedAt, 
                  style:  TextStyle( 
                    fontSize: 12, 
                    color: Color.fromRGBO(0, 0, 0, 0.45), 
                  )
                ),
                Container(   
                  width: double.infinity, 
                  margin: EdgeInsets.zero, 
                  child: Container(  
                    padding: EdgeInsets.all(5),  
                    child: 
                      Text( 
                        widget.post.content,
                        style: 
                          TextStyle( 
                            fontSize: 16, 
                            color: Colors.black, 
                          ), 
                        softWrap: true, 
                        textAlign: TextAlign.justify,
                      )
                  )
                ),
              ],
            )
          )
        ],
      ),
    );
  }

}