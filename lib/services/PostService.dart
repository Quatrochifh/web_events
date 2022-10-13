 
import 'package:appweb3603/core/ServiceConnect.dart'; 
import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/entities/User.dart';

import 'Service.dart';
import 'UserService.dart'; 

class PostService extends Service { 

  postService(){ }

  /*
    @Param (object) Post : Entidade do post
    @Return (Future)
  */
  Future publishPost(Post post) async {

    String? currentAuthToken;
    int? currentEventId;
    
    // Checa antes se o usuário está logado
    bool continueToPublish = await UserService.getCurrentUserToken()!.then((authToken) {
      currentAuthToken = authToken;
      if(currentAuthToken != null){
        //Está logado!    
        return true;
      }else{ 
        return false;
      }
    }); 
     
    if(continueToPublish){ 

      bool continueToPublish = await UserService.getCurrentUserEventId()!.then((eventId) {
        currentEventId = eventId;
        if(eventId != null){
          return true;
        }else{ 
          return false;
        }
      }); 

      if(!continueToPublish) {
        return false;
      }

      Map<String, dynamic> postParams = <String, dynamic>{ }; 

      //Vamos setar o token da sessão do usuário.
      postParams['authToken'] = currentAuthToken;

      //Vamos setar o id do evento
      postParams['event_id']   = currentEventId.toString();
      
      //Descriçao do post
      postParams['content'] = post.content;

      //Anexo do post
      postParams['attachment'] = post.attachment;

      //Componente que receberá o post
      postParams['reference'] = post.reference;

      //ID do Componente que receberá o post
      postParams['referenceId'] = post.referenceId.toString();
      
      // A data da publicaçao, assim com o ID do usuário, serão setados no servidor após validações!
      return await serviceConnect('post/publish', 'POST', postParams).then((results) { 
        if(results == null) { 
          return false;
        }
        if(results['status'] as int == 1) {   
          return int.parse(results['message']);
        }
        return false; 
      });

    }
 
  }

  /*
    @Param (object) Post : Entidade do post
  */
  Future replyPost(Post post) async {

    String? currentAuthToken;
    int? currentEventId;

    /*
      Vamos verificar se o usuário está logado.
    */
    bool continueToPublish = await UserService.getCurrentUserToken()!.then((authToken) {
      currentAuthToken = authToken;
      if(currentAuthToken != null) {
        //Está logado!    
        return true;
      }else{ 
        return false;
      }
    }); 
     
    if(continueToPublish) { 

      bool continueToPublish = await UserService.getCurrentUserEventId()!.then((eventId) {
        currentEventId = eventId;
        if(eventId != null) {
          //Está logado!   
          return true;
        }else{ 
          return false;
        }
      }); 

      if(!continueToPublish) {
        return false;
      }

      Map<String, dynamic> postParams = <String, dynamic>{}; 

      //Vamos setar o token da sessão do usuário.
      postParams['authToken'] = currentAuthToken;

      //Vamos setar o id do evento
      postParams['event_id']   = currentEventId.toString();
      
      //Descriçao do post
      postParams['content'] = post.content;

      //ID do post pai.
      postParams['parent_id'] = post.parentId.toString();
      
      /*
        A data da publicaçao, assim com o ID do usuário, serão setados no servidor após validações!
      */
      return await serviceConnect('post/reply/', 'POST', postParams ).then((results) { 

        if(results == null) { 
          return false;
        }  

        if(results['status'] as int == 1) {   
          return int.parse(results['message']);
        }

        return false; 
      });

    }
 
  }


  /*
    @Param (int) postId : ID da publicacao
    @Return (Future)
  */
  Future likePost(int postId ) async {

    String? currentAuthToken;
    int? currentEventId;

    /*
      Vamos verificar se o usuário está logado.
    */
    bool continueToReaction = await UserService.getCurrentUserToken()!.then((authToken) {
      currentAuthToken = authToken;
      if(currentAuthToken != null) {
        //Está logado!    
        return true;
      }else{ 
        return false;
      }
    }); 
     
    if(continueToReaction) { 

      bool continueToPublish = await UserService.getCurrentUserEventId()!.then((eventId) {
        currentEventId = eventId;
        if(eventId != null) {
          //Está logado!   
          return true;
        }else{ 
          return false;
        }
      }); 

      if(!continueToPublish) {
        return false;
      }


      Map<String, dynamic> postParams = <String, dynamic>{ }; 

      //Vamos setar o token da sessão do usuário.
      postParams['authToken'] = currentAuthToken;

      //Vamos setar o id do evento
      postParams['event_id']   = currentEventId.toString();
      
      //Descriçao do post
      postParams['post_id'] = postId.toString();
      
      /*
        A data da publicaçao, assim com o ID do usuário, serão setados no servidor após validações!
      */
      return await serviceConnect('post/like/', 'POST', postParams ).then((results) { 

        if(results == null) { 
          return false;
        }  

        if(results['status'] as int == 1){ 
          // 1 = Like, -1 = Deslike
          return results['message'];
        }

        return false; 
      });

    }
 
  } 


