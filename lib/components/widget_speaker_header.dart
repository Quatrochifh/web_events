 
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/entities/Speaker.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class SpeakerHeader extends StatefulWidget{ 

  final Speaker speaker;

  final double? height;

  final EdgeInsets? margin;

  final bool? noShadow;

  SpeakerHeader({Key? key, this.noShadow, this.margin, this.height = 300, required this.speaker}) : super( key : key );

  @override
  SpeakerHeaderState createState() => SpeakerHeaderState();
}

class SpeakerHeaderState extends State<SpeakerHeader>{

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
        navigatorPushNamed(
          context, '/view-user',
          arguments: {
            'user': widget.speaker}
          );
      },
      child:  Container(
        padding: EdgeInsets.all(7.5),
        width: MediaQuery.of(context).size.width,
        height: 110,
        clipBehavior: Clip.antiAlias,
        margin: widget.margin ?? EdgeInsets.all(6.5), 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderMainRadius,
          boxShadow: widget.noShadow != true ? const [ligthShadow] : null
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Avatar(
              width: 85, 
              height: 85,
              borderRadius: 100,
              avatar: widget.speaker.avatar, 
              borderColor: Colors.transparent,
              onClick: (){ 
                navigatorPushNamed(context, '/view-user', arguments: { 'user' : widget.speaker });
              }
            ), 
            Expanded( 
              child: Container(
                margin: EdgeInsets.only(top: 3.5, left: 10),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Container(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 7.5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Palestrante',
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle( 
                                fontSize: 12.5,
                                fontWeight: FontWeight.w100, 
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
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