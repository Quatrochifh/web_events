import 'package:appweb3603/utils/Permissions.dart';
import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PermissionPage extends StatefulWidget {
  
  const PermissionPage({Key? key}) : super(key: key);

  @override
  PermissionPageState createState() => PermissionPageState();

}

class PermissionPageState extends State<PermissionPage> {

  Map<String, bool> permissions = {};

  @override
  void initState() {
    super.initState();
    Permissions.checkNotificationPermission().then((results){
      setState((){ 
        permissions['notification'] = results;
      });
    });

    Permissions.checkContactPermission().then((results){
      setState((){ 
        permissions['contact'] = results;
      });
    });

    Permissions.checkGalleryPermission().then((results){
      setState((){ 
        permissions['gallery'] = results;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Message(
            text: "Você pode alterar as permissões nas configurações do seu dispositivo.",
            bgColor: infoColor,
            borderRadius: 0,
            textColor: infoDarkColor,
            margin: EdgeInsets.only(bottom: 30),
            icon: FontAwesomeIcons.info,
            iconColor: infoDarkColor,
          ),
          (permissions.isEmpty)
            ?
              SizedBox.shrink()
            :
            Details(
              titleColor: Colors.black,
              titleSize: 16,
              descriptionColor: Colors.black,
              descriptionSize: 14,
              items: {
                "Acesso à Lista de Contatos" : permissions['contact'] == true ? 'Sim' : 'Não',
                "Acesso à Galeria" : permissions['gallery'] == true ? 'Sim' : 'Não',
                "Notificações Ativas" : permissions['notification'] == true ? 'Sim' : 'Não'
              }
            )
        ]
      )
    );
  }

}