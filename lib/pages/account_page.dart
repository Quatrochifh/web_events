import 'package:appweb3603/Init.dart';
import 'package:appweb3603/bloc/Account.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/forms/security_form.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_section.dart';
import 'package:appweb3603/core/Auth.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';  
import 'dart:core';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 
class AccountPage extends StatefulWidget{ 

  final String? startFeed;

  AccountPage({Key? key, this.startFeed}) : super(key: key);

  @override
  AccountPageState createState() => new AccountPageState();
} 

class AccountPageState extends State<AccountPage> with PageComponent {  
 
  final GlobalKey<SectionState>  _securityFormKey  = GlobalKey();

  User _currentUser = new User();

  @override 
  void initState(){ 
    super.initState();   
    if(!mounted) return;

    setState((){
      _currentUser = Modular.get<Controller>().currentUser;
      debugPrint(_currentUser.toString());
    });
  }

  Future<dynamic> _updatePasswordSubmit(String currentPassword, String newPassword){
    showLoading();
    return Modular.get<Account>().changePassword(currentPassword, newPassword).then((results) { 
      hideLoading();
      return results;
    });
  }

  Future<dynamic> _accountExclusionSubmit() async {
    hideAlert();
    showLoading();
    return Modular.get<Account>().accountExclusion().then((results) async { 
      hideLoading();

      if (results == true) {
        Auth auth = new Auth();
        await auth.logout().then((r) async {
          await Future.delayed(Duration(milliseconds: 300), (){
            hideLoading();
            Init.cleanControllerData();
            navigatorPushNamed(context, '/view-search-event');
          });
        });
      } else {
        showAlert(
          //icon: CupertinoIcons.exclamationmark_circle,
          message: results == null || results == false ?  "Houve uma falha ao solicitar exclusão da conta." : results,
          callback: () {
            hideAlert();
          }
        );
      }
      return results;
    });
  }
 

  @override
  Widget build(BuildContext context){    
 
    return content(
      body:  <Widget>[ 
        Expanded(
          child: Column(
            children: [
              PrimaryButton(
                onClick: (){ 
                  showFloatScreen(
                    title: "Alterar senha",
                    child: SecurityForm(
                      key: _securityFormKey,
                      feedback: _updatePasswordSubmit,
                      cancelOnclick: (){ }
                   )
                 );
                },
                title: "Alterar senha de acesso",
                width: MediaQuery.of(context).size.width,
                height: 50,
                textColor: Colors.black,
                backgroundColor: Colors.grey.withOpacity(0.125),
                borderRadius: 5,
                iconRight: true,
                icon: FontAwesomeIcons.circleChevronRight,
                iconMargin: EdgeInsets.only(left: 10, right: 10),
             ),
              PrimaryButton(
                onClick: () {
                  showAlert(
                    title: "Tem certeza em realizar esta ação?",
                    callback: _accountExclusionSubmit,
                    successTitle: "Sim",
                    cancelTitle: "Não",
                    cancelCallback: () {
                      hideAlert();
                    }
                  );
                },
                title: "Solicitar exclusão da conta",
                width: MediaQuery.of(context).size.width,
                height: 50,
                textColor: Colors.black,
                backgroundColor: Colors.grey.withOpacity(0.125),
                borderRadius: 5,
                iconRight: true,
                icon: FontAwesomeIcons.circleChevronRight,
                iconMargin: EdgeInsets.only(left: 10, right: 10),
             ),
              /* PrimaryButton(
                onClick: (){ 
                  showFloatScreen(title: "Alterar senha", child: SecurityForm(key: _securityFormKey, feedback: _formSubmit, cancelOnclick: (){ }));
                },
                title: "Histórico de Acesso",
                width: MediaQuery.of(context).size.width,
                height: 50,
                textColor: Colors.black,
                backgroundColor: Colors.grey.withOpacity(0.125),
                borderRadius: 5,
                iconRight: true,
                icon: FontAwesomeIcons.circleChevronRight,
                iconMargin: EdgeInsets.only(left: 10, right: 10),
             ),*/
            ],
         ) 
       ),  
      ],  
      drawer: NavDrawer(),
      header: TemplateAppBar(event: Modular.get<Controller>().currentEvent, back: true, hideMenu: true, hideUser: true, title: "Configurações de Conta", user: Modular.get<Controller>().currentUser),
   );  
  } 
}  