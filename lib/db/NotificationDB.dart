import 'package:appweb3603/db/DB.dart';
import 'package:appweb3603/entities/Notification.dart' as notification_entity;
import 'package:flutter/material.dart';

/*
  Documentação
  https://pub.dev/packages/sqflite 
*/

class NotificationDB extends DB {

  // Fields seguros para fazer uma query dinamica
  static List<String> safeFields = [
    'title',
    'description',
    'dateRegister',
  //  'dateViewed'
  ];

  /*
   * Função para inserir uma nova notifição
  */
  Future<dynamic> insertNotification(notification_entity.Notification notification) async {

    dynamic database = await connect(); 

    if( database == null ){
      return null;
    }

    return await database.transaction((txn) async {
      return await txn.rawQuery(
        'INSERT INTO notification(title, description, routeName, routeValue, dateRegister) VALUES(?, ?, ?, ?, ?)', 
        [
          notification.title,
          notification.description,
          notification.routeName,
          notification.routeValue,
          notification.dateRegister
        ]
      );
    });  
  }

  /*
  * Atualizar dados da notificação
  */
  updateNotificationById(int id, notification_entity.Notification notification) async {
    dynamic database = await connect(); 

    if( database == null ){
      return null;
    }

    String queryValue = "";
    List<dynamic> queryValues = [];

    notification.toMap().forEach((key, val){
      if (safeFields.contains(key)) {
        queryValue += "${(queryValue.isNotEmpty) ? "," : ""} $key = ?";
        queryValues.add(val);
      }
    });

    return await database.transaction((txn) async {
      return await txn.rawQuery('UPDATE notification SET $queryValue WHERE id = $id', queryValues);
    });
  }


  /*
  * Setar determinada notificação como visualizada.
  */
  setNotificationsViewed(int id, {String? dateViewed}) async
  {
    dynamic database = await connect(); 

    if( database == null ){
      debugPrint("O \$_database é null!");
      return null;
    }

    await database.transaction((txn) async {
      return await txn.rawQuery('UPDATE notification SET viewed = ?, dateViewed = ? WHERE viewed IS NULL AND id = ?', [1, dateViewed, id] );
    });
  }

  /*
  * Agrupar notificações por routeName e data.
  * - Adicionando um limite!
  */
  agroupNotificationsByRouteNameAndDateTime({int limit = 100}) async
  {
    /*dynamic database = await connect(); 

    if( database == null ){
      debugPrint("O \$_database é null!");
      return null;
    }

    await database.transaction((txn) async {
      return await txn.rawQuery('UPDATE notification SET viewed = 1, dateViewed = ? WHERE viewed != 1', [dateViewed] );
    });*/
  }

  /*
   * Conta quantidade de notificações não visualizadas
  */
  Future<dynamic> countNotViewed() async{ 

    dynamic database = await connect(); 

    if(database == null){
      debugPrint("O \$_database é null!");
      return null;
    }

    List<Map> list = await database!.rawQuery('SELECT COUNT(id) AS total FROM notification WHERE viewed IS NULL');

    if (list.isEmpty) return 0;

    return list[0]['total'];
  }

  /*
    Função para contar todos os resultados.
  */
  Future<dynamic> count() async{ 

    dynamic database = await connect(); 

    if(database == null){
      debugPrint("O \$_database é null!");
      return null;
    }

    List<Map> list = await database!.rawQuery('SELECT COUNT(id) AS total FROM notification');

    return list;
  }

  /*
    Função para pegar todos os resultados.
  */
  Future<dynamic> getAll({int limit = 100}) async {

    dynamic database = await connect(); 

    if( database == null ){
      debugPrint("O \$_database é null!!!");
      return null;
    }

    List<Map> list = await database!.rawQuery('SELECT * FROM notification ORDER BY id DESC LIMIT $limit');
    List<notification_entity.Notification> notifications = [];

    if(list.isEmpty) return notifications;

    list.forEach((value){
      notification_entity.Notification notification = new notification_entity.Notification(
        title: value['title'] ?? "",
        description: value['description']?? "",
        dateRegister: value['dateRegister']?? "",
        dateViewed: value['dateViewed']?? "",
        routeName: value['routeName']?? "",
        routeValue: value['routeValue'] ?? "",
        viewed: value['viewed'] ?? 0,
        id: value['id'] ?? 0,
      );

      notifications.add(notification);
    });

    return notifications;
  }

  /*
    Função para pegar resultado para determinado ID
  */
  Future<dynamic> getById(int id) async{

    dynamic database = await connect(); 

    if( database == null ){
      debugPrint("O \$_database é null!!!");
      return null;
    }

    List<Map> list = await database!.rawQuery('SELECT * FROM notification WHERE id = $id');

    if (list.isEmpty) {
      return null;
    }

    notification_entity.Notification notification = new notification_entity.Notification(
      title: list[0]['title'] ?? "",
      description: list[0]['description'] ?? "",
      id: list[0]['id'] ?? "",
      dateRegister: list[0]['dateRegister'] ?? "",
      dateViewed: list[0]['dateViewed'] ?? "",
      linkUrl: list[0]['linkUrl'] ?? "",
      routeValue: list[0]['routeValue'] ?? "",
      routeName: list[0]['routeName'] ?? "",
    );
    
    return notification;
  }

}