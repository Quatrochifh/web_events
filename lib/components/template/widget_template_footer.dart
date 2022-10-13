import 'package:appweb3603/components/form/widget_simple_button.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFooter extends StatefulWidget{ 

  final Color? color; 

  final bool? noShadow;

  AppFooter({Key? key, this.color, this.noShadow = false}) : super(key: key); 

  @override
  AppFooterState createState() => AppFooterState();
}

class AppFooterState extends State<AppFooter>{ 

  final GlobalKey<SimpleButtonState> _btnSchedules     = GlobalKey(); 
  final GlobalKey<SimpleButtonState> _btnHome          = GlobalKey(); 
  final GlobalKey<SimpleButtonState> _btnSpeakers      = GlobalKey(); 
  final GlobalKey<SimpleButtonState> _btnFeed          = GlobalKey(); 
  final GlobalKey<SimpleButtonState> _btnMore          = GlobalKey(); 

  Map<String, GlobalKey<SimpleButtonState>> btnsState = {}; 

  @override
  void initState(){ 
    super.initState();


    
    btnsState['/view-schedules']          = _btnSchedules;
    btnsState['/view-schedule-day']       = _btnSchedules;
    btnsState['/view-schedule']           = _btnSchedules;
    btnsState['/view-speaker-activities'] = _btnSchedules;
    btnsState['/view-speakers']           = _btnSpeakers;
    btnsState['/view-main']               = _btnHome;
    btnsState['/view-post']               = _btnFeed;
    btnsState['/view-feed']               = _btnFeed;
    btnsState['/view-home-feed']          = _btnFeed;
    btnsState['/view-conversation-rooms'] = _btnMore;
    btnsState['/view-conversation-room']  = _btnMore;
 

    /*
      Vamos destacar a rota atual
    */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentRoute = ModalRoute.of(context);

      if(currentRoute!=null){

        String currentRouteName = currentRoute.settings.name.toString();
        
        if(!mounted) return; 

        btnsState.forEach((k, v){ 
          if( k == currentRouteName && v.currentState != null ){ 
            v.currentState!.currentButton( true ); 
          } 
        });
        
      }
    }); 
   
  }

  @override
  Widget build(BuildContext context) {
  
    return Container( 
      margin: EdgeInsets.all(0),
      width: double.infinity, 
      height: templateFooterHeigth + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: widget.color ?? Colors.white,
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: bgWhiteBorderColor
          )
        )
      ),
      child: Container(   
          margin: EdgeInsets.all(0),  
          child:
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ 
                Expanded(
                  flex: 2,
                  child: SimpleButton( 
                    key: _btnHome,
                    title: "Home",  
                    icon: CupertinoIcons.home,  
                    iconSize: 27.5,
                    textSize: 9.5,
                    onClick: (){   
                      navigatorPushNamed(context, '/view-main');
                    }, 
                  ), 
                ), 
                Expanded(
                  flex: 2,
                  child: SimpleButton( 
                    key: _btnFeed,
                    title: "Feed",  
                    iconSize: 27.5,
                    textSize: 9.5,
                    icon: CupertinoIcons.square_on_square, 
                    onClick: () {   
                      navigatorPushNamed(context, '/view-home-feed');
                    }
                  ),  
                ),
                Expanded(
                  flex: 2,
                  child: SimpleButton( 
                    key: _btnSchedules,
                    title: "Agenda",  
                    iconSize: 27.5,
                    textSize: 9.5,
                    icon: CupertinoIcons.calendar_badge_plus, 
                    onClick: () {   
                      navigatorPushNamed(context, '/view-schedules');
                    }
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SimpleButton( 
                    key: _btnSpeakers,
                    title: "Palestrantes",  
                    icon: CupertinoIcons.person_2_square_stack,  
                    iconSize: 27.5,
                    textSize: 9.5,
                    onClick: () => { 
                      navigatorPushNamed(context, '/view-speakers')
                    }, 
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SimpleButton( 
                    key: _btnMore,
                    title: "Mensagens",  
                    icon: CupertinoIcons.chat_bubble_2,  
                    iconSize: 27.5,
                    textSize: 9.5,
                    onClick: () => { 
                      navigatorPushNamed(context, '/view-conversation-rooms')
                    }, 
                  ),
                ), 
              ]
            ),   
        ) 
    );
  }

}