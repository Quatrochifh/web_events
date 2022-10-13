import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  CodeForm( {Key? key, this.hideButtons, required this.feedback, required this.cancelOnclick} ) : super( key: key );

  @override
  CodeFormState createState() => CodeFormState();
} 

class CodeFormState extends State<CodeForm> with CustomForm{

  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'f1' : GlobalKey(),
      'f2' : GlobalKey(),
      'f3' : GlobalKey(),
      'f4' : GlobalKey()
    };

    formFocus = { 
      'f1' : FocusNode(),
      'f2' : FocusNode(),
      'f3' : FocusNode(),
      'f4' : FocusNode()
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


    String value = "";

    value+= formKeys['f1']!.currentState!.inputController().value.text;
    value+= formKeys['f2']!.currentState!.inputController().value.text;
    value+= formKeys['f3']!.currentState!.inputController().value.text;
    value+= formKeys['f4']!.currentState!.inputController().value.text;

    submit((){ 
        widget.feedback(value);
    });
  }

  @override
  Widget build( BuildContext context ){
    return Form( 
      child: Column( 
        children: [
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              Input(keyBoardType: TextInputType.number, maxLength: 1, nextFocus: formFocus['f2'],  key: formKeys['f1'], focusNode: formFocus['f1'], margin: EdgeInsets.all(4.5), width: 65, height: 65, iconColor: Colors.black38, borderRadius:10, validatorFunction: (){ }, labelColor: Colors.black38, borderColor: Colors.black26, textAlign: TextAlign.center,),   
              Input(keyBoardType: TextInputType.number, maxLength: 1, previousFocus:formFocus['f1'], nextFocus: formFocus['f3'], key: formKeys['f2'], focusNode: formFocus['f2'], margin: EdgeInsets.all(4.5), width: 65, height: 65, iconColor: Colors.black38, borderRadius:10, validatorFunction: (){ }, labelColor: Colors.black38, borderColor: Colors.black26, textAlign: TextAlign.center,),   
              Input(keyBoardType: TextInputType.number, maxLength: 1, previousFocus:formFocus['f2'], nextFocus: formFocus['f4'], key: formKeys['f3'], focusNode: formFocus['f3'], margin: EdgeInsets.all(4.5), width: 65, height: 65, iconColor: Colors.black38, borderRadius:10, validatorFunction: (){ }, labelColor: Colors.black38, borderColor: Colors.black26, textAlign: TextAlign.center,),   
              Input(keyBoardType: TextInputType.number, maxLength: 1, previousFocus:formFocus['f3'], key: formKeys['f4'], focusNode: formFocus['f4'], margin: EdgeInsets.all(4.5), width: 65, height: 65, iconColor: Colors.black38, borderRadius:10, validatorFunction: (){ }, labelColor: Colors.black38, borderColor: Colors.black26, textAlign: TextAlign.center,),   
            ],
          ), 
          ( widget.hideButtons != true ) 
            ? 
              Container(
                margin: EdgeInsets.only(top: 30), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [ 
                    PrimaryButton(onClick: (){ _onFinalSubmit(); }, width: 160, height: 45, iconRight: true, icon: CupertinoIcons.arrow_right, title: "Prosseguir")
                  ],
                ),
              )  
          :
            SizedBox.shrink()
        ],
      ),
    );
  }

}