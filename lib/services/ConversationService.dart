import 'package:appweb3603/core/ServiceConnect.dart';
import 'package:appweb3603/entities/Conversation.dart'; 
import 'package:appweb3603/services/Service.dart';
import 'package:appweb3603/services/UserService.dart';

import '../core/Auth.dart';

class ConversationService extends Service {

  Auth auth = new Auth();

  Future<dynamic> sendMessage( int eventID, int receiverID, String message, String? attachment) async {

    String authToken = await UserService.getCurrentUserToken(); 
    
    return await serviceConnect('conversation/sendMessage/', 'POST', {'authToken' : authToken, 'receiver_id' : receiverID.toString(), 'content' :  message, 'event_id' : eventID.toString(), 'attachment' : attachment ?? ""} ).then( ( results ) { 
      

      if( results == null ){  
        return null;
      }

      if( results['status'] != 1 ){
        return results['message'];
      }  

      return true;
    });
  }

  /*
    
  */
  Future<dynamic> getMessagesByReceiver( int eventId, int receiverID, int _currentPage) async {

    String authToken = await UserService.getCurrentUserToken(); 
    
    return await serviceConnect('conversation/fetchMessages/', 'GET', { 'authToken' : authToken, 'receiver_id' : receiverID.toString(), 'page' : _currentPage.toString(), "event_id" : eventId.toString() } ).then( ( results ) { 

      if( results == null ){  
        return null;
      }

      if( results['status'] != 1 ){ 
        return null;
      } 

      List<Conversation> conversations = [];

      for( int i = 0; i < results['message'].length; i++ ){
        Conversation conversation = new Conversation();
        conversation.id           = results['message'][i]['conversation_id'];
        conversation.content      = results['message'][i]['conversation_content'];
        conversation.dateRegister = results['message'][i]['conversation_date_register'];
        conversation.senderID     = results['message'][i]['conversation_sender_id'];
        conversation.receiverID   = results['message'][i]['conversation_receiver_id'];
        conversation.senderAvatar   = results['message'][i]['sender_avatar'];
        conversation.senderName   = results['message'][i]['sender_name'];
        conversation.receiverAvatar   = results['message'][i]['receiver_avatar'];
        conversation.receiverName   = results['message'][i]['receiver_name']; 
        conversation.author       = results['message'][i]['conversation_author'];
        conversation.attachmentUrl = results['message'][i]['conversation_attachment'] ?? "";
        conversations.add( conversation );
      }

      return conversations;
    }); 
  }

  /*
    
  */
  Future<dynamic> getMessagesRooms(int eventId) async {

    String authToken = await UserService.getCurrentUserToken(); 
    
    return await serviceConnect('conversation/fetchRooms/', 'GET', { 'authToken' : authToken, 'page' : "1", "event_id" : eventId.toString() } ).then( ( results ) async { 

      if( results == null ){  
        return null;
      }

      if( results['status'] != 1 ){ 
        return null;
      } 

      List<Conversation> conversations = [];

      int? userID =  await UserService.getCurrentUserId();

      for( int i = 0; i < results['message'].length; i++ ){
        Conversation conversation = new Conversation();
        conversation.id = results['message'][i]['conversation_id'];
        conversation.content = results['message'][i]['conversation_content'];
        conversation.dateRegister = results['message'][i]['conversation_date_register'];
        conversation.senderID = results['message'][i]['conversation_sender_id'];
        conversation.receiverID = results['message'][i]['conversation_receiver_id'];
        conversation.receiverName = results['message'][i]['receiver_name'];
        conversation.receiverAvatar = results['message'][i]['receiver_avatar'];
        conversation.attachmentUrl = results['message'][i]['conversation_attachment'] ?? "";
        conversation.author     = conversation.senderID == userID;
        conversations.add(conversation);
      }

      return conversations;
    }); 
  }
 
}