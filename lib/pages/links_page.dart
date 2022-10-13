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

// Organizado | 23/jun/2022
class LinksPage extends StatefulWidget{ 

  LinksPage({Key? key}) : super(key: key);

  @override
  LinksPageState createState() => new LinksPageState();
}

class LinksPageState extends State<LinksPage> with PageComponent {

  List<Link>? _items;

  Controller _controller = (globalDIContainer.get(Controller) as Controller);
 
  @override 
  void initState(){
    super.initState();

    this._fetchLinks();
  }

  void _fetchLinks() {
    showLoading();
    (globalDIContainer.get(Event) as Event).links().then((results){
      hideLoading();
      results.forEach((element){
        _items ??= [];
        _items!.add(
          Link( 
            icon: CupertinoIcons.link,
            link:element
          )
        );
      });

      setState((){
        _items = _items;
      });
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
      header: TemplateAppBar( back: true, title: "Links Úteis", hideUser: true, event: _controller.currentEvent, hideMenu: true, user: _controller.currentUser ) 
    );   
     
  }
} 
 