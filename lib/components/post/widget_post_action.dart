import 'package:appweb3603/components/buttons/widget_button_like.dart'; 
import 'package:appweb3603/components/buttons/widget_button_view_post.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/style.dart'; 
 
import 'package:flutter/material.dart';  

class PostAction extends StatefulWidget{  

  final Function viewPostCallback;

  final Function likeButtonCallback;

  final Post post;

  PostAction({Key? key, required this.post, required this.likeButtonCallback, required this.viewPostCallback}) : super( key : key );

  @override
  PostActionState createState() => new PostActionState();
}


class PostActionState extends State<PostAction>{  

  //Callback após clicar no botão comentário
  void _afterComment(context){
    /*
      Clicou no botão de comentar, vamos exibir o formulário de comentário!
    */ 
    widget.viewPostCallback( widget.post );
  } 
  
  //Callback após clicar no botão curtir
  void afterLike() {    
    widget.likeButtonCallback();
  }  

  @override
  void initState() { 
    super.initState(); 
  }

  @override
  Widget build( BuildContext context ){  
    
    return Container(
      margin: EdgeInsets.all(0),
      padding: const EdgeInsets.only(
        left: 5,
        right: 5
      ),
      decoration: BoxDecoration(
        color: postButtonBgColor
      ),
      child: Row( 
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [ 
          ButtonLike( 
            key: new GlobalKey(), 
            liked: widget.post.reacted, 
            callback : afterLike 
          ),
          ButtonViewPost( 
            key: new GlobalKey(), 
            countReplies : widget.post.replies, 
            callback: _afterComment
          ) 
        ]
      )
    );

  }
}