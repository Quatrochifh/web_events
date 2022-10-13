import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/checkbox/widget_checkbox.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function subscription;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  LoginForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick,
    required this.subscription
  }) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
} 

class LoginFormState extends State<LoginForm> with CustomForm{

  GlobalKey<CustomCheckBoxState>? _checkBoxConfirmKey = GlobalKey();
 
  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'email' : GlobalKey(),
      'password' : GlobalKey(),
    };
    formFocus = { 
      'email' : FocusNode(),
      'password' : FocusNode() 
    };

    onFinalSubmit = _onFinalSubmit;

    if (!mounted) return; 

    setState(() { 
      formFocus = formFocus; 
      formKeys = formKeys; 
    });
  }

  void _onFinalSubmit(){ 

    setState((){  
      success = null; 
      message = "";
    });  

     
    String email    = formKeys['email']!.currentState!.inputController().text; 
    String password = formKeys['password']!.currentState!.inputController().text;

    submit(
      (){ 
        widget.feedback(
          email,
          password,
          _checkBoxConfirmKey!.currentState!.isChecked(),
          error: message.isEmpty ? null : message
        ).then((r){
        });
      }
    );
  }
  

  @override
  Widget build( BuildContext context ){  
    return  Column(  
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [  
              Input(iconColor: Colors.grey, borderRadius: 5, borderColor: Colors.black.withOpacity(0.125), borderWidth: 0, backgroundColor: Color.fromRGBO(255, 255, 255,  0.95 ), focusNode: formFocus['email'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['email'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['email'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: CupertinoIcons.envelope, margin: EdgeInsets.only(bottom: 15, top: 5), hintText: "example@email.com" ),
              Input(iconColor: Colors.grey, borderRadius: 5, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255,  0.95 ), focusNode: formFocus['password'], textColor: Colors.black54, obscureText: true, formSubmitFunction: onSubmitFunction, key: formKeys['password'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['password'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26,icon: CupertinoIcons.lock, margin: EdgeInsets.only(bottom: 15, top: 5), hintText: "******" ),
            ]
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      title: "Recuperar senha",
                      padding: noPadding,
                      mainAxisAlignment: MainAxisAlignment.start,
                      width: 140,
                      height: 45,
                      backgroundColor: Colors.transparent,
                      textColor: Colors.white.withOpacity(0.8),
                      icon: CupertinoIcons.lock,
                      fontWeight: FontWeight.w200,
                      iconSize: 12,
                      fontSize: 14,
                      onClick: (){
                        navigatorPushNamed(context, '/view-reset-password');
                      }
                    ),
                  ]
                )
              ),
              //Checkbox de termo e regulamento
              Container(
                alignment: Alignment.centerLeft,
                child: CustomCheckBox(
                  key: _checkBoxConfirmKey,
                  checked: false,
                  text: "Aceito os termos e estou de acordo com as regras e politica de privacidade do evento e do aplicativo."
                )
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30), 
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: PrimaryButton(
                    onClick: _onFinalSubmit,
                    borderColor: Colors.white,
                    height: 50,
                    borderRadius: 5,
                    title: "Fazer Login",
                    iconColor: Colors.white.withOpacity(0.5),
                    icon: FontAwesomeIcons.user,
                    textColor: Colors.white
                  )
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30), 
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: PrimaryButton(
                    onClick: widget.subscription,
                    borderColor: Colors.white,
                    backgroundColor: secondaryColor,
                    height: 50,
                    borderRadius: 5,
                    fontSize: 16,
                    iconColor: Colors.white.withOpacity(0.5),
                    icon: CupertinoIcons.person_add,
                    title: "Inscrever-se",
                    textColor: Colors.white
                  ),
                )
              ]
            )
          )
        ],
      );
  }

}