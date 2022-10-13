import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart'; 

class App extends StatelessWidget{ 

  App({Key? key}) : super(key:key);

  /*
    * A rota inicial deve ser em "/", pois nela esperamos os dados serem carregados da mmeória e atualizamos no componente enviada como injeção em widget_module.
  */
  @override
  Widget build( BuildContext context ){
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        toggleableActiveColor: primaryColor
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }

} 