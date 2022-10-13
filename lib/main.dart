import 'package:appweb3603/widget_app.dart';
import 'package:appweb3603/widget_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
    Vamos evitar o moto horizontal
  */
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(ModularApp(
    /*
        Modulo onde teremos as rotas e as injeções de dependências
      */
    module: AppModule(),
    /*
        Widget inicial do nosso app
      */
    child: OverlaySupport.global(child: App()),
  ));
}
