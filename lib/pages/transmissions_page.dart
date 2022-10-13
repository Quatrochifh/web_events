import 'package:appweb3603/components/loader/widget_transmission_loader.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_message.dart';  
import 'package:appweb3603/components/widget_video_preview.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
 

class TransmissionsPage extends StatefulWidget{   

  TransmissionsPage({Key? key}) : super(key: key);

  @override
  TransmissionsPageState createState() => new TransmissionsPageState();
}


class TransmissionsPageState extends State<TransmissionsPage> with PageComponent, AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;
  List<VideoPreview>? _videosThumb;
  Controller controller         = Modular.get<Controller>();  


  @override 
  void initState(){ 
    super.initState();
    
    // Exibir loading
    showLoading(); 

    /*
      Vamos buscar pelo cronograma
    */
    Modular.get<Controller>().event.then((event){
      Modular.get<EventService>().eventTransmissions(event.id).then((results){
        hideLoading();
        if( results != null ){    
          _videosThumb = []; 
          for( int i = 0; i < results.length; i++ ){  
            _videosThumb!.add( 
              VideoPreview(   
                key: GlobalKey(),
                imageHeight: 290,
                imageHttps: false,  
                onClick:(){ 
                  navigatorPushNamed(context, '/view-transmission', arguments: { 'transmission' : results[i] } );
                }, 
                transmission: results[i]
              )
            );
          }

          setState((){
            _videosThumb = _videosThumb;
          });
        }else{
          hideLoading();
        }
      });  
    });
  }


  @override
  Widget build(BuildContext context){  
    super.build(context);

    return content(
      color: mainBackgroundColor,
      body:  <Widget>[  
        /*Container( 
          width: double.infinity,
          margin: EdgeInsets.only(top: 15, bottom: 15),
          padding: EdgeInsets.all(5),  
          alignment: Alignment.center, 
          child: SearchTransmissionForm( feedback:(){ }, cancelOnclick: (){ }, )
        ),*/
        Expanded( 
          child:
            _videosThumb != null && _videosThumb!.isNotEmpty
            ?
              ListView( 
                padding: EdgeInsets.all(0),
                children: _videosThumb!
              )
            :
              _videosThumb == null
              ?
                Column(
                  children: const [
                    TransmissionLoader(),
                    TransmissionLoader()
                  ],
                )
              :
                EmptyMessage(message: "Nenhum vídeo encontrado!")
        )
      ],
      drawer: NavDrawer(),
      header: TemplateAppBar( event: controller.currentEvent, back: true, hideUser: true, title: "Vídeos", user: controller.currentUser ),
    );
  }
}  
 