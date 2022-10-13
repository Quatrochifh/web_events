import 'package:appweb3603/components/widget_badge.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/entities/Announcement.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBanner extends StatefulWidget{ 

  final bool? inSlide;

  final bool? onlyBackground;

  final double? height;

  final Announcement announcement;

  final double? ratio;

  CustomBanner({Key? key, this.ratio, this.height, this.onlyBackground = false, required this.announcement, this.inSlide}) : super( key : key );

  @override
  StateCustomBanner createState() => StateCustomBanner();
}

class StateCustomBanner extends State<CustomBanner>{ 

  DecorationImage? _decorationBackgroundImage;

  @override
  void initState(){
    super.initState();

    if(!mounted) return;

    setState((){
      if(widget.announcement.backgroundImage.isNotEmpty){
        try{
          _decorationBackgroundImage =  DecorationImage(
            image: NetworkImage(widget.announcement.backgroundImage),
            fit: BoxFit.cover,
          );
        }catch(e) {
          debugPrint(e.toString());
        }
      }
    });

  }

  @override
  Widget build( BuildContext context ){
    return InkWell( 
      onTap: (){
        try{
          launch(widget.announcement.linkUrl);
        }catch( e ){
          debugPrint( e.toString() );
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: widget.onlyBackground == true ? _decorationBackgroundImage : null,
          borderRadius:  widget.inSlide == true ? BorderRadius.circular(3) : null,
          border: Border.all(
            width: 0.3,
            color: Colors.black.withOpacity(0.125),
          ),
          color: Colors.white
        ),
        width: widget.inSlide == true ? 300 : MediaQuery.of(context).size.width,
        height: widget.height ?? 300,
        margin: widget.inSlide == true ? EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 5
        ) : EdgeInsets.only(bottom: 7.5),
        child: Stack(
            children:[ 
              Row(
                children: [
                  (widget.onlyBackground != true)
                    ?
                      Stack(
                        children:[
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.125),
                                  width: 0.5
                                )
                              )
                            ),
                            child: CustomImage(
                              width: (MediaQuery.of(context).size.width * widget.ratio!) - 12,
                              image: widget.announcement.backgroundImage,
                              height: widget.height ?? 170,
                              fit: BoxFit.cover,
                            )
                          ),
                          /*Positioned(
                            left: 0,
                            bottom: 0,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.74,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200.withOpacity(0.125)
                                  ),
                                  child: Container(
                                  height: 30,
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      widget.announcement.title,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  )
                                )
                              )
                            )
                          )*/
                        ]
                      )
                    :
                      SizedBox.shrink()
                ]
              ),
              (widget.announcement.badge.isNotEmpty)
                ?
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Badge(text: widget.announcement.badge, textColor: Colors.white, bgColor: primaryColor, borderRadius: 100, size: 11.6, fontWeight: FontWeight.bold, opacity: 0.125),
                  )
                :
                  SizedBox.shrink()
            ]
      )
    )
    );
  }

}