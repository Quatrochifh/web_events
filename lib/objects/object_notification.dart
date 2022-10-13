import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/db/NotificationDB.dart';
import 'package:appweb3603/entities/Conversation.dart';
import 'package:appweb3603/entities/Notification.dart' as notification_entity;
import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class OBNotification {

  OBNotification();

  NotificationDB _notificationDB = globalDIContainer.get(NotificationDB) as NotificationDB;

  /*
   * Vamos registrar a notificação na base
  */
  void registerNotification(notification_entity.Notification notification) {

    /*
     * Irá inserir na base as notificações recebidas
    */
    notification.dateRegister = getCurrentDateTime();
    _notificationDB.insertNotification(notification);
  }

  /*
   * Irá setar a notificação como visualizada
  */
  void setNotificationViewed(int notificationId) async {
    _notificationDB.setNotificationsViewed(notificationId, dateViewed: getCurrentDateTime());
  }

  Future<void> handleMessage(notification_entity.Notification notification, dynamic context) async {

    // Vamos setar a notificação como visualizada (se ela já estiver visualizada, ignoramos)
    if (notification.viewed != 1) {
      setNotificationViewed(notification.id);
    }

    switch(notification.routeName){
      // Se for um link para uma live
      case 'view-live-url':
        launch(notification.routeValue);
      break;
      case 'view-transmission':
        navigatorPushNamed(context, '/view-transmissions', arguments: notification.routeValue);
      break;
      case 'view-conversation':
        navigatorPushNamed(
          context, '/view-conversation-room',
            arguments: {
              'conversation' : Conversation(
                receiverID: int.parse(notification.routeValue),
              )
          }
        );
      break;
      case 'view-post':
        navigatorPushNamed(
          context, '/view-post',
            arguments: {
              'post' : Post(
                id: int.parse(notification.routeValue),
              )
          }
        );
      break;
      default:
      break;
    }
  }

  void displayNotification(notification_entity.Notification notification) {
    registerNotification(notification);

    showSimpleNotification(
      Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          notification.title,
          maxLines: 1,
          style: TextStyle( 
            fontSize: 15.6,
            fontWeight: FontWeight.bold, 
            overflow: TextOverflow.ellipsis
          )
        ),
      ),
      duration: Duration( 
        seconds: 6
      ),
      elevation: 0,
      autoDismiss: true,
      subtitle: Text(
        notification.description,
        maxLines: 2,
        style: TextStyle( 
          fontSize: 13.6,
          color: Colors.white.withOpacity(0.750),
          overflow: TextOverflow.ellipsis
        )
      ),  
      background: Colors.black.withOpacity(0.9),
      trailing: Builder(builder: (context) {
        return Column(
          children: [
            (notification.routeName == 'view-live-url' || notification.routeName == 'view-transmission')
              ?
                PrimaryButton(
                  width: 115,
                  height: 35, 
                  padding: noPadding,
                  borderRadius: 100,
                  textColor: Colors.white,
                  onClick: () {
                    //handleMessage(_notification!);
                  },
                  iconRight: true,
                  icon: CupertinoIcons.chevron_right,
                  title: "Acessar",
                )
              :
                SizedBox.shrink()
          ]
        );
      }),
    );
  }


  /*
   *
   * Efetua uma busca por todas as notificações salvas na base.
   *
  */
  Future<List<notification_entity.Notification>> getAllNotifications() async{

    /*
    * Buscar na base pelas notificações registradas
    */
    return await _notificationDB.getAll().then((results){
      return results ?? <notification_entity.Notification>[];
    });
  }

  /*
   *
   * Conta a quantidadde de notificações não visualizadas
   *
  */
  Future<int> countNotViewed() async{

    /*
    * Buscar na base pelas notificações registradas
    */
    return await _notificationDB.countNotViewed().then((results){
      return results;
    });
  }

}