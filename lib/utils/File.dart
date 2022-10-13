import 'dart:io';

import 'package:flutter/material.dart';

Future<bool?> localFileExists(String? localImage) async {
  if (localImage == null) {
    return Future.delayed(Duration(milliseconds: 10), () {
      return false;
    });
  }

  return await File(localImage).exists();
}

Future<dynamic> getFilePath(String? localImage) async {
  debugPrint("Checando se a imagem existe: $localImage");
  if (await localFileExists(localImage) == true) {
    return File(localImage!).path;
  }
}
