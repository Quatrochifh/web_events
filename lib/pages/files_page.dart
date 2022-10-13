import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Event.dart';
import 'package:appweb3603/components/loader/widget_document_loader.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_message.dart';
import 'package:appweb3603/components/widget_link.dart'; 
import 'package:appweb3603/core/Controller.dart'; 
import 'package:appweb3603/pages/page_component.dart'; 
import 'package:flutter/cupertino.dart'; 
import 'package:flutter_modular/flutter_modular.dart'; 
 
class FilesPage extends StatefulWidget{ 

  FilesPage({Key? key}) : super(key: key);

  @override
  FilesPageState createState() => new FilesPageState();
}

class FilesPageState extends State<FilesPage> with PageComponent { 
  
  Controller controller = Modular.get<Controller>();  

  List<Link>? _items; 
 
  @override 
  void initState(){
    super.initState();

    this._fetchFiles();
  }

  void _fetchFiles() {
    showLoading();
    (globalDIContainer.get(Event) as Event).documents().then((results){
      hideLoading();
      if(results.runtimeType.toString() == "List<Link>" ){  
        results.forEach((element){
          _items ??= [];
          _items!.add(
            Link( 
              icon: CupertinoIcons.doc,
              link:element
            )
          );
        });
      }
    });
  }

  @override 
  Widget build(BuildContext context){ 

    return content(
      body:  <Widget>[ 
        Expanded( 
          flex: 6, 
          child: ListView(
            padding: EdgeInsets.all(0),
            children:
              _items != null && _items!.isNotEmpty
              ?
                _items!
              :
              (
                  _items != null && _items!.isEmpty
                    ?
                      [ EmptyMessage() ]
                    :
                      [
                        DocumentLoader(),
                        DocumentLoader(),
                        DocumentLoader(),
                        DocumentLoader()
                      ]
              )
          )
        )
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar(
        back: true,
        title: "Documentos",
        hideUser: true,
        event: controller.currentEvent,
        hideMenu: true,
        user: controller.currentUser
      ) 
    );
  }
}  