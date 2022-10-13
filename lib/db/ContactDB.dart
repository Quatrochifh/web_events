import 'package:appweb3603/db/DB.dart';
import 'package:appweb3603/entities/Contact.dart' as contact_entity;
import 'package:flutter/material.dart';

/*
  Documentação
  https://pub.dev/packages/sqflite 
*/

class ContactDB extends DB {

  // Fields seguros para fazer uma query dinamica
  static List<String> safeFields = [
    'name',
    'email',
    'telephone',
    'userId',
    'dateRegister'
  ];

  /*
   * Função para inserir um novo contato
  */
  Future<dynamic> insertContact(contact_entity.Contact contact) async {

    dynamic database = await connect(); 

    if( database == null ){
      return null;
    }

    return await database.transaction((txn) async {
      return await txn.rawQuery(
        'INSERT INTO contact(name, email, userId, telephone, dateRegister) VALUES(?, ?, ?, ?, ?)', 
        [
          contact.name,
          contact.email,
          contact.userId,
          contact.telephone,
          contact.dateRegister
        ]
      );
    });
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

    List<Map> list = await database!.rawQuery('SELECT * FROM contact ORDER BY id DESC LIMIT $limit');

    List<contact_entity.Contact> contacts = [];

    if(list.isEmpty) return contacts;

    list.forEach((value){
      contact_entity.Contact contact = new contact_entity.Contact(
        name: value['name'] ?? "",
        email: value['email']?? "",
        dateRegister: value['dateRegister']?? "",
        id: value['id'] ?? 0,
        userId: value['userId'] ?? 0,
      );
      contacts.add(contact);
    });

    return contacts;
  }

  /*
    Função para pegar resultado para determinado userId
  */
  Future<dynamic> getByUserId(int userId) async{ 

    dynamic database = await connect(); 

    if( database == null ){
      debugPrint("O \$_database é null!!!");
      return null;
    }

    List<Map> list = await database!.rawQuery('SELECT * FROM contact WHERE userId = $userId');

    if (list.isEmpty) {
      return null;
    }

    contact_entity.Contact contact = new contact_entity.Contact(
        name: list[0]['name'] ?? "",
        email: list[0]['email']?? "",
        dateRegister: list[0]['dateRegister']?? "",
        id: list[0]['id'] ?? 0,
        userId: list[0]['userId'] ?? 0,
      );
    
    return contact;
  }
}