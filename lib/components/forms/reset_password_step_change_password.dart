import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/form/widget_label.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ResetPasswordForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  ResetPasswordForm( {Key? key, this.initialValue, this.hideButtons, required this.feedback, required this.cancelOnclick} ) : super( key: key );

  @override
  ResetPasswordFormState createState() => ResetPasswordFormState();
} 

class ResetPasswordFormState extends State<ResetPasswordForm> with CustomForm{ 
 
  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'password' : GlobalKey(),
      'confirmPassword' : GlobalKey(),
    };

    formFocus = { 
      'password' : FocusNode(),
      'confirmPassword' : FocusNode() 
    };

    onFinalSubmit = _onFinalSubmit;

    onFinalSubmitError = _onFinalSubmitError;

    if( !mounted ) return; 

    setState((){ 
      formFocus = formFocus; 
      formKeys = formKeys; 
    });  

 
  }
  
  void _onFinalSubmitError( error ){ 

    if( !mounted ) return; 

    setState((){ 
      formFocus = formFocus;  
      success = false;  
      message = error;
    });  
  }

  void _onFinalSubmit(){ 

    setState((){  
      success = null; 
      message = "";
    });
  
    String password = formKeys['password']!.currentState!.inputController().text; 
    String confirmPassword    = formKeys['confirmPassword']!.currentState!.inputController().text;

    if( password.length <= 5 || confirmPassword.length <= 5 ){
      setState((){
        message = "Senha no formato inválido!";
        success = false;
      });
    }

    if( password != confirmPassword ){
      setState((){
        message = "Nova senha não bate com o confirmar senha.";
        success = false;
      });
    }

    submit(
      (){ 
        widget.feedback(
          password,
          confirmPassword, 
          error: message.isEmpty ? null : message
        ).then((r){
          if( r != true && r != null ){
            setState((){
              message = r;
              success = false;
            });
          } else {
            setState((){
              message = "Senha alterada com sucesso!";
              success = true;
            });
          }
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
              Label("Nova senha"),
              Input(iconColor: Color.fromRGBO(0, 0, 0, 0.150), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255,  0.95 ), focusNode: formFocus['password'], textColor: Colors.black54, obscureText: true, formSubmitFunction: onSubmitFunction, key: formKeys['password'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['password'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26,icon: CupertinoIcons.lock, margin: EdgeInsets.only(bottom: 15, top: 5), hintText: "******" ),
              Label("Confirmar nova senha"),
              Input(iconColor: Color.fromRGBO(0, 0, 0, 0.150), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255,  0.95 ), focusNode: formFocus['confirmPassword'], textColor: Colors.black54, obscureText: true, formSubmitFunction: onSubmitFunction, key: formKeys['confirmPassword'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['confirmPassword'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26,icon: CupertinoIcons.lock, margin: EdgeInsets.only(bottom: 15, top: 5), hintText: "******" ),
            ]
          ),
          ( widget.hideButtons != true ) 
            ? 
              Container(
                margin: EdgeInsets.only(top: 30), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded( 
                      child: PrimaryButton(onClick: _onFinalSubmit, borderColor: Colors.white,  height: 50, borderRadius: 2,  title: "Alterar senha", textColor: Colors.white)
                    )
                  ],
                ),
              )  
          :
            SizedBox.shrink()
        ],
      );
  }

}