import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_message.dart';
import 'package:appweb3603/components/widget_text_icon.dart'; 
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/objects/object_notification.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:appweb3603/entities/Notification.dart' as enotification;
 
class NotificationsPage extends StatefulWidget{ 

  NotificationsPage({Key? key}) : super(key: key);

  @override
  NotificationsPageState createState() => new NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> with PageComponent { 
  
  Controller controller = Modular.get<Controller>();  

  List<NotificationMessage> _notificationItems = [];

  OBNotification obNotification = new OBNotification();

  bool refresh = false;

  dynamic currentContext;

  @override 
  void initState(){
    super.initState();

    // Exibir loading
    showLoading();

    // Efetua uma busca por todas as notificações
    obNotification.getAllNotifications().then((results){
      // Esconder o loading
      hideLoading();
      for( int i = 0; i < results.length; i++ ){
        _notificationItems.add( 
          NotificationMessage( 
            key: GlobalKey(),
            openMessage: (){
              obNotification.handleMessage(results[i], context);
            },
            notification: results[i]
          )
        );
        setState((){
          _notificationItems = _notificationItems;
        });
      }
    });
  }
  
  @override
  

  @override 
  Widget build(BuildContext context){ 

    return content(
      color: mainBackgroundColor,
      body:  <Widget>[ 
        Expanded( 
          flex: 6, 
          child: ListView(
            padding: EdgeInsets.all(0),
            children: 
              _notificationItems.isEmpty 
                ? [ EmptyMessage() ] 
              : _notificationItems
          )
        )
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar(
        back: true,
        title: "Notificações",
        hideUser: true,
        event: controller.currentEvent,
        hideMenu: true,
        user: controller.currentUser
      )
    );   
     
  }
}

 
 
class NotificationMessage extends StatelessWidget{ 

  final Function openMessage;

  final enotification.Notification notification; 

  NotificationMessage({Key? key, required this.openMessage, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context){ 
    return InkWell(
      key: GlobalKey(),
      onTap: () async { 
        openMessage();
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: 75,  
        ),
        margin: EdgeInsets.only(
          left: 5,
          top: 5,
          right: 5
        ),
        decoration: BoxDecoration( 
          color: notification.viewed == 1
            ? 
              Colors.white
            :
              Colors.white, 
          border: Border.all(
            width: 0.4,
            color: Color.fromRGBO(0, 0, 0, 0.1)
          ),
          borderRadius: borderMainRadius
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children:[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 35,
                    margin: EdgeInsets.only(
                      left: 5,
                      top: 5,
                      right: 10
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.125)
                      ),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: FaIcon(
                      (
                        (notification.routeName == 'view-live-url') 
                          ? FontAwesomeIcons.youtube
                        : (
                          (notification.routeName == 'view-conversation') ?
                            FontAwesomeIcons.comments
                          :
                            (
                              (notification.routeName == 'view-post') ? 
                                  FontAwesomeIcons.pen
                                :
                              FontAwesomeIcons.bell
                            )
                        )
                      ),
                      size: 16.2,
                      color: Colors.white
                    )
                  ),
                  Expanded(  
                    child: Container(  
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        right: 5
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal
                              ),
                              maxLines: 1,
                            ), 
                          ),
                          SizedBox(
                            child: Text(
                              notification.description,
                              style: TextStyle( fontSize: 14, color: Colors.grey, overflow: TextOverflow.ellipsis ),
                              maxLines: 1,
                            ), 
                          ),
                        ],
                      )
                    )
                  ),
                  /*
                  (notification.routeName == 'view-live-url')
                    ?
                      Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey
                        ),
                        child: FaIcon(
                          CupertinoIcons.chevron_right,
                          color: Colors.grey
                        )
                      )
                    :
                      SizedBox.shrink(),
                  (notification.routeName == 'view-conversation')
                    ?
                      Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey
                        ),
                        child: FaIcon(
                          CupertinoIcons.chat_bubble_2,
                          color: Colors.grey.withOpacity(0.35)
                        )
                      )
                    :
                      SizedBox.shrink(),
                  (notification.routeName == 'view-post')
                    ?
                      Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey
                        ),
                        child: FaIcon(
                          CupertinoIcons.pen,
                          color: Colors.grey.withOpacity(0.35)
                        )
                      )
                    :
                      SizedBox.shrink()
                    */
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                left: 15,
                right: 15
              ),
              margin: EdgeInsets.only(
                top: 6.5,
                bottom: 5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  (notification.viewed == 1)
                    ?
                      TextIcon(
                        text: "Visualizado",
                        icon: FontAwesomeIcons.checkDouble,
                        iconMargin: 5,
                        color: Colors.grey,
                        size: 12,
                        iconColor: primaryColor,
                      )
                    :
                      SizedBox.shrink(),
                    Text(
                      dateTimeFormat(
                        notification.dateRegister,
                        dateFormat: "HH:mm dd/MM"
                      ),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.6,
                      )
                    ),
                ]
              )
            ),
          ]
        )
      ),
    );
  }

}