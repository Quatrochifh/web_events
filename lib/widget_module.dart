import 'package:appweb3603/bloc/Conversation.dart' as conversation_bloc;
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/mobx/feed.dart' as feed_mobx;
import 'package:appweb3603/bloc/Feed.dart' as feed_bloc;
import 'package:appweb3603/bloc/Account.dart' as profile_bloc;
import 'package:appweb3603/bloc/Event.dart' as event_bloc;
import 'package:appweb3603/bloc/Login.dart' as login_bloc;
import 'package:appweb3603/pages/conversation/conversation_room_page.dart';
import 'package:appweb3603/pages/event_page.dart';
import 'package:appweb3603/pages/files_page.dart'; 
import 'package:appweb3603/pages/home_page.dart';
import 'package:appweb3603/pages/init_page.dart';
import 'package:appweb3603/pages/links_page.dart'; 
import 'package:appweb3603/pages/login_page.dart';
import 'package:appweb3603/pages/main_page.dart';
import 'package:appweb3603/pages/maps_page.dart';
import 'package:appweb3603/pages/my_schedules_page.dart';
import 'package:appweb3603/pages/notification_page.dart';
import 'package:appweb3603/pages/participants_page.dart';
import 'package:appweb3603/pages/photo_page.dart';
import 'package:appweb3603/pages/photos_page.dart';
import 'package:appweb3603/pages/plans_page.dart';
import 'package:appweb3603/pages/post_page.dart';
import 'package:appweb3603/pages/profile_page.dart';
import 'package:appweb3603/pages/register_page.dart';
import 'package:appweb3603/pages/reset_password_page.dart';
import 'package:appweb3603/pages/account_page.dart';
import 'package:appweb3603/pages/schedule_page.dart';
import 'package:appweb3603/pages/schedules_page.dart'; 
import 'package:appweb3603/pages/search_event_page.dart';
import 'package:appweb3603/pages/search_event_page_results.dart';
import 'package:appweb3603/pages/speaker_activities_page.dart';
import 'package:appweb3603/pages/speakers_page.dart';
import 'package:appweb3603/pages/transmission_page.dart';
import 'package:appweb3603/pages/transmissions_page.dart';
import 'package:appweb3603/pages/conversation/conversation_rooms_page.dart';
import 'package:appweb3603/pages/user_page.dart';
import 'package:appweb3603/services/ConversationService.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/services/PostService.dart';
import 'package:appweb3603/services/UserService.dart';
import 'package:appweb3603/style.dart';
import 'package:appweb3603/validate.dart';
import 'package:appweb3603/widget_app.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module{ 

  /*
    Itens a serem enviados via injeção de dependência.
      isSingleton: Apenas uma instância para todos. 
  */
  @override
  List<Bind> get binds => [
    //
    Bind((i) => Controller(), isSingleton: true),
    Bind((i) => UserService(), isSingleton: true),
    Bind((i) => EventService(), isSingleton: true),
    Bind((i) => PostService(), isSingleton: true),
    Bind((i) => ConversationService(), isSingleton: true),
    Bind((i) => feed_mobx.Feed(), isSingleton: false),
    Bind((i) => Validate(), isSingleton: false),
    Bind((i) => conversation_bloc.Conversation(), isSingleton: false),
    Bind((i) => event_bloc.Event(), isSingleton: false),
    Bind((i) => feed_bloc.Feed(), isSingleton: false),
    Bind((i) => profile_bloc.Account(userService: i.get<UserService>()),  isSingleton: false),
    // Blocs
    Bind((i)  => login_bloc.Login(), isSingleton: true),
    Bind((i)  => event_bloc.Event(), isSingleton: true)
  ];

  // rotas do módulo 
  @override
  List<ModularRoute> get routes => [
    ChildRoute("/",          child: (context, args) => InitPage(), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-reset-password",child: (context, args) => ResetPassword(), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-plans",      child: (context, args) => PlansPage(eventCode: args.data['eventCode'], eventName: args.data['eventName'], eventBackground: args.data['eventBackground'], eventLogo: args.data['eventLogo'], loginEmail: args.data['loginEmail'], loginPassword: args.data['loginPassword'] ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-register",      child: (context, args) => RegisterPage(planId: args.data['planId'], eventCode: args.data['eventCode'], eventName: args.data['eventName'], eventBackground: args.data['eventBackground'], eventLogo: args.data['eventLogo'], loginEmail: args.data['loginEmail'], loginPassword: args.data['loginPassword'] ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-login",         child: (context, args) => LoginPage(eventCode: args.data['eventCode'], eventName: args.data['eventName'], eventBackground: args.data['eventBackground'], eventLogo: args.data['eventLogo'], loginEmail: args.data['loginEmail'], loginPassword: args.data['loginPassword'] ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-links",         child: (context, args) => LinksPage(), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-maps",          child: (context, args) => MapsPage(), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-main",          child: (context, args) => MainPage(), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-home",          child: (context, args) => HomePage(), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-home-feed",     child: (context, args) => HomePage(startFeed : args.data ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-post",          child: (context, args) => PostPage(post: args.data['post']), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-notifications", child: (context, args) => NotificationsPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-my-schedules",  child: (context, args) => MySchedulePages(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-schedules",     child: (context, args) => SchedulesPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-schedule",      child: (context, args) => SchedulePage(schedule: args.data['schedule'] ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-transmissions", child: (context, args) => TransmissionsPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-event",         child: (context, args) => EventPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-transmission",  child: (context, args) => TransmissionPage(transmission:  args.data['transmission'], ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-conversation-room",  child: (context, args) => ConversationRoom(conversation : args.data != null ? args.data['conversation'] : 0), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-conversation-rooms",  child: (context, args) => ConversationRooms(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-user",          child: (context, args) => UserPage(user:  args.data['user'] ), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-speakers",      child: (context, args) => SpeakersPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-files",         child: (context, args) => FilesPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-participants",  child: (context, args) => ParticipantsPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-profile",       child: (context, args) => ProfilePage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-security",      child: (context, args) => AccountPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-photos",        child: (context, args) => PhotosPage(), maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-photo",         child: (context, args) => PhotoPage(photo: args.data['photo'] ), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-speaker-activities", child: (context, args) => SpeakerActivitiesPage(speaker: args.data['speaker']), maintainState: false, transition: TransitionType.noTransition),
    ChildRoute("/view-search-event",  child: (context, args) => SearchEvent(), customTransition: customTransition, maintainState: false, transition: TransitionType.noTransition), 
    ChildRoute("/view-search-event-results",  child: (context, args) => SearchEventResults(searchValue: args.data != null ? args.data['searchValue'] : "boti" ), customTransition: customTransition, maintainState: false, transition: TransitionType.noTransition),   
  ];

  //widget principal    
  Widget get bootstrap => App();

}