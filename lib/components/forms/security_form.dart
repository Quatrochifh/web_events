import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/form/widget_label.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SecurityForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  SecurityForm({Key? key, this.initialValue, this.hideButtons, required this.feedback, required this.cancelOnclick}) : super( key: key );

  @override
  SecurityFormState createState() => SecurityFormState();
} 

class SecurityFormState extends State<SecurityForm> with CustomForm{ 
 
  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'currentPassword' : GlobalKey(),
      'newPassword' : GlobalKey(), 
      'confirmNewPassword' : GlobalKey(), 
    };

    formFocus = { 
      'currentPassword' : FocusNode(),
      'newPassword' : FocusNode(), 
      'confirmNewPassword' : FocusNode(), 
    };

    onFinalSubmit = _onFinalSubmit;

    onFinalSubmitError = _onFinalSubmitError;

    if (!mounted ) return; 

    setState((){ 
      formFocus = formFocus; 
      formKeys = formKeys; 
    });  

 
  }
  
  void _onFinalSubmitError( error) { 

    if (!mounted ) return; 

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

    String currentPassword    = formKeys['currentPassword']!.currentState!.inputController().text; 
    String newPassword        = formKeys['newPassword']!.currentState!.inputController().text; 
    String confirmNewPassword = formKeys['confirmNewPassword']!.currentState!.inputController().text; 
    
    if (confirmNewPassword.length <= 5) {
      message = "Senha inválida. Ela deve ter pelo menos 6 caracteres.";
      success = false;
      showNotification(message: message);
      return;
    }

    if (newPassword.length <= 5) {
      message = "Nova senha é inválida. Ela deve ter pelo menos 6 caracteres.";
      success = false;
      showNotification(message: message);
      return;
    }

    if (newPassword != confirmNewPassword) {
      message = "A 'Nova Senha' deve ser igual à 'Confirmar Nova Senha' ";
      success = false;
      showNotification(message: message);
      return;
    }

    submit(
      (){ 
        widget.feedback( 
          currentPassword,
          newPassword
        ).then((r){
          if (r != true) {
            message = r ?? "Houve uma falha ao atualizar sua senha.";
            success = false;
          } else {
            message = "Nova senha atualizada com sucesso!";
            success = true;
          }
          showNotification(message: message, type: success == true ? 'success' : 'warning');
        });
      }
    );
  }
  

  @override
  Widget build( BuildContext context) {  
    return  Column(  
        children: [
          Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [  
              Label("Senha Atual"), 
              Input(margin: EdgeInsets.all(5), iconColor: Colors.grey.withOpacity(0.5), obscureText: true,  borderRadius: 10, borderColor: Colors.grey, borderWidth: 0, backgroundColor: Color.fromRGBO(255, 255, 255, 1 ), focusNode: formFocus['firstName'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['currentPassword'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['firstName'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: FontAwesomeIcons.key, hintText: "Senha Atual" ),
              Label("Nova Senha"),
              Input(margin: EdgeInsets.all(5), iconColor: Colors.grey.withOpacity(0.5), obscureText: true, borderRadius: 10, borderColor: Colors.grey, backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['lastName'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['newPassword'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['newPassword'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26,icon: FontAwesomeIcons.key, hintText: "Nova Senha" ),
              Label("Confirmar Nova Senha"),
              Input(margin: EdgeInsets.all(5), iconColor: Colors.grey.withOpacity(0.5), obscureText: true, borderRadius: 10, borderColor: Colors.grey, backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['lastName'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['confirmNewPassword'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['confirmNewPassword'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26,icon: FontAwesomeIcons.key, hintText: "Confirmar Nova Senha" ),
            ]
          ),    
          ( widget.hideButtons != true ) 
            ? 
              Container(
                margin: EdgeInsets.only(top: 30), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(onClick: _onFinalSubmit, width: 160, height: 45, borderRadius: 5, icon: CupertinoIcons.right_chevron, iconRight: true, title: "Atualizar", backgroundColor: primaryColor, textColor: Colors.white)
                  ],
                ),
              )  
          :
            SizedBox.shrink()
        ],
      );
  }

}