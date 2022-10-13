import 'dart:async';
import 'dart:ui';

import 'package:appweb3603/bloc/Login.dart';
import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/forms/login_form.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_title_h3.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/messages.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {

  final String eventCode;

  final String eventName;

  final String eventLogo;

  final String? eventBackground;

  final String? loginEmail;

  final String? loginPassword;

  LoginPage({
    Key? key,
    this.eventBackground,
    required this.eventCode,
    required this.eventName,
    required this.eventLogo,
    this.loginEmail,
    this.loginPassword
  }) : super(key: key);

  @override
  LoginPageState createState() => new LoginPageState();
} 

class LoginPageState extends State<LoginPage> with PageComponent{

  Timer? _timer;

  DecorationImage? _decorationBackgroundImage;

  @override
  void initState() {
    super.initState();

    if(!mounted) return;

    setState(() {
      if(widget.eventBackground != null) {
        try {
          _decorationBackgroundImage = DecorationImage(
            image: NetworkImage(widget.eventBackground!),
            fit: BoxFit.cover,
          );
        } catch(e) {
          debugPrint(e.toString());
        }
      }else{ 
        _decorationBackgroundImage =  DecorationImage(
          image: AssetImage("assets/images/background/background_points_branco.png"),
          fit: BoxFit.cover,
        );
      }
       
    });

  }

  /*
    * Redireciona para o formulário de cadastro do evento
  */
  void _formSubscription() {
    navigatorPushNamed(
      context,
      '/view-plans',
      arguments: {
        'eventCode': widget.eventCode,
        'eventName': widget.eventName,
        'eventLogo': widget.eventLogo,
        'eventBackground': widget.eventBackground
      }
    );
  } 


  /*
    * Efetuar o login
    * @Param (string) email
    * @Param (string) password
    * @Param (string) error
  */
  Future _formSubmit(email, password, checkBoxTerms, {String? error}) {

    // Show loading
    showLoading();
    return Modular.get<Login>().normalLogin(email: email, password: password, eventCode: widget.eventCode, checkBoxTerms: checkBoxTerms).then((results){
      //Hide loading
      hideLoading();

      if (results == true) {
        registerNotification(message: globalMessages['LOGIN_SUCCESS'], type: 'success');

        // Carregará na controller, os dados do usuário
        Modular.get<Controller>().afterLogin();
      } else {
        registerNotification(message: results, type: 'warning');
      }

      return;
    });
  } 

  @override
  Widget build(BuildContext context){

    return content(
      resizeToAvoidBottomInset: true,
      showFooter: false,
      body: <Widget>[
        Expanded(
          child: Container( 
            alignment: Alignment.center,
            width: double.infinity, 
            decoration: BoxDecoration(
              image: _decorationBackgroundImage,
              color: Colors.white, 
              backgroundBlendMode: BlendMode.darken
            ), 
            child: ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: new Container( 
                  decoration: new BoxDecoration(
                    color: Colors.black.withOpacity(0.5)
                  ),
                  child: Stack(
                    children: [ 
                      ListView(
                        padding: noPadding,
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
                                  iconMargin: EdgeInsets.only(
                                    left: 10
                                  ),
                                  title: "Voltar",
                                  textColor: Colors.grey,
                                  backgroundColor: Colors.transparent
                                ), 
                              ]
                            ) 
                          ),
                          Column(
                            children: [    
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 120
                                ),
                                child: Column( 
                                  children: [ 
                                    Container(
                                      margin: EdgeInsets.all(0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                              top: 10
                                            ),
                                            padding: EdgeInsets.only(
                                              right: 10
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.white.withOpacity(0.125),
                                                  width: 1.1
                                                )
                                              )
                                            ),
                                            child: CustomImage(
                                              local: false, 
                                              image: widget.eventLogo, 
                                              width: 122, 
                                              height: 65, 
                                              fit: BoxFit.fitHeight
                                            )
                                          ),
                                          TitleH3(
                                            margin: EdgeInsets.only(
                                              left: 10
                                            ),
                                            title: "Login",
                                            fontColor: Colors.white.withOpacity(0.65),
                                            fontSize: 22,
                                            alignment: Alignment.center,
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                                child: LoginForm(
                                  subscription: _formSubscription,
                                  feedback: _formSubmit,
                                  cancelOnclick: (){ },
                                  initialValue: {'email' : widget.loginEmail ?? "", 'password' : widget.loginPassword ?? ""}
                                )
                              ),
                            ]
                          ),
                        ],
                      ),
                    ]
                  )
                ),
              )
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