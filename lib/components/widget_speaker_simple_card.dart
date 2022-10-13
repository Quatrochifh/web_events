 
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/entities/Speaker.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart'; 

class SpeakerSimpleCard extends StatefulWidget{ 

  final Speaker speaker;

  final double? height;

  final EdgeInsets? margin;

  SpeakerSimpleCard({
    Key? key,
    this.margin,
    this.height,
    required this.speaker
  }) : super(key: key);

  @override
  SpeakerSimpleCardState createState() => SpeakerSimpleCardState();
}

class SpeakerSimpleCardState extends State<SpeakerSimpleCard>{

  @override
  void initState(){
    super.initState();

    if(!mounted) return;
  }

  @override 
  Widget build( BuildContext context ){
 
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        navigatorPushNamed(context, '/view-user', arguments: {'user' : widget.speaker});
      },
      child:  Container(
        height: widget.height,
        clipBehavior: Clip.antiAlias,
        margin: widget.margin ?? EdgeInsets.only(top: 6.5, left: 5, right: 5), 
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
          right: 15
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderMainRadius,
          border: Border.all(
            color: Colors.black.withOpacity(0.125),
            width: 0.3
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            Avatar(
              width: 65, 
              height: 65,
              borderRadius: 65,
              avatar: widget.speaker.avatar, 
              borderColor: Colors.black.withOpacity(0.1),
              onClick: (){ 
                navigatorPushNamed(context, '/view-user', arguments: {'user' : widget.speaker});
              }
            ), 
            Expanded( 
              child: Container(
                margin: EdgeInsets.only(
                  top: 3.5,
                  bottom: 5
                ),
                child: Row( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.speaker.name,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle( 
                                  fontSize: 22.4,
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: [ 
                                Text( 
                                  widget.speaker.role.isNotEmpty ? widget.speaker.role : "Cargo", 
                                  style: TextStyle(
                                    fontSize: 13, 
                                    color: Colors.grey, 
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text( 
                                  " em ", 
                                  style: TextStyle(
                                    fontSize: 13, 
                                    color: Colors.grey
                                  ),
                                ), 
                                Text( 
                                  widget.speaker.company.isNotEmpty ? widget.speaker.company : "Empresa", 
                                  style: TextStyle(
                                    fontSize: 14, 
                                    color: Colors.grey
                                  ),
                                )
                              ],
                            ),
                          ] 
                        ), 
                      ),
                    ),
                    PrimaryButton(
                      width: 120,
                      height: 35,
                      padding: noPadding,
                      backgroundColor: greyBtnMoreBackground,
                      textColor: greyBtnMoreTextColor,
                      onClick: (){
                        navigatorPushNamed(context, '/view-speaker-activities', arguments: {'speaker': widget.speaker});
                      },
                      borderRadius: 100,
                      iconSize: 16,
                      title: "Ver Agenda"
                    )
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }

}