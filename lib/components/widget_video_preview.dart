import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_list_item.dart';
import 'package:appweb3603/components/widget_text_icon.dart';
import 'package:appweb3603/entities/Transmission.dart';
import 'package:appweb3603/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class VideoPreview extends StatefulWidget{  

  final double? imageHeight;  

  final double? bottom;

  final double? top; 

  final bool? imageHttps;

  final Function onClick; 

  final Transmission transmission; 


  VideoPreview({Key? key, required this.transmission, this.imageHttps = true, required this.onClick, this.imageHeight, this.top, this.bottom}) : super(key: key);

  @override
  VideoPreviewState createState() => VideoPreviewState();
}

class VideoPreviewState extends State<VideoPreview> with AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;    

  @override 
  void initState(){ 
    super.initState(); 
  } 

  @override 
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      height: 170,
      margin: EdgeInsets.all(0),
      child: ListItem(
        padding: EdgeInsets.all(0),
        onClick: (){ 
          widget.onClick();
        },
        children: [ 
          Expanded( 
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.start,
              children: [ 
                Container(  
                  width: 120,
                  height: 170,
                  decoration: BoxDecoration( 
                    color: Colors.grey, 
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CustomImage( 
                    image: widget.transmission.thumbnail,
                    width: 170, 
                    height: 170,  
                    https: widget.imageHttps, 
                    fit: BoxFit.cover
                  ),
                ), 
                Expanded( 
                  child: Column( 
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ 
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          left: 10
                        ),
                        alignment: Alignment.topLeft,  
                        height: 45,
                        child: Text(
                          widget.transmission.title, 
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle( 
                            fontSize: 17.5, 
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 48, 48, 48)
                          )
                        )
                      ),
                      Container( 
                        padding: EdgeInsets.all(10),
                        height: 70,
                        alignment: Alignment.topLeft, 
                        child: Text(
                          widget.transmission.description, 
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle( 
                            fontSize: 13.5, 
                            fontWeight: FontWeight.w200,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black
                          )
                        )
                      ),
                      Container( 
                        padding: EdgeInsets.all(10),
                        child: Row( 
                          children: [ 
                            TextIcon(
                              icon: FontAwesomeIcons.clock,
                              text: widget.transmission.duration,
                              color: Colors.black54,
                              iconMargin: 5
                            ),
                            TextIcon(
                              iconMargin: 5,
                              icon: FontAwesomeIcons.calendar,
                              text: dateTimeFormat(widget.transmission.dateRegister.toString(), dateFormat: "dd/MM/yy"),
                              color: Colors.black54
                            ),
                          ] 
                        )
                      ),
                    ] 
                  )
                )
              ],
            )
          )
        ]
      )
    );
  }

}