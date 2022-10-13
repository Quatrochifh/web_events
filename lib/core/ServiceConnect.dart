 
import 'dart:convert';
import 'dart:core';
import 'dart:io'; 
import 'package:appweb3603/conf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 


Future serviceConnect(String action, String method, Map<String, dynamic> params) async {
  
  //Certificado para acesso sem HTTPS
  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
 
  http.Response? response;

  const Map<String, String> headers = {
    "content-type": "application/json"
  };

  Uri? url;

  if(serverHttps) {
    url = Uri.https(serverHost + (serverPort != null ? ":${serverPort.toString()}" : ''),  serverPath+action);
  }else{
    url = Uri.http(serverHost + (serverPort != null ? ":${serverPort.toString() }" : ''),  serverPath+action);
  }

  bool hasError = false;
  switch( method.toUpperCase() ){
    //Method POST
    case 'POST':
      try{
        response = await http.post( 
        url ,  
        body: params
      );
      }catch(e){ 
        hasError = true;
        debugPrint(e.toString());
      }
    break;
    case 'GET' :  
      Uri outgoingUri = new Uri(scheme: serverHttps ? 'https' : 'http',
          host: serverHost,
          port: serverPort,
          path: serverPath+action,
          queryParameters:params); 

      try{
        response = await http.get( 
          outgoingUri,
          headers: headers
        );  
      }catch(e){ 
        hasError = true;
        debugPrint(e.toString());
      }
    break;
  }

  if( hasError == true ){
    return;
  }
    
  try{ 
    if( response!.statusCode == 200 ){
      return jsonDecode(response.body);
    }  
  } catch (e) {
    return;
  }
  return null;
}
