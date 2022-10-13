import 'dart:convert';

import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Bloc.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/services/PostService.dart';
import 'package:appweb3603/entities/Event.dart' as event_entity;
import 'package:appweb3603/entities/Post.dart' as post_entity;

class Post extends Bloc {

  Post() : super();

  /*
    * Publicar um POST
  */
  Future<dynamic> publishPost(String content, String feedPhoto, {String reference = "feed", int referenceId = 0}) {
    post_entity.Post poste = new post_entity.Post();
    poste.content = content;  
    poste.reference = reference;
    poste.referenceId = referenceId;
    poste.attachment = feedPhoto;

    if(feedPhoto.isNotEmpty) {
      poste.hasAttachment = true;
    }

    return (globalDIContainer.get(PostService) as PostService).publishPost(poste).then((results) {
      if(results!= false && results > 0){ 
        poste.attachment = Base64Decoder().convert(feedPhoto);
        poste.publishedAt = 'Agora mesmo';
        poste.user = globalDIContainer.get(User) as User;
        poste.id   = results;

        return poste;
      }
      return false;
    });  
  }
  
  /*
   * Pegar a lista de de quem reagiu a publicação
  */
  Future<dynamic> fetchReactionsByPostId(int postId, {int limit = -1, int offset = 0}){
    event_entity.Event event  = globalDIContainer.get(event_entity.Event) as event_entity.Event;
    return diContainer.get(PostService).fetchReactionsByPostId(postId, eventId: event.id, limit: limit, offset: offset).then((results){ 
      if(results.runtimeType.toString() != 'List<String>'){
        return [];
      }
      return results;
    });
  }

  /*
   * Pegar a lista de quem reagiu a publicação
  */
  Future<dynamic> fetchPostById(int postId){
    event_entity.Event event  = globalDIContainer.get(event_entity.Event) as event_entity.Event;
    return diContainer.get(PostService).fetchPostById(postId, eventId: event.id).then((post){ 
      if(post == null){
        return null;
      }
      return post;
    });
  }

  /*
   * Pegar a lista de publicações
  */
  Future<dynamic> fetchPosts({String reference = "feed",  int referenceId = 0, int page = 1}){
    return diContainer.get(PostService).fetchPostsByEvent(reference: reference, page: page, referenceId: referenceId).then((posts){ 
      if(posts == null){
        return [];
      }
      return posts;
    });
  }

  /*
   * Pegar a lista de publicações
  */
  Future<dynamic> fetchFixedPosts({String reference = "feed", int referenceId = 0, int page = 1}){
    return diContainer.get(PostService).fetchPostsByEvent(
      reference: reference,
      page: page,
      fixed: true,
      referenceId: referenceId
    ).then((posts){ 
      if(posts == null){
        return [];
      }
      return posts;
    });
  }
}