import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_badge.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/Schedule.dart' as schedulee;
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
 

class Schedule extends StatefulWidget {

  final bool? hideSpeaker;

  final Event event;

  final schedulee.Schedule schedule;

  Schedule({Key? key, required this.schedule, required this.event, this.hideSpeaker}) : super(key: key);

  @override
  ScheduleState createState() =>  new ScheduleState();
}

class ScheduleState extends State<Schedule> {
 
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){ 
        navigatorPushNamed(
          context,
          '/view-schedule',
          arguments: {
            'schedule': widget.schedule
          });
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(
          top: 3,
          bottom: 3,
          left: 3,
          right: 3
        ),
        width: double.infinity,
        height: widget.hideSpeaker == true ? 177 : 217,
        decoration: BoxDecoration(
          color: secondLayerBgColor,
          border: Border.all(
            color: Colors.black.withOpacity(0.125),
            width: 0.3
          )
        ),  
        child: Container(
          margin: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(2.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                "Data", 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle( 
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  color: infoSecondLayerTextColor.withOpacity(0.5)
                                )
                              ),
                              Text(
                                dateDayAndMonthName(widget.schedule.startDateTime), 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle( 
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: infoSecondLayerTextColor,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ]
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(2.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                "Inicio", 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle( 
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  color: infoSecondLayerTextColor.withOpacity(0.5)
                                )
                              ),
                              Text(
                                widget.schedule.startHour, 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle( 
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: infoSecondLayerTextColor,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ]
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(2.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                "Fim", 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle( 
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  color: infoSecondLayerTextColor.withOpacity(0.5)
                                )
                              ),
                              Text(
                                widget.schedule.endHour, 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: infoSecondLayerTextColor,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ]
                          ),
                        ),
                      ] 
                    ) 
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 7,
                        left: 15,
                        right: 15
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.schedule.title,
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 22.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black
                            )
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10
                            ),
                            child: Text(
                              widget.schedule.description,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.normal,
                                letterSpacing: -0.2,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey
                              )
                            ),
                          )
                        ],
                      )
                    ), 
                  ),
                ]
              ),
              (widget.hideSpeaker != true)
              ?
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children:[
                            Avatar(
                              borderColor: Colors.transparent,
                              margin: EdgeInsets.only(left: 7),
                              avatar: widget.schedule.speaker.avatar,
                              width: 35,
                              height: 35
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, right: 15),
                              child: Text(
                                widget.schedule.speaker.name, 
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle( 
                                  fontSize: 17,  
                                  fontWeight: FontWeight.w600, 
                                  color: Colors.black
                                )
                              ),
                            ),
                          ]
                        )
                      ),
                      Container( 
                        width: 100,
                        padding: EdgeInsets.all(2.5),
                        height: 50,
                        child: Badge(
                          borderRadius: 40,
                          height: 40,
                          text: globalMessages[widget.schedule.status],
                          bgColor: statusColor[widget.schedule.status],
                          textColor: Colors.black,
                          fontWeight: FontWeight.bold,
                          size: 11
                        )
                      ),
                    ],
                  )
                )
              :
                SizedBox.shrink()
            ],
          ), 
        ),
      )
    );
  }
}