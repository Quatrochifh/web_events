import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Bloc.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb3603/entities/Event.dart' as entity;

class Event extends Bloc{

  Event () : super();

  /*
     
  */
  Future<dynamic> documents(){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventDocuments( event.id ).then((results){
        return results;
      }); 
    });
  }

  /*
     
  */
  Future<dynamic> links(){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventLinks( event.id ).then((results){ 
        return results;
      }); 
    });
  }

  /*
     
  */
  Future<dynamic> eventParticipants({String? name, int page = 1}){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventParticipants( event.id, page, name : name ).then((results){ 
        return results;
      }); 
    });
  }


  /*
     
  */
  Future<dynamic> activitySubscription(int activityID){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventActivitySubscription(event.id, activityID).then((results){
        return results;
      }); 
    });
  }


  /*
     
  */
  Future<dynamic> activityVerifySubscripition(int activityID){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventVerifySubscrpition(event.id, activityID).then((results){
        return results;
      }); 
    });
  }

  /*
    * Buscar por atividades (palestras)
  */
  Future<dynamic> eventActivities({String date = "", int? speakerId, bool hasSubscribed  = false}){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventActivities(event.id, date, hasSubscribed, speakerId: speakerId).then((results){
        return results;
      });
    });
  }

  /*
    Remover inscrição na atividade
  */
  Future<dynamic> activityUnsubscription( int activityID ){ 
    /*
      Vamos nos inscrever na atividade.
    */
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventActivityUnsubscription( event.id, activityID ).then((results){
        return results;
      }); 
    });
  }

  /*
    Busca por notificações do evento
  */
  Future<int> eventNotifications(){ 
    return Modular.get<Controller>().event.then((event){
      return Modular.get<EventService>().eventNotifications(event.id).then((results){ 
        if( results.runtimeType.toString() != 'List<Notification>' ){
          return 0;
        }
        return results.length;
      });
    });  
  }

  /*
   * Busca por expositores
  */
  Future<dynamic> eventExpositors({int limit = -1, int offset = 0}){
    /*
    * Vamos pegar os banners do evento
    */
    return diContainer.get(EventService).eventExpositors(diContainer.get(entity.Event).id).then((results){
      if (results.runtimeType.toString() != 'List<Expositor>' || results.isEmpty) {
        return [];
      }
      return results;
    });
  }

  /*
   * Busca por mapas das salas
  */
  Future<dynamic> eventRoomMaps({int limit = -1, int offset = 0}){
    /*
    * Vamos pegar os banners do evento
    */
    return diContainer.get(EventService).eventRoomMaps(diContainer.get(entity.Event).id).then((results){
      if (results.runtimeType.toString() != 'List<RoomMap>' || results.isEmpty) {
        return [];
      }
      return results;
    });
  }

  /*
   * Busca por banners do evento
  */
  Future<dynamic> eventBanners({int limit = -1, int offset = 0}){
    /*
    * Vamos pegar os banners do evento
    */
    return diContainer.get(EventService).eventBanners(diContainer.get(entity.Event).id).then((results){
      if (results.runtimeType.toString() != 'List<Announcement>' || results.isEmpty) {
        return [];
      }
      return results;
    });
  }

  /*
   * Pegar os palestrantes para o evento
  */
  Future<dynamic> eventSpeakers({String? name, int page = 0, int limit = 0, int offset = 0}){
    entity.Event event  = globalDIContainer.get(entity.Event) as entity.Event;
    return diContainer.get(EventService).eventSpeakers(event.id, name: name, page: page, limit: limit, offset: offset).then((results){ 
      if( results.runtimeType.toString() != 'List<Speaker>' ){
        return [];
      }
      return results;
    });
  }

}