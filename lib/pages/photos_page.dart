import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/loader/widget_photo_loader.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_message.dart';
import 'package:appweb3603/components/widget_photo_preview.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PhotosPage extends StatefulWidget{ 

  final String? startFeed;

  PhotosPage({Key? key, this.startFeed}) : super(key: key);

  @override
  PhotosPageState createState() => new PhotosPageState();
} 

class PhotosPageState extends State<PhotosPage> with PageComponent { 

  Controller controller  = Modular.get<Controller>();   

  List<Widget>? _photosWidgets;

  int currentPage = 0;

  bool _hideMoreButton = false;

  bool _isFeedPhotos = true;

  @override 
  void initState(){
    super.initState();    

    _feedPhotos();
  }

  void _oficialPhotos(){
    setState((){
      _photosWidgets = null;
      _isFeedPhotos = false;
      currentPage = 0;
    });
    _loadPhotos();
  }

  void _feedPhotos(){
    setState((){
      _photosWidgets = null;
      _isFeedPhotos = true;
      currentPage = 0;
    });
    _loadPhotos();
  }

  void _loadPhotos(){
    //Exibir o login
    showLoading();

    /*
      Vamos buscar pelos palestrantes e fotos do evento
    */
    Modular.get<Controller>().event.then((event){ 
      /*
        Buscar pelas fotos do evento
      */ 
      currentPage = currentPage + 1;

      Modular.get<EventService>().eventPhotos(event.id, currentPage : currentPage, oficial: !_isFeedPhotos).then((results){
       hideLoading();

        if(results != null && results.length > 0){   
          for(int i = 0; i < results.length; i++){
            _photosWidgets ??= [];
            _photosWidgets!.add(
              PhotoPreview(
                key: GlobalKey(),
                imageUrl: results[i].url,
                callback: (){ 
                  navigatorPushNamed(context, 'view-photo', arguments: { 'photo':  results[i] });
                }
             )
           ); 
          }  
          setState((){
            _photosWidgets = _photosWidgets;
          });
        }else{
          _hideMoreButton = true;
        }
      });
    });
     
  }

  @override
  Widget build(BuildContext context) { 

    /*
      Requer autenticação
    */
    controller.requireAuthentication(context);

    return content(
      color: Colors.white,
      body: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 246, 246),
          ),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white.withOpacity(0.0)
            ),
            height: 90,
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    borderRadius: 25,
                    onClick: (){
                      _feedPhotos();
                    },
                    title: "Fotos do Feed",
                    textColor: Colors.black.withOpacity(_isFeedPhotos == false ? 0.250 : 1),
                    onlyBorder: true,
                    noBorder: true,
                    icon: _isFeedPhotos == true ? CupertinoIcons.photo : CupertinoIcons.photo_fill,
                  ),
                ),
                Expanded(
                  child: PrimaryButton(
                    borderRadius: 25,
                    onClick: (){
                      _oficialPhotos();
                    },
                    title: "Fotos Oficiais",
                    textColor: Colors.black.withOpacity(_isFeedPhotos == true ? 0.250 : 1),
                    onlyBorder: true,
                    noBorder: true,
                    icon: _isFeedPhotos == true ? CupertinoIcons.photo : CupertinoIcons.photo_fill,
                  ),
                )
              ],
          )
          ),
        ),
        _photosWidgets != null && _photosWidgets!.isNotEmpty
          ? 
            Expanded(
              child:
                Column(
                  children: [
                    Expanded(
                      child: GridView(
                        padding: EdgeInsets.all(0),
                        addAutomaticKeepAlives: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3
                        ),
                        children: _photosWidgets! 
                          + <Widget>[ 
                              _hideMoreButton == false 
                              ? 
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.125)
                                  ),
                                  child: PrimaryButton(
                                    onClick: _loadPhotos,
                                    title: "Mais fotos",
                                    fontSize: 15,
                                    width: 160,
                                    height: 155,
                                    fontWeight: FontWeight.bold,
                                    noBorder: true,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black.withOpacity(0.8)
                                  ) 
                                )
                              :
                                SizedBox.shrink() 
                            ]
                      ), 
                    ),
                      
                  ] 
                )
            )
          :
            _photosWidgets != null && _photosWidgets!.isEmpty
              ?
                Expanded(
                  child: EmptyMessage(message: "Nenhuma foto na galeria")
                )
              :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: PhotoLoader()
                    ),
                    Expanded(
                      child: PhotoLoader()
                    ),
                    Expanded(
                      child: PhotoLoader()
                    )
                  ],
                ),
      ],
      drawer: NavDrawer(),
      header: TemplateAppBar(back: true, hideUser: true, event: controller.currentEvent, title: "Galeria", user: controller.currentUser)
   );
  } 
}  