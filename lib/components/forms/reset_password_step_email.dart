import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/style.dart'; 
import 'package:appweb3603/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordEmailForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  ResetPasswordEmailForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick
  }) : super(key: key);

  @override
  ResetPasswordEmailFormState createState() => ResetPasswordEmailFormState();
} 

class ResetPasswordEmailFormState extends State<ResetPasswordEmailForm> with CustomForm{ 
 
  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'email' : GlobalKey()
    };

    formFocus = { 
      'email' : FocusNode()
    };

    onFinalSubmit = _onFinalSubmit;

    onFinalSubmitError = _onFinalSubmitError;

    if(!mounted) return; 

    setState(() { 
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

     
    String email    = formKeys['email']!.currentState!.inputController().text;
    
    if( email.length <= 1 || !isEmail(email) ){
      setState((){
        message = "E-mail inválido!";
        success = false;
      });
    }

    submit(
      (){ 
        widget.feedback( 
          email, 
          error: message.isEmpty ? null : message
        ).then((r){
          if( r != true && r != null ){
            setState((){
              message = r;
              success = false;
            });
          } else {
            setState((){
              message = "Recuperação em andamento!";
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
              Input(iconColor: Color.fromRGBO(0, 0, 0, 0.150), borderRadius: 5, borderColor: Colors.black.withOpacity(0.125), borderWidth: 0, backgroundColor: Color.fromRGBO(255, 255, 255,  0.95 ), focusNode: formFocus['email'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['email'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['email'], validatorFunction: (){ }, labelColor: Colors.black38, height: 55, hintColor: Colors.black26, icon: CupertinoIcons.envelope, margin: EdgeInsets.only(bottom: 15, top: 5), hintText: "example@email.com" )            ]
          ),    
          ( widget.hideButtons != true ) 
            ? 
              Container(
                margin: EdgeInsets.only(top: 30), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded( 
                      child: PrimaryButton(
                        onClick: _onFinalSubmit,
                        backgroundColor: appPrimaryColor,
                        borderColor: Colors.white,
                        height: 50,
                        borderRadius: 3,
                        title: "Recuperar",
                        textColor: Colors.white
                      )
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