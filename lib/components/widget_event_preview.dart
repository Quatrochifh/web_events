import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:flutter/material.dart';

class EventPreview extends StatefulWidget{ 

  final Function onClick;

  final Event event;

  final bool? hideInfo;

  EventPreview({Key? key, this.hideInfo = false, required this.onClick, required this.event}) : super(key : key); 

  @override
  EventPreviewState createState() => EventPreviewState();
}

class EventPreviewState extends State<EventPreview>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build( BuildContext context ){
    return InkWell(
      onTap: (){
        widget.onClick();
      },
      child:  Container( 
        width: double.infinity, 
        height: 140, 
        margin: EdgeInsets.all(6.5), 
        decoration: BoxDecoration( 
          color: Colors.white,
          border: Border.all(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.08)),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: [
            _EventPreviewPhoto(
              image: widget.event.logo
            ),
            Expanded( 
              child: _EventPreviewDetails(event: widget.event, hideInfo: widget.hideInfo)
            )
          ],
        ), 
        clipBehavior: Clip.antiAlias,
      )
    );
  }
}


class _EventPreviewPhoto extends StatelessWidget{ 

  final String image;

  _EventPreviewPhoto( { Key? key, required this.image } ) : super( key : key );


  @override
  Widget build(BuildContext context){
 
    return Container(
      color: Colors.grey.withOpacity(0.25),
      padding: EdgeInsets.all(12.5),
      width: 120,
      height: 190,
      alignment: Alignment.center,
      child: CustomImage(
        image: image,
        width: 120,
        height: 80,
        fit: BoxFit.contain
      )
    );
  }

}

class _EventPreviewDetails extends StatelessWidget{ 

  final Event event;

  final bool? hideInfo;

  _EventPreviewDetails({Key? key, this.hideInfo = false, required this.event}) : super(key : key);


  @override
  Widget build( BuildContext context ){
 
    return Container(    
      decoration: BoxDecoration( 
        color: Colors.white
      ),
      padding: EdgeInsets.all(12.5),
      margin: EdgeInsets.only(left: 10),
      child: Stack(
        children:[ 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                event.title ,  
                maxLines: 2,
                softWrap: true,
                style: TextStyle( 
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 10),
                child: Text(
                  event.description,  
                  maxLines: 3,
                  softWrap: true,
                  style: TextStyle( 
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  )
                )
              ),
              (hideInfo != true && 2 > 4)
              ?
                Details(
                  marginBottom: 0,
                  inline: true,
                  items: {
                    "Inicio" : event.startDatetime,
                    "Término" : event.endDatetime,
                  }
                )
              :
                SizedBox.shrink()
            ]
          ),
        ]
      )
    );
  }

}