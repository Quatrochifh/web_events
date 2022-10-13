import 'package:appweb3603/components/post/widget_post_action.dart';
import 'package:appweb3603/components/post/widget_post_header.dart';
import 'package:appweb3603/components/post/widget_post_link.dart';
import 'package:appweb3603/components/post/widget_post_reactions.dart';
import 'package:appweb3603/components/widget_badge.dart'; 
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/entities/Post.dart' as post_entity;
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

import 'widget_post_content.dart';
 

class Post extends StatefulWidget{  
   
  /// Objeto do Post
  final post_entity.Post post; 

  /// Usuário atual
  final User currentUser;   

  /// Botão de curtir
  final Function? likeCallback;

  /// Botão ver post
  final Function? viewPostCallback;

  Post({Key? key, required this.likeCallback, required this.currentUser, required this.post, required this.viewPostCallback}) : super(key : key);

  @override
  PostState createState() => new PostState();
}


class PostState extends State<Post> with AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;
  String _postInfos = "";

  @override
  void initState(){
    super.initState();  

    _postInfos = "";

    if(widget.post.likes > 0) {
      _postInfos +=  '${widget.post.likes.toString()} pessoa${widget.post.likes > 1 ? 's' : ''} curti${widget.post.likes > 1 ? 'ram' : 'u'} isso.';
    }  
  }


  /*
    Callback para quando o botao de like for clicado.
  */
  void likeButtonCallback() { 
    if (widget.likeCallback != null) {
      widget.likeCallback!(widget.post.id).then((results) {  
        setState(() { 
          if (results == true) {
            widget.post.reacted = true;
            widget.post.likes++;
          } else {
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
  void viewPostButtonCallback(post_entity.Post post) {
    widget.viewPostCallback!(context, post );
  }

  @override
  Widget build(BuildContext context) {  
    super.build(context);

    return Container( 
      margin: EdgeInsets.only(top: 0 , bottom: 15, left: 10, right: 10 ), 
      constraints: BoxConstraints(minHeight: 30), 
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderMainRadius,
              border: Border.all(
                width: 0.5,
                color: Color.fromRGBO(0, 0, 0, 0.125)
              )
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [  
                /// Cabecalho do post
                PostHeader(user: widget.post.user, post: widget.post ), 

                /// Conteudo do post
                PostContent(post: widget.post),

                (widget.post.hasLink)
                  ?
                    PostLink(
                      post: widget.post
                    )
                  :
                    SizedBox.shrink(),

                (_postInfos.isNotEmpty)
                  ? 
                    PostReactions(
                      reactionsString: _postInfos
                    )
                  :
                    SizedBox.shrink(),
                /// Acoes do post
                PostAction(
                  likeButtonCallback: likeButtonCallback,
                  viewPostCallback: viewPostButtonCallback,
                  post: widget.post
                ),
              ]
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: (widget.post.fixed == true)
            ?
              Badge(
                width: 105,
                height: 21,
                padding: EdgeInsets.all(3),
                bgColor: greyBtnMoreBackground,
                borderRadius: 100,
                textColor: greyBtnMoreTextColor,
                fontWeight: FontWeight.bold,
                text: "Publicação Fixada",
                size: 9,
              )
            :
              SizedBox.shrink()
          )
        ]
      )
    );

  }
}