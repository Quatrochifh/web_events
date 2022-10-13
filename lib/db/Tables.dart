// Tabelas a serem criadas na primeira execução

import 'package:appweb3603/conf.dart';
import 'package:sqflite/sqflite.dart';

class Tables {

  /*
   * Pegamos o caminho do arquivo do Banco de Dados.
  */
  getPath() async {  
    /*
     * Vamos pegar a localização do arquivo SQLite (informado em conf.dart)
    */
    var databasesPath = await getDatabasesPath();

    String path = "$databasesPath/$dbName.db";
    
    return path;
  }

  registerTables() async {

    /*
      PATH do Banco de Dados
    */
    String path = await getPath(); 

    return await openDatabase(path, version: 1,
      onUpgrade: (Database db, int a, int b) async {
        // Tabela do usuário
        await db.execute(
          'CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, session_key TEXT)'
        );
        // Tabela da notificação
        await db.execute(
          'CREATE TABLE IF NOT EXISTS notification (id INTEGER PRIMARY KEY AUTOINCREMENT, dateRegister TEXT, viewed INT, dateViewed TEXT, title TEXT, description TEXT, routeValue TEXT, routeName TEXT)'
        );
        // Tabela de Contato
        await db.execute(
          'CREATE TABLE IF NOT EXISTS contact (id INTEGER PRIMARY KEY AUTOINCREMENT, dateRegister TEXT, name TEXT, email TEXT, telephone TEXT, userId INTEGER)'
        );
      },
      onCreate: (Database db, int a) async {
        // Tabela do usuário
        await db.execute(
          'CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, session_key TEXT)'
        );
        // Tabela da notificação
        await db.execute(
          'CREATE TABLE IF NOT EXISTS notification (id INTEGER PRIMARY KEY AUTOINCREMENT, dateRegister TEXT, viewed INT, dateViewed TEXT, title TEXT, description TEXT, routeValue TEXT, routeName TEXT)'
        );
        // Tabela de Contato
        await db.execute(
          'CREATE TABLE IF NOT EXISTS contact (id INTEGER PRIMARY KEY AUTOINCREMENT, dateRegister TEXT, name TEXT, email TEXT, telephone TEXT, userId INTEGER)'
        );
      }
    );
  }

  /*
   * Função para remover todo o banco de dados
  */
  Future<dynamic> deleteAllDataBase() async{ 

    /*
     * PATH do Banco de Dados
    */
    String path = await getPath(); 
    /*
      * Vamos limpar nossa base de dados.
    */ 
    return await deleteDatabase(path);   
  }
}