import 'package:appweb3603/components/post/widget_post_avatar.dart';
import 'package:appweb3603/components/widget_badge.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
class PostHeader extends StatefulWidget{  

  final User user;

  final Post post;

  PostHeader({
      Key? key,
      required this.post,
      required this.user
    }) : super(key: key);

  @override
  PostHeaderState createState() => new PostHeaderState();
}


class PostHeaderState extends State<PostHeader>{ 


  @override
  Widget build(BuildContext context) { 
   
    return Container(
      padding: EdgeInsets.all(3.5),
      height: 63,  
      width: double.infinity,
      color: Colors.transparent,   
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          PostAvatar(
            user: widget.user,
            oficial: widget.post.oficial
          ),
          Expanded(
            flex: 5, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.user.name,
                      maxLines: 1,
                      style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.7
                      ),
                      overflow: TextOverflow.ellipsis
                    )
                  ],
                ),
                Container(
                  margin: noMargin,
                  child: Row(
                    children: [
                      (widget.post.oficial == true)
                      ?
                        Badge(
                          width: 70,
                          height: 21,
                          padding: EdgeInsets.all(3),
                          bgColor: primaryColor,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          text: "Organizador",
                          size: 9,
                        )
                      :
                        SizedBox.shrink(),
                      Text(
                        widget.post.publishedAt,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Color.fromRGBO(206, 206, 206, 1)
                        ),
                        overflow: TextOverflow.ellipsis
                      ),
                    ]
                  )
                ),
              ],
            )
          ), 
        ],
      )
    );

  }
}