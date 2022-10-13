 
import 'package:appweb3603/bloc/Event.dart' as event_bloc;
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_badge.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_datetime_header.dart';
import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/components/widget_speaker_simple_card.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Schedule.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/widget_message.dart';

class SchedulePage extends StatefulWidget{  

  final Schedule schedule;

  SchedulePage({Key? key, required this.schedule}) : super(key:key);

  @override
  SchedulePageState createState() => new SchedulePageState();
} 

class SchedulePageState extends State<SchedulePage> with PageComponent{ 

  Controller controller  = Modular.get<Controller>();    

  bool _buttonUnsubscription = false;

  @override 
  void initState(){
    super.initState();   

    setState((){
      _buttonUnsubscription = widget.schedule.userHasSubscribed;
    });
  }

  void _eventActivitySubscription(){  
    showLoading();
    Modular.get<event_bloc.Event>().activitySubscription( widget.schedule.id ).then((results){
      hideLoading(); 
      if( results == true ){ 
        showAlert( title : "Inscrição efetuada!", message: "Você poderá ver suas atividades em 'Agenda'");
        setState((){
          _buttonUnsubscription = true;
        });
      } else {
        registerNotification(message: "Fora de período inscrição.", type: "warnign");
      }
    }); 
  }

  void _eventActivityUnsubscription(){  
    showLoading();
    Modular.get<event_bloc.Event>().activityUnsubscription( widget.schedule.id ).then((results){
      hideLoading();
      if( results == true ){ 
        showAlert( title : "Desinscrição efetuada!", message: "Você remevou sua participação da atividade. Ela será removida da sua agenda.");
        setState((){
          _buttonUnsubscription = false;
        });
      } else {
        registerNotification(message: "Não é possível mais remover a inscrição.", type: "warnign");
      }
    }); 
  }

  @override
  Widget build( BuildContext context ){

    return content(
      body:  <Widget>[
        Expanded(
          child: ListView(
            padding: noPadding,
            children: [
              Stack(
                children: [
                  Container(
                    height: 305,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.125)
                    ),
                    child: CustomImage(
                      width: double.infinity,
                      height: 305,
                      image: widget.schedule.background,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: TemplateAppBar(
                      bgColor: Colors.transparent,
                      iconColor: Colors.white,
                      event: controller.currentEvent,
                      back: true,
                      hideUser: true,
                      title: "Agenda : ${widget.schedule.title}",
                      user: controller.currentUser
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 272,
                      left: 10,
                      right: 5
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.schedule.title, 
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle( 
                                fontSize: 27.6,     
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis, 
                                color: Colors.black
                              )
                            ),
                          )
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_buttonUnsubscription)
                    ?
                      Expanded(
                        child: Message(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(
                            top: 12,
                            bottom: 12,
                            left: 25,
                            right: 25
                          ),
                          fontSize: 14,
                          borderRadius: 100,
                          bgColor: successColor,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.black,
                          text: "Você está inscrito",
                          iconColor: Colors.black,
                          icon: FontAwesomeIcons.check,
                        )
                      )
                    :
                      SizedBox.shrink()
                ]
              ),*/
              (widget.schedule.status != "open")
              ?
                Message(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 25,
                    right: 25
                  ),
                  fontSize: 15.5,
                  borderRadius: 100,
                  bgColor: attentionColor,
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  text: "Inscrições encerradas",
                )
              :
                Message(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 25,
                    right: 25
                  ),
                  fontSize: 15.5,
                  borderRadius: 100,
                  bgColor: successColor,
                  textColor: Colors.black,
                  text: "Aberto para inscrições.",
                ),
              Container(
                margin: noMargin,
                child: Column( 
                  children: [
                    DateTimeHeader(
                      padding: EdgeInsets.all(20),
                      date: dateDayAndMonthName(widget.schedule.endDateTime),
                      startTime: widget.schedule.startHour,
                      endTime: widget.schedule.endHour,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child:  Details(
                        titleColor: Colors.black,
                        descriptionSize: 16,
                        titleSize: 22,
                        marginBottom: 35,
                        items: {
                          "Descrição" : widget.schedule.description,
                          "Localização" : widget.schedule.room,
                          "Palestrantes" : SpeakerSimpleCard(
                            margin: EdgeInsets.all(0),
                            speaker: widget.schedule.speaker
                          ),
                        }
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10
                      ),
                      margin: EdgeInsets.only(
                        top: 10,
                        bottom: 30
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           (widget.schedule.link.isNotEmpty) ?
                            Expanded(
                              child: PrimaryButton(
                                marginRight: 10,
                                marginLeft: 10,
                                onClick: () async { 
                                  try{
                                    await launch(widget.schedule.link); 
                                  }catch(e) {
                                    debugPrint(e.toString()); 
                                  }
                                },
                                padding: noPadding,
                                backgroundColor: infoColor,
                                height: 45,
                                borderRadius: 100,
                                fontSize: 14.5,
                                textColor: infoDarkColor,
                                fontWeight: FontWeight.normal,
                                title: "Página do Evento", 
                                icon: FontAwesomeIcons.chevronRight,
                                iconRight: true,
                              )
                            )
                          :
                            SizedBox.shrink(),
                          (_buttonUnsubscription) ?
                            PrimaryButton(
                              marginRight: 10,
                              marginLeft: 10,
                              onClick: (){ 
                                _eventActivityUnsubscription();  
                              },
                              padding: noPadding,
                              backgroundColor: primaryColor,
                              height: 45,
                              width: 140,
                              borderRadius: 100,
                              fontSize: 14,
                              iconSize: 15,
                              fontWeight: FontWeight.normal,
                              title: "Desinscrever", 
                              icon: FontAwesomeIcons.xmark,
                            )
                        :  
                            PrimaryButton(
                              marginRight: 10,
                              marginLeft: 10,
                              onClick: (){ 
                                _eventActivitySubscription(); 
                              },
                              padding: noPadding,
                              borderRadius: 100,
                              backgroundColor: primaryColor,
                              height: 45,
                              width: 140,
                              iconSize: 15,
                              fontSize: 14,
                              title: "Inscrever-se", 
                              icon: FontAwesomeIcons.plus,
                            )
                        ],
                      ),
                    ),
                  ],
                ), 
              ),
            ]
          )  
        )
      ], 
      drawer: NavDrawer()
    ); 

  }

}  