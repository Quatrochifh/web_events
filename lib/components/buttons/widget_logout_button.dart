import 'package:appweb3603/Init.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/core/Auth.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {

  const LogoutButton({Key? key}) : super(key: key);

  @override
  LogoutButtonState createState() => LogoutButtonState();
}


class LogoutButtonState extends State<LogoutButton> {

  void showAlertDialog(BuildContext context) {
    Widget okButton = PrimaryButton(
      onClick: (){
        showLoading();
        Auth auth = new Auth();
        auth.logout().then((r){
          Future.delayed(Duration(milliseconds: 300), (){
            hideLoading();
            Init.cleanControllerData();
            navigatorPushNamed(context, '/');
          });
        });
      },
      width: 120,
      height: 40,
      padding: noPadding,
      title:  "Sim, quero sair.",
      fontSize: 13
    );
    Widget cancelButton = PrimaryButton(
      onClick: (){
        Navigator.pop(context);
      }, 
      width: 100,
      height: 40,
      fontWeight: FontWeight.normal,
      padding: noPadding,
      title:  "Não quero",
      fontSize: 13,
      backgroundColor: Colors.transparent,
      textColor: cancelTextColor,
    );
    
    AlertDialog alert = AlertDialog(
      title: Text("Deseja sair do aplicativo?"),
      content: Text("Você poderá efetuar o login novamente a qualquer momento."),
      actions: [
        cancelButton,
        okButton
      ],
    ); 

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      title: "Sair",
      onClick: (){ showAlertDialog(context); },
      icon: CupertinoIcons.chevron_back,
      backgroundColor: Colors.grey.withOpacity(0.2),
      borderRadius: 50,
      noBorder: true,
      textColor: Colors.black.withOpacity(0.5),
      fontSize: 13.5,
      iconSize: 16,
      height: 35,
      padding: EdgeInsets.all(8.5), 
    );
  }

}