import 'dart:convert';

import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/components/post/widget_post_inline.dart';
import 'package:appweb3603/components/post/widget_post_comment.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/components/post/widget_post.dart' as post_widget;
import 'package:appweb3603/entities/User.dart'; 
import 'package:appweb3603/services/PostService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart'; 

class Feed {   

  PostService? _postService;   

  User? _currentUser;   

  Feed(){ 
    this._postService = Modular.get<PostService>();  
    this._currentUser = Modular.get<Controller>().currentUser;
  }   

  /*
    Publicar um POST
  */
  Future<dynamic> publishPost(String content, String feedPhoto) {
    Post poste = new Post();
    poste.content = content;  
    poste.attachment = feedPhoto;

    if(feedPhoto.isNotEmpty) {
      poste.hasAttachment = true;
    }

    return this._postService!.publishPost(poste).then((results) {
      if(results!= false && results > 0){ 
        poste.attachment = Base64Decoder().convert(feedPhoto);
        poste.publishedAt = 'Agora mesmo';
        poste.user = _currentUser!;
        poste.id   = results;  

        post_widget.Post postWidget = post_widget.Post(
          key: new GlobalKey(),
          post: poste, 
          currentUser: _currentUser!, 
          likeCallback: likePost, 
          viewPostCallback: Navigation.viewPost
        );
        return postWidget;
      }
      return false;
    });  
  }

  /*
    Pegar alguns POSTS
  */
  Future<dynamic> fetchPosts({int page = 1, bool inline = false, bool fixed = false}){
    List<Widget> postsWidget = [];
    if( page < 1 ){
      page = 1;
    }
    return this._postService!.fetchPostsByEvent(page: page, fixed: fixed).then((posts) { 
        
      if( posts != null ){
        for(Post post in posts){
          dynamic postWidget;
          if (inline == true) {
            postWidget =  PostInline(
              key: new GlobalKey(),
              post: post, 
              currentUser: _currentUser!, 
              likeCallback: likePost, 
              viewPostCallback: Navigation.viewPost
            );
          } else {
            postWidget = post_widget.Post(
              key: new GlobalKey(),
              post: post, 
              currentUser: _currentUser!, 
              likeCallback: likePost, 
              viewPostCallback: Navigation.viewPost
            );
          }

          postsWidget.add(postWidget); 
        }   
      }  

      return postsWidget.isNotEmpty ? postsWidget : [];
    }); 
  }

  /*
    Curtir post 
    @Param (int) postId
  */
  Future<bool> likePost(int postId) {  
    /*
      Chamamos o serviço para solicitar o curtir do post.
    */ 
    return _postService!.likePost(postId).then((results) {   
      if(results == true) {
        return true;
      }else{
        return false;
      }
    });
  }


  /*
    Buscar replies para a publicação
    @Param  (int) postId : ID do post 
    @Param  (int) page    : Número da página
  */
  Future<dynamic> fetchReplies(int page, int postId) {   
    return this._postService!.fetchPostsByEvent(page: page, parentId: postId).then((results) {
      if(results == null || results.length < 1) {  
        return null;
      }   

      List<PostComment> replies = <PostComment>[];

      for(Post poste in results) {   
        replies.add( PostComment(removeAction: (){ }, key: new GlobalKey(), currentUser: _currentUser!, post: poste ) );
      }  

      return replies;
    });  
  }  

  /*
    Publicar uma resposta
    @Param (String) content     : Conteúdo do reply
    @Param (int) postId         : ID do post
    @Param  (userE) currentUser : ID do post 
  */
  Future<dynamic> publishReply(String content, int postId) {  

    Post poste = new Post(); 

    poste.content  = content; 
    poste.parentId = postId;   
      
    return this._postService!.replyPost( poste ).then( ( results )   { 
      if( results!= false && results > 0 ){  
        
        poste.publishedAt = 'Agora mesmo';
        poste.user = _currentUser!;
        poste.id   = results;  

        return PostComment(
          removeAction: (){ },
          key: new GlobalKey(),
          currentUser: _currentUser!,
          post: poste
        );
      }
      return null;
    });  
  }
  
}