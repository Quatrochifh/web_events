import 'package:appweb3603/components/buttons/widget_button_badge.dart';
import 'package:appweb3603/components/buttons/widget_button_chiclete.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart'; 
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/objects/object_notification.dart';
import 'package:appweb3603/style.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers.dart'; 

class TemplateAppBar extends StatefulWidget{ 
  /*
    Usuário atual
  */
  final User user;

  /*
    Evento atual
  */
  final Event event;

  /*
    Exibir botão de voltar para página anterior?
  */
  final bool back;  

  /*
    Título
  */
  final String? title;

  /*
    Esconder icone do usuário
  */
  final bool hideUser;

  /*
    Esconder menu
  */
  final bool hideMenu;

  /*
    Cor de fundo
  */
  final Color? bgColor;

  /*
    Cor dos icones
  */
  final Color? iconColor;

  /*
    Sem borda? 
  */
  final bool? noBorder;


  final Widget? customButton;

  TemplateAppBar({
    Key? key,
    this.customButton,
    this.noBorder,
    required this.event,
    this.bgColor,
    this.iconColor,
    this.hideMenu = false,
    this.hideUser = false,
    required this.user,
    this.back = false,
    this.title
  }) : super(key: key);

  @override
  TemplateAppBarState createState() => new TemplateAppBarState();
}

class TemplateAppBarState extends State<TemplateAppBar> with AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;

  Color _iconColor   =  Colors.black.withOpacity(0.8); 

  int _countNotifications = 0;
  
  @override
  void initState(){
    super.initState(); 

    _iconColor = widget.iconColor ?? _iconColor;

    if(!widget.hideMenu){

      OBNotification obNotification = new OBNotification();

      //Quantidade de notificações para o evento
     obNotification.countNotViewed().then((results){
        if(!mounted) return;
        setState((){
          _countNotifications = results;
        });
      });
    }
  }
   

  @override 
  Widget build(BuildContext context) {  
    super.build(context);

    return Container(
        width: MediaQuery.of(context).size.width,
        height: templateHeaderHeigth + (MediaQuery.of(context).padding.top * 0.8),
        padding: EdgeInsets.only(
          left: 10,
          right: 10
        ),
        decoration: BoxDecoration(
        color: widget.bgColor ?? Colors.white,
        // boxShadow: widget.bgColor == null ? const [ ligthShadow ] : null,
        border: Border(
          bottom: BorderSide( 
            color: widget.bgColor == null ? bgWhiteBorderColor : Colors.transparent, 
            width: 0.5
          ),  
        ),
      ),
      child: SafeArea( 
        top: true, 
        bottom: false,
        child:  Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: 
            [ 
              widget.back != true ?
                PrimaryButton(
                  onClick: (){ 
                    Scaffold.of(context).openDrawer();
                  }, 
                  width: 28, 
                  height: 45,
                  marginRight: 9,
                  icon:  CupertinoIcons.bars, 
                  textColor: _iconColor, 
                  onlyIcon: true,
                  noBorder: true,
                  iconSize: 25,
                  padding: noPadding,
                  backgroundColor: Colors.transparent,
                )
              :
                SizedBox.shrink(), 
              (widget.back == true || widget.title != null) ?
                Expanded(  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (  
                        widget.back ? 
                          Container( 
                            color: Colors.transparent,
                            margin: EdgeInsets.only(right: 10),
                            width: 38,
                            height: 38,
                            child: ButtonChiclete(
                              bgColor: Colors.grey.withOpacity(0.1),
                              iconColor: Colors.black,
                              onClick: () {
                                if (mounted) Navigator.of(context).pop();
                              },
                              icon: CupertinoIcons.back, 
                            )
                          )  
                        : 
                          SizedBox.shrink()
                      ), 
                      ( widget.title != null ) ?
                        Expanded( 
                          flex: 5, 
                          child: Text( 
                            widget.title!.toUpperCase(), 
                            style: TextStyle( 
                              overflow: TextOverflow.ellipsis, 
                              fontWeight: FontWeight.bold, 
                              fontSize: 14, 
                              color: _iconColor
                            )
                          )
                        )
                      :
                        SizedBox.shrink(),
                    ],
                  )
                )
              :
                SizedBox.shrink(), 
              (widget.hideUser != true) ?  
                  Expanded(
                    child: Container(
                      height: 65,
                      child: ClipRRect(
                      child: CustomImage(
                          image: widget.event.logo,
                          fit: BoxFit.fitHeight
                        )
                      )
                    )
                  )
                : 
                  SizedBox.shrink()
              , 
              (!widget.hideMenu && widget.title == null) ?
                Container( 
                  width: 28,
                  child: ButtonBadge(
                    callback: (){ 
                      navigatorPushNamed(context, '/view-notifications');
                    },
                    size: 26, 
                    icon: CupertinoIcons.bell,
                    iconColor: _iconColor,
                    backColor: primaryColor,
                    textColor: Colors.white,
                    count: _countNotifications,
                    borderColor: Colors.white
                  ),
                )
              : 
                SizedBox.shrink(), 
              (widget.customButton != null) ? 
                widget.customButton!
              : 
                SizedBox.shrink(), 
            ] 
        ) 
      )
    );
  }

}


class AppBarAvatar extends StatefulWidget{
  
  final String avatar;

  final Color borderColor;

  AppBarAvatar( { Key? key, required this.borderColor, required this.avatar } ) : super( key : key );

  @override
  AppBarAvatarState createState() => AppBarAvatarState();

}

class AppBarAvatarState extends State<AppBarAvatar>{ 

  @override
  Widget build( BuildContext context ){  

    return Container( 
      width: 32, 
      height: 32,
      margin: EdgeInsets.only(left:15, right: 0),
      decoration: BoxDecoration( 
        border: Border.all(color: widget.borderColor, width: 0.5), 
        borderRadius: BorderRadius.circular(100),  
      ),  
      clipBehavior: Clip.antiAlias,
      child: 
        Container(    
          width: 45, 
          height: 45, 
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(100),  
          ),  
          clipBehavior: Clip.antiAlias,
          child: CustomImage( local: false, image: widget.avatar, defaultImage: "assets/images/default_avatar.png", fit: BoxFit.cover, height: 45, width: 45 ) 
        ),
    );
  }

}