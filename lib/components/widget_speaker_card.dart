 
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/entities/Speaker.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class SpeakerCard extends StatefulWidget{ 

  final Speaker speaker;

  final double? height;

  final EdgeInsets? margin;

  SpeakerCard({
    Key? key,
    this.margin,
    this.height = 300,
    required this.speaker
  }) : super(key: key);

  @override
  SpeakerCardState createState() => SpeakerCardState();
}

class SpeakerCardState extends State<SpeakerCard>{

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
        navigatorPushNamed(context, '/view-user', arguments: { 'user' : widget.speaker });
      },
      child:  Container(
        padding: EdgeInsets.all(15),
        width: 200,
        height: widget.height,
        clipBehavior: Clip.antiAlias,
        margin: widget.margin ?? EdgeInsets.all(6.5), 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderMainRadius,
          border: Border.all(
            color: Colors.black.withOpacity(0.125),
            width: 0.3
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            Avatar(
              width: 70, 
              height: 70,
              borderRadius: 100,
              avatar: widget.speaker.avatar, 
              borderColor: Colors.black.withOpacity(0.1),
              onClick: (){ 
                navigatorPushNamed(context, '/view-user', arguments: {'user' : widget.speaker});
              }
            ), 
            Expanded( 
              child: Container(
              margin: EdgeInsets.only(top: 3.5),
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.speaker.name,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle( 
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold, 
                              color: Colors.black87,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text( 
                              widget.speaker.role.isNotEmpty ? widget.speaker.role : "Cargo",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 15, 
                                color: Colors.grey, 
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                            Text( 
                              " em ",
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey
                              ),
                            ), 
                            Text( 
                              widget.speaker.company.isNotEmpty ? widget.speaker.company : "Empresa",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis
                              ),
                            )
                          ],
                        )
                      ] 
                    ), 
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