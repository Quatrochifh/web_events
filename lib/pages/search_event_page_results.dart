import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/clippers/widget_clipper_topwave.dart';
import 'package:appweb3603/components/forms/sarch_event_form.dart';
import 'package:appweb3603/components/widget_event_preview.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/helpers.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchEventResults extends StatefulWidget {

  final String searchValue;

  SearchEventResults({
    Key? key,
    required this.searchValue
  }) : super(key: key);

  @override
  SearchEventResultsState createState() => new SearchEventResultsState();
} 

class SearchEventResultsState extends State<SearchEventResults> with PageComponent, AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;
  bool _resultsLoaded = false;
  List<Widget> _eventsWidgets = [];

  void _onSubmit(value) {   
    navigatorPushNamed(context, '/view-search-event-results', arguments: {'searchValue': value }, ignorePushName: true); 
  }

  Future _searchEvents(searchValue) {
    return Modular.get<EventService>().searchEvent(searchValue).then((events){ 
      setState((){
        _resultsLoaded = true;
      });
      if(events.runtimeType.toString() == 'List<Event>'){  
        for(int i = 0; i < events.length; i++){
          _eventsWidgets.add(
            EventPreview(
              event: events[i], 
              onClick: (){ 
                navigatorPushNamed(context, '/view-login', arguments: {'eventCode': events[i].code , 'eventName': events[i].title, 'eventLogo': events[i].logo, 'eventBackground': events[i].background  });
              }, 
            )
          );
        } 
        setState((){ 
          _eventsWidgets = _eventsWidgets;
        });
      }
    });
  }
 
  @override 
  void initState(){
    super.initState();  

    _searchEvents(widget.searchValue);
  } 

  @override
  Widget build(BuildContext context){ 
    super.build(context);

    return WillPopScope(
      onWillPop: () { 
        //Vamos bloquear a opção de "voltar"
        return Future.value(false); 
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: new GestureDetector(
          onTap: () { 
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(  
            decoration: BoxDecoration(
              color: Colors.white,
              image:  new DecorationImage(
                image: AssetImage('assets/images/background/search_event_page_background.png')
              ) 
            ),
            child: Container( 
              color: Colors.white,
              child: ListView(
                padding: noPadding,
                children: [
                  Container(  
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [  
                      (_resultsLoaded) 
                        ? 
                          Container( 
                            margin: EdgeInsets.all(0),
                            child: 
                              _eventsWidgets.isNotEmpty 
                              ?
                                ListView(
                                  padding:  EdgeInsets.only(top: 170),
                                  children: _eventsWidgets,
                                ) 
                              : 
                                Container(
                                  padding: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: Message(
                                    textAlign: TextAlign.center,
                                    textColor: Colors.grey,
                                    fontSize: 21,
                                    iconColor: Colors.grey,
                                    bgColor: Colors.transparent,
                                    text: "Nenhum evento encontrado."
                                  )
                                )
                          )
                        :
                          LoadingBlock(transparent: true,),
                        Positioned(
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170, 
                            child: 
                              ClipPath(
                                clipper: ClipperTopWave(),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: appPrimaryColor,
                                    image:  new DecorationImage(
                                      image: AssetImage('assets/images/background/search_event_page_background.png')
                                    ) 
                                  ),
                                  padding: EdgeInsets.only(left: 20, right: 20), 
                                  child: SafeArea(
                                    top: true, 
                                    child: Row(
                                      children:[  
                                        PrimaryButton(
                                          onClick: (){ 
                                            navigatorPushNamed(context, '/view-search-event');
                                          },
                                          marginRight: 5,
                                          width: 50, 
                                          height: 50, 
                                          icon: CupertinoIcons.back,  
                                          borderRadius: 100,
                                          fontSize: 22,
                                          onlyIcon: true,
                                          textColor: Color.fromRGBO(255, 255, 255, 0.45),
                                          backgroundColor: Colors.transparent
                                        ),
                                        Expanded(
                                          child: SearchEventForm(initialValue: widget.searchValue, feedback: _onSubmit, onlyBtnIcon: true,  cancelOnclick: (){ }, leftPosition: true)
                                        ) 
                                      ]
                                    )
                                  )
                                )
                              ),
                          ),
                        )
                      ],
                    ) 
                  )
                ]
              )
            )
          )
        )   
      )
    );
  }

}  