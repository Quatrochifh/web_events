 
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_custom_image.dart'; 
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/EventPhoto.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';  
import 'package:flutter/material.dart';  
import 'package:flutter_modular/flutter_modular.dart'; 

class PhotoPage extends StatefulWidget{ 

  final EventPhoto photo;

  PhotoPage({Key? key, required this.photo}) : super(key : key);

  @override
  PhotoPageState createState() => new PhotoPageState();
} 

class PhotoPageState extends State<PhotoPage> with PageComponent{ 

  Controller controller  = Modular.get<Controller>();   

  @override 
  void initState(){
    super.initState();    
  }

  @override
  

  @override
  Widget build(BuildContext context) {

    return content(
      color: mainBackgroundColor,
      body:  <Widget>[ 
        Container( 
          margin: EdgeInsets.only(top: 15),
          width: double.infinity,
          padding: EdgeInsets.all(5), 
          height: 50,  
          alignment: Alignment.center,
          decoration: BoxDecoration(   
            border: Border(bottom: BorderSide(width: 0.7, color: Color.fromRGBO(0, 0, 0, 0.1) ))
          ),
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Expanded( 
                child: Row( 
                  children: [
                    Avatar(width: 32, height: 32, borderColor: Color.fromRGBO(0, 0, 0, 0.1), avatar: widget.photo.authorAvatarUrl, margin: EdgeInsets.only(right: 10 )),
                    Expanded( 
                      child: Text( widget.photo.authorName, maxLines: 1, softWrap: true, style: TextStyle( fontSize: 13, color: Colors.grey  ), ),
                    )
                  ]
                ),
              ),
              /*Container( 
                width: 165,
                child: PrimaryButton( onClick: (){ debugPrint( widget.photo.postID.toString() ); }, icon: CupertinoIcons.link, title: "Ver publicação", width: 110, height: 35, padding: noPadding ,)
              )*/
            ],
          ),  
        ),
        Expanded( 
          flex: 6, 
          child:  Container(  
            alignment: Alignment.center,
            child: CustomImage( image: widget.photo.url, width: double.infinity, height: 600, fit: BoxFit.contain )
          )
        ),  
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar( back: true, hideUser: true, event: controller.currentEvent, title: "Visualizando Foto", user: controller.currentUser )
    );   
 
  } 
}  