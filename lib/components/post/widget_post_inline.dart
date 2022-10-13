import 'package:appweb3603/components/post/widget_post_action.dart';
import 'package:appweb3603/components/post/widget_post_content_inline.dart';
import 'package:appweb3603/components/post/widget_post_header.dart';
import 'package:appweb3603/components/post/widget_post_reactions.dart'; 
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/entities/Post.dart' as post_entity;
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PostInline extends StatefulWidget{  
   
  //Objeto do Post
  final post_entity.Post post;

  //Usuário atual
  final User currentUser;   

  //Botão de curtir
  final Function? likeCallback;

  //Botão ver post
  final Function? viewPostCallback;

  PostInline({Key? key, required this.likeCallback, required this.currentUser, required this.post, required this.viewPostCallback}) : super(key : key);

  @override
  PostInlineState createState() => new PostInlineState();
}


class PostInlineState extends State<PostInline> with AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true; 

  String _postInfos = "";

  @override
  void initState(){
    super.initState();  

    _postInfos = "";

    if( widget.post.likes > 0 ){
      _postInfos += '${widget.post.likes.toString()} curtiram isso';
    }  
  }


  /*
    Callback para quando o botao de like for clicado.
  */
  void likeButtonCallback() { 
    if( widget.likeCallback != null ){
      widget.likeCallback!( widget.post.id ).then( ( results ){  
        setState(() { 
          if( results == true ){
            widget.post.reacted = true;
            widget.post.likes++;
          }else{
            widget.post.reacted = false;
            widget.post.likes--;
          }
        });
      });
    } 
  }
  
  /*
    Callback para quando o botao de comentar for clicado, vamos levar para ao ver post
  */
  void viewPostButtonCallback( post_entity.Post post ){
    widget.viewPostCallback!(context, post);
  }

  @override
  Widget build( BuildContext context ){  
    super.build(context);

    return Container(
      width: 350,
      margin: EdgeInsets.only(top: 0, bottom: 15, left: 10, right: 10), 
      constraints: BoxConstraints(
        minHeight: 30
      ), 
      child: 
        Container( 
          margin: EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderMainRadius,
            border: Border.all(
              width: 0.5,
              color: Color.fromRGBO(0, 0, 0, 0.125)
            )
          ),
          child: Column( 
            children: [  
              //Cabecalho do post
              PostHeader(user: widget.post.user, post: widget.post), 
              //Conteudo do post
              Expanded(
                child: PostContentInline(
                  post: widget.post
                )
              ),
              (_postInfos.isNotEmpty) ? 
                  PostReactions(
                    reactionsString: _postInfos
                  )
                :
                  SizedBox.shrink()
              ,
              //Acoes do post
              PostAction(likeButtonCallback : likeButtonCallback, viewPostCallback : viewPostButtonCallback, post: widget.post), 
            ]  
          ),
        ), 
    );

  }
}