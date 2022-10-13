

import 'package:appweb3603/components/schedule/widget_schedule.dart';
import 'package:appweb3603/components/widget_empty_box.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart'; 
import 'package:appweb3603/entities/Schedule.dart' as schedule_entity; 
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart'; 
 

class Schedules extends StatefulWidget{   

  final User user;

  final Event event;

  final bool? safeTop;

  Schedules({Key? key, required this.user, required this.event, this.safeTop = true}) : super(key : key);  

  @override
  SchedulesState createState() =>  new SchedulesState();
}

class SchedulesState extends State<Schedules>{

  List<Schedule> _schedules = [];

  /*
   * Atualiza a lista de schedules
  */
  void updateSchedules(List<schedule_entity.Schedule> schedules){

    if (!mounted) return;
    
    _schedules = [];
    
    schedules.forEach((element) {
      _schedules.add(
        Schedule(
          key: new GlobalKey(),
          schedule: element,
          event: widget.event
        )
      );
    });

    setState((){
      _schedules = _schedules;
    });
  }

  @override
  void initState(){ 
    super.initState();   
  }
 
  @override
  Widget build(BuildContext context) { 

    Widget listView = ListView( 
      padding: noPadding, 
      children:
        (_schedules.isNotEmpty)
            ? 
              (
                <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: widget.safeTop == true ? 65 : 0)
                  )
                ] +
                List<Widget>.from(_schedules)
              )
            :
          <Widget>[
            Container(
                padding: EdgeInsets.only(top: widget.safeTop == true ? 65 : 0)
            ),
            EmptyBox( message: "Nenhum evento encontrado.")
          ]
    );
 
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: listView
    );
  }
} 

   