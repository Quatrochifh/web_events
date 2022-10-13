import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Event.dart' as event_bloc;
import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/schedule/widget_schedules.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Speaker.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';  
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../components/widget_speaker_header.dart'; 
 
// Organizado | 18/jun/2022
class SpeakerActivitiesPage extends StatefulWidget{   

  final Speaker speaker;

  SpeakerActivitiesPage({Key? key, required this.speaker}) : super(key: key);

  @override
  SpeakerActivitiesPageState createState() => new SpeakerActivitiesPageState();
}


class SpeakerActivitiesPageState extends State<SpeakerActivitiesPage> with PageComponent{

  bool get wantKeepAlive => true;

  GlobalKey<SchedulesState> _schedulesState = new GlobalKey();

  Controller controller  = Modular.get<Controller>();

  @override 
  void initState(){
    super.initState();
    this._fetchActivities();
  }

  void _fetchActivities(){ 
    // Exibir o loading
    showLoading(); 

    // Buscar por atividades do palestrantes
    (globalDIContainer.get(event_bloc.Event) as event_bloc.Event).eventActivities(speakerId: widget.speaker.speakerId).then((results){
      // Esconder loading
      hideLoading();
      if(results != null){
        _schedulesState.currentState!.updateSchedules(results);
      }
    });
  }


  @override
  Widget build(BuildContext context){

    return content(
      color: mainBackgroundColor,
      body:  <Widget>[
        Expanded(
          child: Schedules(
            safeTop: false,
            key: _schedulesState,
            user: Modular.get<Controller>().currentUser,
            event: Modular.get<Controller>().currentEvent
          )
        )
      ], 
      drawer: NavDrawer(),
      header:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [ligthShadow],
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.075),
              width: 0.5
            )
          )
        ),
        child:  SafeArea(
          bottom: false,
          child: Row(
            children:[
              PrimaryButton(
                onClick: (){
                  Navigation.changeToBack(context);
                },
                width: 50,
                height: 35,
                iconSize: 35,
                backgroundColor: Colors.transparent,
                iconColor: Colors.black,
                icon: CupertinoIcons.chevron_back,
              ),
              Expanded(
                child: SpeakerHeader(
                  noShadow: true,
                  margin: EdgeInsets.all(0),
                  speaker: widget.speaker,
                )
              )
            ]
          )
        )
      )
    );
  }
}