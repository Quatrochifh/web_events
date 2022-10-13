import 'package:appweb3603/core/ServiceConnect.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/EventPhoto.dart';
import 'package:appweb3603/entities/Expositor.dart';
import 'package:appweb3603/entities/Link.dart';
import 'package:appweb3603/entities/RoomMap.dart';
import 'package:appweb3603/entities/Schedule.dart';
import 'package:appweb3603/entities/Speaker.dart';
import 'package:appweb3603/entities/Announcement.dart';
import 'package:appweb3603/entities/Notification.dart' as notification;
import 'package:appweb3603/entities/Transmission.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/enums/userEnum.dart';
import 'package:appweb3603/services/UserService.dart';
import 'package:flutter/material.dart';

import 'Service.dart'; 

class EventService extends Service { 

  EventService();

  Future<dynamic> eventLinks(int eventId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/links/${eventId.toString()}', 'GET', { 'authToken': authToken }).then((results) { 
       
      if(results == null){   
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      } 

      List<Link> links = [];
      for(int i = 0; i < results['message'].length; i++){ 
        Link link = Link();
        link.dateRegister = results['message'][i]['date_register'] ?? "";
        link.url          = results['message'][i]['url'] ?? "";
        link.title        = results['message'][i]['title'] ?? "";
        link.description  = results['message'][i]['description'] ?? ""; 
        
        links.add(link);
      }
      
      return links;
    });
  }

  Future<dynamic> findUser(int eventId, int userId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/findUser/${eventId.toString()}', 'GET', {'authToken': authToken, 'event_id': eventId.toString(), 'user_id': userId.toString()}).then((results) { 
       
      if(results == null){   
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      }
      
      return {'avatar': results['message']['avatar'], 'name': results['message']['name']};
    });
  }

  Future<dynamic> eventDocuments(int eventId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/documents/${eventId.toString()}', 'GET', {'authToken': authToken}).then((results) { 
       
      if(results == null){   
        return null;
      }

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        }
      }

      List<Link> links = [];
      for(int i = 0; i < results['message'].length; i++){ 
        Link link = Link();
        link.dateRegister = results['message'][i]['date_register'] ?? "";
        link.url          = results['message'][i]['url'] ?? "";
        link.title        = results['message'][i]['title'] ?? "";
        link.description  = results['message'][i]['description'] ?? ""; 
        
        links.add(link);
      }
      
      return links;
    });
  }

  Future<dynamic> eventBanners(int eventId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/banners/${eventId.toString()}', 'GET', {'authToken': authToken}).then((results) { 
       
      if(results == null){   
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      } 

      List<Announcement> announcements = [];
      for(int i = 0; i < results['message'].length; i++){ 
        Announcement announcement = Announcement(
          title          : results['message'][i]['title'] ?? "", 
          badge          : results['message'][i]['badge'] ?? "", 
          dateRegister   : results['message'][i]['date_register'] ?? "", 
          linkUrl        : results['message'][i]['url'] ?? "", 
          backgroundImage: results['message'][i]['background'] ?? "",  
       );
        
        announcements.add(announcement);
      }
      
      return announcements;
    });
  }

  /*
    @Param (String) title 
    @Param (Future: List)  
    @Return Future<List>
  */
  Future searchEvent(String title) async { 
    return await serviceConnect('event/search/$title', 'GET', {}).then((results) {
      if(results == null) {
        return null;
      }
      if(results['status'] == 1) {

        List<Event> events =  []; 

        for(int i = 0; i < results['message'].length; i++){
          Event event = new Event();
          event.title           = results['message'][i]['title'] ?? "";
          event.description     = results['message'][i]['description'] ?? "";
          event.id              = results['message'][i]['id'] ?? 0;
          event.startDatetime   = results['message'][i]['start_datetime'] ?? "";
          event.endDatetime     = results['message'][i]['end_datetime'] ?? "";
          event.code            = results['message'][i]['code'] ?? "";
          event.logo            = results['message'][i]['profile_image'] ?? "";
          event.background      = results['message'][i]['background_image'] ?? ""; 
          event.subscriptionStatus      = results['message'][i]['subscription_status'] ?? ""; 
          event.subscriptionStartDatetime      = results['message'][i]['start_datetime_subscription'] ?? ""; 
          event.subscriptionEndDatetime      = results['message'][i]['end_datetime_subscription'] ?? ""; 

          events.add(event); 
        }

        return events;
      }
      return results['message']; 
    });
  }

  /* 
    Vamos pegar todas as atividades do evento para determinada data. 

    @Param (int)    eventId: ID do evento 
    @Param (string) date   : Data (yyyy-mm-dd) de atividades
    @Return Future<List<Activity>>
  */
  Future<dynamic> eventActivities(int eventId, String date, bool? subscribed, {int? speakerId}) async { 
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/activities/${eventId.toString()}/$date/${(subscribed == true ? "subscribed": "")}' , 'GET', {'authToken': authToken, 'speakerId': speakerId != null ? speakerId.toString(): ""}).then((results) { 
 
      if(results == null){  
        return null;
      }     

      if(results['status'] != 1 || results['message'] == null){ 
        return null;
      }

      List<Schedule> schedules = [];

      for(int i = 0; i < results['message'].length ; i++){
        Schedule schedule = Schedule();

        if(results['message'][i] == null){
          continue;
        }

        schedule.status      = results['message'][i]['current_status'] ?? "";
        schedule.title       = results['message'][i]['title'] ?? "";
        schedule.description = results['message'][i]['description'] ?? ""; 
        schedule.endDateTime = results['message'][i]['end_datetime'] ?? "";
        schedule.room = results['message'][i]['room'] ?? "";
        schedule.background = results['message'][i]['background'] ?? "";
        schedule.link = results['message'][i]['link'] ?? "";
        schedule.startDateTime = results['message'][i]['start_datetime'] ?? "";
        schedule.id = results['message'][i]['id'] ?? 0; 
        schedule.userHasSubscribed =  results['message'][i]['has_subscribed'] ?? false;

        Speaker speaker = Speaker(
          name: results['message'][i]['speaker']['name'] ?? "",
          avatar: results['message'][i]['speaker']['avatar'] ?? "",
          id: results['message'][i]['speaker']['user_id'] ?? 0,
          speakerId: results['message'][i]['speaker']['id'] ?? 0,
          background: results['message'][i]['speaker']['background'] ?? "",
          description: results['message'][i]['speaker']['description'] ?? "",
          level: UserEnumFunctions.toEnum('speaker')
        );

        schedule.speaker = speaker;
        schedules.add(schedule);
      }
      
        
      return schedules;
    }); 
  }

  /* 
    Vamos pegar todos os expositores do evento

    @Param (int)    eventId: ID do evento 
    @Return Future<List<Expositor>>
  */
  Future<dynamic> eventExpositors(int eventId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/expositors/${eventId.toString()}/', 'GET', {'authToken': authToken}).then((results) { 
       
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      }

      List<Expositor> expositors = [];
      for(int i = 0; i < results['message'].length; i++){ 
        Expositor expositor = Expositor(
          title: results['message'][i]['title'] ?? "",
          description: results['message'][i]['description'] ?? "",
          telephone: results['message'][i]['telephone'] ?? "",
          image: results['message'][i]['image'] ?? "",
          email: results['message'][i]['email'] ?? "",
          url: results['message'][i]['url'] ?? "",
          address: results['message'][i]['address'] ?? "",
        );

        expositor.medias = {
          'facebook' : results['message'][i]['facebook'] ?? "",
          'instagram' : results['message'][i]['instagram'] ?? "",
          'linkedin' : results['message'][i]['linkedin'] ?? "",
        };
        
        expositors.add(expositor);
      }
      
      return expositors;
    });
  }

  /* 
    Vamos pegar todos os expositores do evento

    @Param (int)    eventId: ID do evento 
    @Return Future<List<Expositor>>
  */
  Future<dynamic> eventRoomMaps(int eventId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/roomMaps/${eventId.toString()}/', 'GET', {'authToken': authToken}).then((results) { 
       
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      }

      List<RoomMap> roomMaps = [];
      for(int i = 0; i < results['message'].length; i++){ 
        RoomMap roomMap = RoomMap(
          title: results['message'][i]['title'] ?? "",
          description: results['message'][i]['description'] ?? "",
          url: results['message'][i]['url'] ?? "",
          mapImage: results['message'][i]['image'] ?? "",
        );
        
        roomMaps.add(roomMap);
      }
      
      return roomMaps;
    });
  }

  Future<dynamic> eventActivitySubscription(int eventId, int activityId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/activitySubscription/${eventId.toString()}/${activityId.toString()}/', 'GET', {'authToken': authToken}).then((results) { 
       
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      } 
      
      return true;
    });
  }

  Future<dynamic> eventActivityUnsubscription(int eventId, int activityId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/activitySubscription/${eventId.toString()}/${activityId.toString()}/unsubscription', 'GET', { 'authToken': authToken }).then((results) { 
       
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      } 
      
      return true;
    });
  }

  Future<dynamic> eventVerifySubscrpition(int eventId, int activityId) async {
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/activityVerifySubscription/${eventId.toString()}/${activityId.toString()}/unsubscription', 'GET', {'authToken': authToken}).then((results) { 
       
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        if(results['message'].runtimeType.toString() == "String"){
          return results['message'];
        }else{ 
          return results['message'][0];
        } 
      } 
      
      return results['message'] == 'true' ? true: false ;
    });
  }

  /* 
    Vamos pegar todas as datas  de atividades inscritas
    @Param (int)    eventId: ID do evento   
    @Return (<List<String>>)
  */
  Future<dynamic> eventActivitiesSubscriptionsDates(int eventId) async { 
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/activitiesSubscriptionsDates/${eventId.toString()}', 'GET', { 'authToken': authToken }).then((results) { 
 
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        return null;
      }

      List<String> dates = []; 

      for(int i = 0; i < results['message'].length; i++){
        dates.add( results['message'][i]['start_date']);
      } 
      
      return dates;
    }); 
  }

  /* 
    Vamos pegar todas as datas que tiverem evento
    @Param (int)    eventId: ID do evento   
    @Return (<List<String>>)
  */
  Future<dynamic> eventActivitiesDates(int eventId) async { 
    String authToken = await UserService.getCurrentUserToken();
    
    return await serviceConnect('event/activitiesDates/${eventId.toString()}', 'GET', { 'authToken': authToken }).then((results) { 
 
      if(results == null){  
        return null;
      }   

      if(results['status'] != 1){ 
        return null;
      }

      List<String> dates = []; 

      for(int i = 0; i < results['message'].length; i++){
        dates.add( results['message'][i]['start_date']);
      } 
      
      return dates;
    });
  }


  /*
   * Pegar os palestrantes do evento
  */
  Future<dynamic> eventSpeakers(int eventId, {String? name, int page = 1, int limit = 0, int offset = 0}) async {

    String route = "speakers";

    // No servidor, há uma rota específica para a busca de um palestrante.
    if (name != null && name.isNotEmpty) {
      route = "searchSpeakers";
    }

    return await serviceConnect(
      'event/$route/${eventId.toString()}',
      'GET', {
        'page': page.toString(),
        'searchQuery': name,
        'limit': limit.toString(),
        'offset': offset.toString(),
        'isSpeaker' : '1'
      }).then((results) { 
 
      if(results == null){ 
        return null;
      }   
       
      List<Speaker> speakers = [];
      if(results['status'] == 1){ 
        for(int i = 0; i < results['message'].length ; i++){   
          Enum levelEnum;
          switch(results['message'][i]['level']){
            case 'speaker':
              levelEnum = UserEnum.speaker;
            break;
            default:
              levelEnum = UserEnum.common;
            break;
          }

          Speaker speaker = Speaker(
            name: results['message'][i]['name'] ?? "",
            avatar: results['message'][i]['avatar'] ?? "",
            background: results['message'][i]['background'] ?? "",
            id: results['message'][i]['user_id'] ?? 0,
            speakerId: results['message'][i]['id'] ?? 0,
            description: results['message'][i]['description'] ?? "",
            level: levelEnum, 
          );

          speaker.fillSocialMedias(results['message'][i]['medias'] ?? <String, String>{ });

          speakers.add(speaker);
        }
      }
      return speakers;
    });
     
  }


  /*
    
  */
  Future<dynamic> eventParticipants(int eventId, int page, {String? name}) async {

    String authToken = await UserService.getCurrentUserToken();

    name ??= "";

    return await serviceConnect('event/participants/${eventId.toString()}', 'GET', {'page': page.toString(), 'authToken': authToken, 'searchQuery': name}).then((results) { 
 
      if(results == null){ 
        return null;
      }   
       
      List<User> users = [];
      if(results['status'] == 1){
        for(int i = 0; i < results['message'].length ; i++){    
          if(results['message'][i] == null) continue;
            User user = User(
              email: results['message'][i]['email'] ?? "",
              name: results['message'][i]['name'] ?? "",
              avatar: results['message'][i]['avatar'] ?? "",
              id: results['message'][i]['user_id'],
              level: UserEnumFunctions.toEnum(results['message'][i]['level']),
              company: results['message'][i]['company'] ?? "",
              role: results['message'][i]['role'] ?? "",
              telephone: results['message'][i]['telephone'] ?? "",
              showProfile: results['message'][i]['show_profile'] ?? true,
            );

          /*
          * Vamos carregar as midias sociais do usuário 
          */

          user.fillSocialMedias(results['message'][i]['medias'] ?? {});

          users.add(user); 
        } 
      }

      return users;
    });
     
  }



  /*
    
  */
  Future<dynamic> eventPhotos(int eventId, { int currentPage = 1, bool oficial = false}) async { 

    String authToken = await UserService.getCurrentUserToken();

    return await serviceConnect('event/photos/${eventId.toString()}/${currentPage.toString()}/', 'GET', {'authToken': authToken, 'oficial': oficial == true ? '1': '0'}).then((results) { 
 
      if(results == null){  
        return null;
      }      
      
      List<EventPhoto> photos = [];
      if(results['status'] == 1){ 
        for(int i = 0; i < results['message'].length ; i++){   
          photos.add(EventPhoto(
            authorName:        results['message'][i]['author_name'] ?? "",
            authorAvatarUrl:   results['message'][i]['author_avatar'] ?? "",
            dateRegister:      results['message'][i]['date_register'] ?? "",
            id:                results['message'][i]['id'] ?? 0,
            url:               results['message'][i]['url'] ?? ""
         )); 
        } 
      }
       
      return photos; 
    });
     
  }


  /*
    
  */
  Future<dynamic> eventTransmissions(int eventId) async { 

    String authToken = await UserService.getCurrentUserToken();

    return await serviceConnect('event/transmissions/${eventId.toString()}/', 'GET', {'authToken': authToken}).then((results) { 
 
      if(results == null){  
        return null;
      }     
      
      List<Transmission> transmissions = [];
      if(results['status'] == 1){ 
        for(int i = 0; i < results['message'].length ; i++){   
          transmissions.add(Transmission(
            title:        results['message'][i]['title'].toString(),
            dateRegister: results['message'][i]['date_register'].toString(),
            id:           results['message'][i]['id'] ?? 0,
            videoUrl:     results['message'][i]['url'].toString(),
            thumbnail:    results['message'][i]['thumbnail'].toString(),
            duration:     results['message'][i]['duration'].toString(),
            description:  results['message'][i]['description'].toString(),
            plays      : results['message'][i]['plays'] ?? 0
         )); 
        } 
      }
       
      return transmissions;
    }); 
  }

  /*
    
  */
  Future<dynamic> currentLive(int eventId) async { 

    String authToken = await UserService.getCurrentUserToken();

    return await serviceConnect('event/currentLive/${eventId.toString()}', 'GET', {'authToken': authToken}).then((results) { 
 
      if(results == null){  
        return null;
      }     
      
     Transmission? transmission;
 

      if(results['status'] == 1 && results['message'] != null){ 
        transmission = Transmission(
          title:        results['message']['title'] ?? "",
          dateRegister: results['message']['date_register'] ?? "",
          id:           results['message']['id'] ?? 0,
          externo:      results['message']['externo'] ?? "nao",
          videoUrl:     results['message']['url'] ?? "",
          thumbnail:    results['message']['thumbnail'] ?? "",
         // duration:     results['message']['duration'] ?? "",
          description:  results['message']['description'] ?? "" 
       );
      }
       
      return transmission;
    }); 
  }

  /*
    
  */
  Future<dynamic> eventNotifications(int eventId) async { 

    String authToken = await UserService.getCurrentUserToken();

    return await serviceConnect('event/notifications/${eventId.toString()}', 'GET', {'authToken': authToken}).then((results) { 
 
      if(results == null){  
        return null;
      }     
      
      List<notification.Notification> notifications = [];
      if(results['status'] == 1){ 
        for(int i = 0; i < results['message'].length ; i++){   
          notifications.add(
            notification.Notification(
              title:        results['message'][i]['title'] ?? "",
              description:   results['message'][i]['description'] ?? "",
              id:            i, 
              linkUrl:  results['message'][i]['link_url'] ?? 0, 
              dateRegister:  results['message'][i]['date_register'] ?? "", 
              route  : results['message'][i]['route']  ?? <String, dynamic>{ }, 
              icon  :   results['message'][i]['icon'] ?? "", 
           ) 
         ); 
        } 
      }
       
      return notifications;
    });

  }

  
}