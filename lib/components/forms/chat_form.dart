import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart'; 
import 'package:appweb3603/components/forms/custom_form.dart'; 
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ChatForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  ChatForm({Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick
  }) : super(key: key);

  @override
  ChatFormState createState() => ChatFormState();
} 

class ChatFormState extends State<ChatForm> with CustomForm{ 
 
  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'msg' : GlobalKey(), 
    };

    formFocus = { 
      'msg' : FocusNode(), 
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

     
    String msg = formKeys['msg']!.currentState!.inputController().text; 
     
    if( msg.length < 3 || msg.length > 120 ){
      setState((){
        message = "Mensagem deve ter entre 3 e 120 caracteres!";
        success = false;
      });
      return;
    }
 

    submit(
      (){ 
        widget.feedback( 
          message: msg 
        ).then((r){
          if( r != true && r != null ){
            setState((){
              message = r;
              success = false;
            });
          } else {
            setState((){
              message = "";
              success = null;
              formKeys['msg']!.currentState!.inputController().text = "";
            });
          }
        });
      }
    );
  }
  

  @override
  Widget build( BuildContext context ){  
    return  Column(  
        children: [ 
          Row( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [  
              Expanded( 
                child: Input(margin: EdgeInsets.only(left: 5, right: 5), fontSize: 14, backgroundColor: Color.fromARGB(255, 211, 211, 211), borderRadius: 100, borderColor: Color.fromRGBO(0, 0, 0, 0.065), borderWidth: 0, focusNode: formFocus['msg'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['msg'], initialValue: widget.initialValue == null ? "" : widget.initialValue!['firstName'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, hintText: "Sua mensagem ..." ),
              ), 
              PrimaryButton(onClick: _onFinalSubmit, width: 50, height: 50, borderRadius: 100, icon: FontAwesomeIcons.solidPaperPlane, onlyIcon: true, iconRight: true, backgroundColor: primaryColor, textColor: Colors.white) 
            ]
          ),  
          
            /*Message( 
              
              bgColor: Colors.transparent,
              textColor: success != null ? ( success == false ? errorColor : successColor ) : Colors.transparent ,  
              fontSize: 15.8,
              fontWeight: FontWeight.w200,
              margin: EdgeInsets.only(top: 5), 
              text: success != null ? message : ""
            )*/
            
        ],
      );
  }

}