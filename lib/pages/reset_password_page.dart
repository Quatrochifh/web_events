import 'dart:async';

import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/forms/code_form.dart';
import 'package:appweb3603/components/forms/reset_password_step_email.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/messages.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/UserService.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart';

import '../components/forms/reset_password_step_change_password.dart';


class ResetPassword extends StatefulWidget{

  ResetPassword({ Key? key }) : super(key : key);

  @override
  ResetPasswordState createState() => new ResetPasswordState();
} 

class ResetPasswordState extends State<ResetPassword> with PageComponent { 

  Timer? _timer;

  int _step = 1;

  String? _resetCode;
  String? _resetToken;

  final List<String> _titles = [ 
     "Recuperar Senha",
     "Código de Recuperação",
     "Nova senha",
  ];

  final List<String> _subtitles = [ 
     "Insira um e-mail cadastrado para poder recuperar seu acesso.",
     "Insira o código de recuperação de senha nos campos abaixo.",
     "Insira uma nova senha.",
  ];

  @override
  void initState(){
    super.initState();

    if(!mounted) return;

    setState((){
      _step = 1;
    });

    /*
      Verificamos se o usuário se encontra logado
    */
    Modular.get<Controller>().auth.hasConnected().then((results) {  
      if(results == true) { 
        /*
          Se o usuário estiver logado, rediretionamos para a rota /view-home 
        */
        Modular.to.navigate('/view-home');
      }
    });
  }


  /*
    * Efetuar a recuperação para uma senha através do e-mail
    * @Param (string) email
    * @Param (string) password
  */
  Future _formResetEmailSubmit(email, { String? error }){ 
    showLoading(); 
    UserService userService = Modular.get<UserService>();
    
    return userService.recoverPassword(email).then((results) {
      hideLoading();
      if (results == null) {
        registerNotification(message: globalMessages["NO_RESULTS"], type: 'warning');
      } else {
        //Sucesso ao efetuar a recuperação da senha
        if (results.runtimeType.toString() == '_InternalLinkedHashMap<String, dynamic>') {
          
          _resetToken = results['message']['token'];

          registerNotification(message: globalMessages["EMAIL_RECOVER_SENDED"], type: 'success');
          setState((){
            _step = 2;
          });
        } else { 
          //Erro ao efetuar a recuperação da senha
          if (results.runtimeType.toString() == 'String') {
            registerNotification(message: results, type: 'warning');
          }
        }
      }
    });
  }


  /*
    * Efetuar a recuperação para uma senha através do e-mail
    * @Param (string) email
    * @Param (string) password
  */
  Future _formResetPasswordSubmit(String password, String confirmPassword, { String? error }){
    showLoading(); 
    UserService userService = Modular.get<UserService>();
    
    return userService.resetPassword(password, _resetCode ?? "", _resetToken ?? "").then((results) {
      hideLoading();
      if (results == null) {
        registerNotification(message: globalMessages["NO_RESULTS"], type: 'warning');
      } else {
        //Sucesso ao efetuar a recuperação da senha
        if (results.runtimeType.toString() == '_InternalLinkedHashMap<String, dynamic>') {
          registerNotification(message: globalMessages["PASSWORD_CHANGED"], type: 'success');
          
          navigatorPushNamed(context, '/');
        } else { 
          //Erro ao efetuar a recuperação da senha
          if (results.runtimeType.toString() == 'String') {
            registerNotification(message: results, type: 'warning');
          }
        }
      }
    });
  }

  /*
    * Checar se o código bate
    * @Param (string) code
  */
  Future _formResetCodeSubmit(String code){

    _resetCode = code;

    setState((){
      _step = 3;
    });

    return Future.delayed(Duration(seconds: 1), (){ });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> containers = [
      Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 50),
        child: ResetPasswordEmailForm(feedback: _formResetEmailSubmit, cancelOnclick:(){ })
      ),
      Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 50),
        child: CodeForm(feedback: _formResetCodeSubmit, cancelOnclick:(){ })
      ),
      Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 50),
        child: ResetPasswordForm(feedback: _formResetPasswordSubmit, cancelOnclick:(){ })
      ),
    ];

    return content(
      showFooter: false,
      body:<Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [  
                SafeArea(
                  top: true, 
                  bottom: false,
                  child: Row(
                    children:[  
                      PrimaryButton(
                        onClick: (){ 
                          Navigation.changeToBack(context);
                        },
                        marginRight: 5,
                        width: 150, 
                        height: 35, 
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: CupertinoIcons.back,  
                        borderRadius: 100,
                        iconSize: 16,
                        title: "Voltar",
                        textColor: Colors.grey,
                        backgroundColor: Colors.transparent
                     ), 
                    ]
                 ) 
               ),
                Expanded(
                  child:  ListView( 
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: [    
                    Container( 
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [ 
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 60),
                            child:Text(
                              _titles[_step-1],  
                              style: TextStyle(
                                fontSize: 25, 
                                color: Colors.black.withOpacity(0.9)
                              )
                            ), 
                          ),
                          Text(
                            _subtitles[_step-1],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.6, 
                              color: Colors.black.withOpacity(0.65)
                            )
                          ),
                      ],
                     )
                   ),
                    containers[_step-1]
                  ]
               ) 
               ),
                SafeArea(
                  child: Column(
                    children: [ 
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 15),
                          width: 140,
                          height: 35,
                          child: Image.asset(
                            "assets/images/logo_principal_preto.png",  
                            width: 180, 
                            height: 30,  
                          )
                        ),
                      ],
                  )
                  
                )
              ],
            )
          )
        )
      ]
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

}