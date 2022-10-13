import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/style.dart';  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 


class SearchTransmissionForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons; 

  final String? initialValue; 

  SearchTransmissionForm( {Key? key, this.initialValue, this.hideButtons, required this.feedback, required this.cancelOnclick} ) : super( key: key );

  @override
  SearchTransmissionFormState createState() => SearchTransmissionFormState();
} 

class SearchTransmissionFormState extends State<SearchTransmissionForm> with CustomForm{ 
 
  @override
  void initState(){ 
    super.initState(); 

    formKeys = { 
      'eventCode' : GlobalKey() 
    };

    formFocus = { 
      'eventCode' : FocusNode() 
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
    //Vamos ignirar o error, pois só temos um campo... o Erro nesta parte ocorre se tiver algum campo vazio.
    if( !mounted ) return; 

    setState((){ 
      formFocus = formFocus;  
      success = false;  
      message = "Busque por um nome de um evento válido.";
    });  
  } 

  void _onFinalSubmit(){ 

    setState((){  
      success = null; 
      message = "";
    });  

     
    String eventCode = formKeys['eventCode']!.currentState!.inputController().text; 
    
    if( eventCode.length <= 3 ){
      setState((){
        message = "Digite pelo menos 4 caracteres!";
        success = false;
      });
    }

    submit(
      (){ 
        widget.feedback( 
          eventCode,
        );
      }
    );
  }
  

  @override
  Widget build( BuildContext context ){    


    return Form( 
      child: Row( 
        children: [
          Expanded( 
          child: 
            Input(
              focusNode: formFocus['eventCode'],
              borderRadius: 100,  
              formSubmitFunction: onSubmitFunction, 
              key: formKeys['eventCode'], 
              initialValue: widget.initialValue ?? "", 
              validatorFunction: (){ }, 
              labelColor: Colors.black38, 
              height: 48, 
              padding: EdgeInsets.only(left: 20, right: 15),
              textColor: Colors.black,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.125),
              borderColor: Colors.transparent, 
              hintColor: Color.fromRGBO(0, 0, 0, 0.7),
              margin: EdgeInsets.all(3), 
              hintSize: 17,
              fontSize: 15,
              hintText: "Buscar uma transmissão" 
            ),  
        ),
        ( widget.hideButtons != true ) 
          ? 
            Container( 
              margin: EdgeInsets.all(0),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    onClick: _onFinalSubmit,
                    marginLeft: 20,
                    width: 50, 
                    height:  50, 
                    icon: CupertinoIcons.search,  
                    borderRadius: 100,
                    onlyIcon: true,
                    textColor: Colors.white,
                    backgroundColor: primaryColor,
                  )
                ],
              ),
            )  
        :
          SizedBox.shrink() 
        ]
      ),
    ); 
  
  
  }

}