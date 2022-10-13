import 'package:appweb3603/conf.dart';
import 'package:appweb3603/utils/CustomCacheManager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CacheImage {

  ///
  /// Efetua o download/cacheamento da imagem
  ///
  static Future download(String url) async {
    CacheImage.fetch(url).then((results) async {
      if (results == null || results.isEmpty) {
        dynamic urlAttachment;
        dynamic file = url.split('/')[url.split('/').length-1];
        dynamic path = url.split('/')[url.split('/').length-2];
        if(serverHttps) {
          urlAttachment = Uri.https(serverHost + (serverPort != null ? ":${serverPort.toString()}" : ''), "uploads/$path/$file");
        }else{
          urlAttachment = Uri.http(serverHost + (serverPort != null ? ":${serverPort.toString() }" : ''),"uploads/$path/$file");
        }
        try {
          dynamic response = await http.get(urlAttachment);

          if (response.statusCode != 200) {
            debugPrint("A url $urlAttachment não existe mais. Code ${response.statusCode}");
            return;
          }

          debugPrint("Salvando imagem da url $url.");
          await CustomCacheManager().downloadFile(url);
        } catch(e) {
          debugPrint("CacheImage Exception .:");
          debugPrint(e.toString());
        }
      }
    });
  }

  ///
  /// Busca pelo download/cacheamento da imagem
  ///
  static Future fetch(String? url) async {
    var fetchedFile = await CustomCacheManager().getFileFromCache(url!);
    if (fetchedFile == null || await fetchedFile.file.exists() != true) {
      return "";
    }
    return fetchedFile.file.path;
  }

}