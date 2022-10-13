import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_list_item.dart';
import 'package:appweb3603/components/widget_text_icon.dart';
import 'package:appweb3603/entities/Transmission.dart';
import 'package:appweb3603/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class VideoPreviewBlock extends StatefulWidget{  

  final double? imageHeight;  

  final double? bottom;

  final double? top; 

  final bool? imageHttps;

  final Function onClick; 

  final Transmission transmission; 


  VideoPreviewBlock({Key? key, required this.transmission, this.imageHttps = true, required this.onClick, this.imageHeight, this.top, this.bottom}) : super(key: key);

  @override
  VideoPreviewBlockState createState() => VideoPreviewBlockState();
}

class VideoPreviewBlockState extends State<VideoPreviewBlock> with AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;    

  @override 
  void initState(){ 
    super.initState(); 
  } 

  @override 
  Widget build( BuildContext context ){
    super.build( context );

    return Container(
      height: 350,
      margin: EdgeInsets.all(0),
      child: ListItem(
        shadow: true,
        padding: EdgeInsets.all(0),
        onClick: (){ 
          widget.onClick();
        },
        children: [ 
          Expanded( 
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.start,
              children: [ 
                Container(  
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: BoxDecoration( 
                    color: Colors.grey, 
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CustomImage( 
                    image: widget.transmission.thumbnail,
                    width: double.infinity, 
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
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.topLeft,  
                        height: 55,
                        child: Text(
                          widget.transmission.title, 
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle( 
                            fontSize: 22.5, 
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 48, 48, 48)
                          )
                        )
                      ),
                      Container( 
                        padding: EdgeInsets.all(10),
                        child: Row( 
                          children: [ 
                            TextIcon( icon: FontAwesomeIcons.clock, text: widget.transmission.duration, color: Colors.black54, ),
                            TextIcon( icon: FontAwesomeIcons.chartBar, text: widget.transmission.plays.toString(), color: Colors.black54,  ),
                            TextIcon( icon: FontAwesomeIcons.calendar, text: dateTimeFormat( widget.transmission.dateRegister.toString(), dateFormat: "dd/MM/yy"), color: Colors.black54,  ),
                          ] 
                        )
                      ),
                      Container(  
                        padding: EdgeInsets.all(10),
                        height: 60,
                        alignment: Alignment.topLeft, 
                        child: Text(
                          widget.transmission.description, 
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle( 
                            fontSize: 16.5, 
                            fontWeight: FontWeight.w200,
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 105, 105, 105)
                          )
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