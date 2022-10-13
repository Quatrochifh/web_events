 
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_footer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart'; 
import 'package:appweb3603/components/widget_custom_image.dart'; 
import 'package:appweb3603/components/widget_simple_section.dart';
import 'package:appweb3603/components/widget_slide.dart';
import 'package:appweb3603/components/widget_speaker_card.dart'; 
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Event.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart'; 

class EventPage extends StatefulWidget{  

  EventPage({Key? key}) : super(key: key);

  @override
  EventPageState createState() => new EventPageState();
} 

class EventPageState extends State<EventPage> with PageComponent{ 

  Controller controller  = Modular.get<Controller>();   

  List<SpeakerCard> _speakersCards = []; 

  ImageProvider decorationImageProvider = AssetImage('assets/images/loginbackground.png');

  Event? event;

  @override 
  void initState(){
    super.initState();    

    if (!mounted) return;

    setState((){
      event = controller.currentEvent;
    });

    if(  controller.currentEvent.background.isNotEmpty ){
      setState((){
        decorationImageProvider = NetworkImage(controller.currentEvent.background);
      }); 
    }

    /*
      Vamos buscar pelos palestrantes e fotos do evento
    */
    Modular.get<Controller>().event.then((event){
      /*
        Buscar pelos palestrantes do evento
      */
      Modular.get<EventService>().eventSpeakers( event.id ).then((results){
        
        if( results != null ){  
          for( int i = 0; i < results.length; i++ ){ 
            _speakersCards.add( 
              SpeakerCard( 
                key: GlobalKey(),
                speaker: results[i],
              )
            ); 
          }  
          setState((){
            _speakersCards = _speakersCards;
          });
        }
      });
    });
  }

  @override
  

  @override
  Widget build(BuildContext context){   
    // Requer autenticação
    controller.requireAuthentication(context);

    return WillPopScope(  
        onWillPop: (){  
          return Future.value(false); 
        },
        child: Scaffold( 
          drawer: NavDrawer(),
          resizeToAvoidBottomInset: true, 
          body: GestureDetector(
            onTap: (){ 
              FocusScope.of(context).requestFocus(FocusNode());
            }, 
            child: Container( 
              width: double.infinity, 
              height: double.infinity, 
              child: Container(  
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Column( 
                  children: [ 
                    Container( 
                      width: double.infinity, 
                      decoration: BoxDecoration( 
                        color: primaryColor,
                        image: DecorationImage( 
                          image: decorationImageProvider,
                          fit: BoxFit.cover,
                        ), 
                      ),
                      child: Container(
                        margin: EdgeInsets.all(0), 
                        child: Column( 
                          children: [ 
                            TemplateAppBar( noBorder: true,  back: true, hideUser: true,    bgColor: Colors.transparent, iconColor: Colors.white, event: controller.currentEvent, title: "Sobre o evento", user: controller.currentUser ),
                          ],
                        ) 
                      )  
                    ),
                    Expanded( 
                      child: ListView( 
                        children: [  
                          Container( 
                            alignment: Alignment.center,
                            child: Container(
                              width: 210, 
                              height: 80,
                              margin: EdgeInsets.only(bottom: 25), 
                              padding: EdgeInsets.all(5), 
                              alignment: Alignment.center,
                              decoration: BoxDecoration( 
                                color: Colors.white, 
                                border: Border.all(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.07))
                              ),
                              child: CustomImage(
                                  width: 210, 
                                  height: 80,
                                  fit: BoxFit.fill,
                                  image: controller.currentEvent.logo,
                                )
                            ), 
                          ),
                          SimpleSection(
                            title: "Sobre", 
                            margin: EdgeInsets.only( bottom: 25 ),
                            children:[ 
                              Container( 
                                margin: EdgeInsets.all( 10 ),
                                alignment: Alignment.bottomLeft,
                                child: Text( 
                                  event!.description ,
                                  softWrap: true, 
                                  maxLines: 14,  
                                  style: TextStyle( 
                                    fontSize: 22, 
                                    color: Colors.black, 
                                    fontWeight: FontWeight.w200, 
                                    overflow: TextOverflow.ellipsis
                                  )
                                )
                              )
                            ]
                          ),
                          SimpleSection(
                            title: "Palestrantes", 
                            children:[
                              _speakersCards.isEmpty 
                                ? 
                                  SizedBox.shrink() 
                                :
                                Slide(   
                                  height: 220,
                                  ratio: 2,
                                  children: _speakersCards
                                )
                            ]
                          )
                        ]
                      )   
                    ), 
                    AppFooter()  
                  ] 
                )
              )
            )
          )
        )
      );
      
  } 
}  