  /*
    @Param (int) page 
    @Param (Future: parentId) parentId : ID do post pai
  */
  Future fetchPostsByEvent({int page = 1, int parentId = 0, String reference = "feed", int referenceId = 0, bool fixed = false}) async {

    String? currentAuthToken;
    int? currentEventId;

    /*
      Vamos verificar se o usuário está logado.
    */
    bool continueToFetch = await UserService.getCurrentUserToken()!.then((authToken) {
      currentAuthToken = authToken;
      if(currentAuthToken != null) { 
        return true;
      }else{ 
        return false;
      }
    });

    if(continueToFetch != true) {
      return null;
    }

    /*
      Vamos verificar se o usuário está logado.
    */
    continueToFetch = await UserService.getCurrentUserEventId()!.then((eventId) {
      currentEventId = eventId;
      if(currentEventId != null) { 
        return true;
      }else{ 
        return false;
      }
    });  
     
    if(continueToFetch) { 

      Map<String, String> params = <String, String>{};

      // Vamos setar o TOKEN da sessão do usuário.
      params['authToken'] = currentAuthToken.toString();

      // Vamos setar o ID do evento
      params['event_id']   = currentEventId.toString();

      // Componente que receberá o comentário
      params['reference']   = reference; 

      // ID do componente que receberá o comentário
      params['referenceId']   = referenceId.toString(); 

      // Post/Comentário Fixado ?
      params['fixed']   = (fixed == true ? 1 : 0).toString(); 

      String url = 'post/';

      if(parentId != 0) {
        url += 'replies/';

        //Seta o ID do post pai
        params['parent_id']   = parentId.toString();  
      }else{
        url += 'fetch/';
      }

      if(page > 1) {
        url+= 'page/${page.toString()}';
      } 
      
      /*
        A data da publicaçao, assim com o ID do usuário, serão setados no servidor após validações!
      */
      return await serviceConnect(url, 'GET', params).then((results) { 

        if(results == null) { 
          return null;
        }  

        if(results['status'] as int == 0){ 
          return null;
        }

        List<Post> posts = [];

        for(Map<String, dynamic> p in results['message']['posts']) {
          Post postE = new Post();
          User userE = new User();

          userE.id            = p['author_id'] ?? 0;
          userE.name          = p['author_name'] ?? "";
          userE.avatar        = p['author_avatar'] ?? "";

          postE.hasAttachment  = p['has_attachment'] ?? 0;  
          postE.attachment     = p['attachment_url'] ?? "";  
          postE.id             = p['id'] ?? 0; 
          postE.userId         = p['user_id'] ?? 0; 
          postE.content        = p['content'] ?? "";
          postE.publishedAt    = p['date_register'] ?? "";
          postE.user           = userE;
          postE.reacted        = p['reacted'] ?? false;
          postE.likes          = p['reactions_amei_count'] ?? 0;
          postE.replies        = p['replies'] ?? 0; 
          postE.fixed          = p['fixed'] == 1; 
          postE.oficial        = p['oficial'] == 1; 
          postE.link           = p['link'] ?? ""; 

          posts.add(postE);
        }
        return posts; 
      });
    }
  }




  /*
   * Pega-se o post para determinado ID
   * @Param (int) postId
  */
  Future<dynamic> fetchPostById(int postId, {int eventId = 0}) async {

    // Vamos pegar o TOKEN de autenticação do usuário
    String? currentAuthToken = await UserService.getCurrentUserToken();

      if(currentAuthToken == null){
        return false;
      }

      Map<String, dynamic> postParams = <String, dynamic>{}; 

      //Vamos setar o token da sessão do usuário.
      postParams['authToken'] = currentAuthToken;

      //Vamos setar o id do evento
      postParams['event_id']   = eventId.toString();

      //Vamos setar o id do post
      postParams['post_id']   = postId.toString();

      return await serviceConnect('post/fetchById/', 'GET', postParams).then((results) { 
        if(results == null){ 
          return false;
        }
        if(results['status'] == 1){
          Post postE = new Post();
          User userE = new User();

          userE.id            = results['message']['author_id'] ?? 0;
          userE.name          = results['message']['author_name'] ?? "";
          userE.avatar        = results['message']['author_avatar'] ?? "";
          postE.user           = userE;
          postE.hasAttachment  = results['message']['has_attachment'] ?? 0;  
          postE.attachment     = results['message']['attachment_url'] ?? "";  
          postE.id             = results['message']['id'] ?? 0; 
          postE.userId         = results['message']['user_id'] ?? 0; 
          postE.content        = results['message']['content'] ?? "";
          postE.publishedAt    = results['message']['date_register'] ?? "";
          postE.reacted        = results['message']['reacted'] ?? false;
          postE.likes          = results['message']['reactions_amei_count'] ?? 0;
          postE.replies        = results['message']['replies'] ?? 0;

          return postE;
        }
        return false; 
      });
  }


  /*
   * Pegaremos as reaçÕes para determinado post
  */
  Future<dynamic> fetchReactionsByPostId(int postId, {int eventId = 0, int limit = 0, int offset = -1}) async {

    // Vamos pegar o TOKEN de autenticação do usuário
    String? currentAuthToken = await UserService.getCurrentUserToken();

      if(currentAuthToken == null){
        return false;
      }

      Map<String, dynamic> postParams = <String, dynamic>{}; 

      //Vamos setar o token da sessão do usuário.
      postParams['authToken'] = currentAuthToken;

      //Vamos setar o id do evento
      postParams['event_id']   = eventId.toString();

      //Vamos setar o id do post
      postParams['post_id']   = postId.toString();

      //Vamos setar o  limit
      postParams['limit']   = limit.toString();

      //Vamos setar o offset
      postParams['offset']   = offset.toString();
      
      // Vamos pegar uma lista de quem curtiu a publicação
      return await serviceConnect('post/lastReactions/', 'GET', postParams).then((results) { 
        if(results == null) { 
          return false;
        }
        if(results['status'] == 1){
          return List<String>.from(results['message']);
        }
        return false; 
      });
  }
}