import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/services/ConversationService.dart';
import 'package:appweb3603/entities/Conversation.dart' as conversationentity;
import 'package:flutter_modular/flutter_modular.dart'; 

class Conversation{
  
  /*
    * Enviar uma mensagem
    * int receiverID : ID de quem vai receber a mensagem
    * String message : Mensagem a ser enviada
    * String attachment : Anexo a ser enviado
  */
  Future<dynamic> sendMessage(int receiverID, String message, String? attachment){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<ConversationService>().sendMessage(event.id, receiverID, message, attachment).then((results){

        if(results == true){
          conversationentity.Conversation conversation = new conversationentity.Conversation(); 
          conversation.content = message;
          conversation.dateRegister = "Agora mesmo" ; 
          return conversation;
        }

        return results;
      }); 
    });
  }

}