 
import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/components/maps/widget_map_preview.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart'; 
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_box.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart'; 
import 'package:appweb3603/pages/page_component.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:appweb3603/bloc/Event.dart' as event_bloc;
class MapsPage extends StatefulWidget{  

  MapsPage({Key? key}) : super(key:key);

  @override
  MapsPageState createState() => new MapsPageState();
} 

class MapsPageState extends State<MapsPage> with PageComponent{

  List<MapPreview>? _maps;

  @override 
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this._loadMaps();
    });
  }

  /*
   * Carregar lista de mapas
  */
  void _loadMaps() {
    (event_bloc.Event()).eventRoomMaps().then((maps){
      _maps = [];
      if (maps != null) {
        for(int i = 0; i < maps.length; i++) {
          _maps!.add(
            MapPreview(
              map: maps[i]
            )
          );
        }
        setState((){
          _maps = _maps;
        });
      }
    }); 
  }

  @override
  

  @override
  Widget build(BuildContext context) {
    return content(
      color: mainBackgroundColor,
      body: <Widget>[
        (_maps != null && _maps!.isNotEmpty)
          ?
            Expanded(
              child: ListView(
                padding: noPadding,
                children: _maps!,
              )
            )
          :
          ( 
            (_maps == null) ?
              LoadingBlock()
            :
              EmptyBox(
                message: "Nenhum mapa encontrado."
              )
          ),
      ],
      drawer: NavDrawer(),
      header: TemplateAppBar(
        back: true,
        hideUser: true,
        user: globalDIContainer.get(User) as User,
        event: globalDIContainer.get(Event) as Event,
        title: "Mapas"
      )
    );
  } 
}