import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/style.dart';  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 


class SearchParticipantForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons; 

  final String? initialValue; 

  SearchParticipantForm({Key? key, this.initialValue, this.hideButtons, required this.feedback, required this.cancelOnclick}) : super(key: key);

  @override
  SearchParticipantFormState createState() => SearchParticipantFormState();
} 

class SearchParticipantFormState extends State<SearchParticipantForm> with CustomForm{ 
 
  @override
  void initState() { 
    super.initState(); 

    formKeys = { 
      'name' : GlobalKey() 
    };
    formFocus = { 
      'name' : FocusNode() 
    };

    onFinalSubmit = _onFinalSubmit;
    onFinalSubmitError = _onFinalSubmitError;

    if(!mounted) return; 

    setState(() { 
      formFocus = formFocus; 
      formKeys = formKeys; 
    });  

 
  }
  
  void _onFinalSubmitError(error) { 
    //Vamos ignirar o error, pois só temos um campo... o Erro nesta parte ocorre se tiver algum campo vazio.
    if( !mounted ) return; 

    setState((){ 
      formFocus = formFocus;  
      success = false;  
      message = "Busque por um nome válido!";
    });  
  } 

  void _onFinalSubmit() { 

    setState((){  
      success = null; 
      message = "";
    });  

     
    String name = formKeys['name']!.currentState!.inputController().text; 
    
    if( name.length <= 3 ){
      setState((){
        message = "Digite pelo menos 4 caracteres!";
        success = false;
      });
    }

    submit(
      (){ 
        widget.feedback( 
          name: name,
          clean: true
        );
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {    

    return Container( 
      margin: EdgeInsets.all(0),
      child: Row( 
        children: [
          Expanded( 
          child: Input(
              focusNode: formFocus['name'],
              borderRadius: 100,  
              formSubmitFunction: onSubmitFunction, 
              key: formKeys['name'], 
              initialValue: widget.initialValue ?? "", 
              validatorFunction: (){ }, 
              labelColor: Colors.black38, 
              height: 48, 
              padding: EdgeInsets.only(
                left: 20,
                right: 15
              ),
              textWeight: FontWeight.bold,
              textColor: Colors.black,
              letterSpacing: primaryLetterSpacing,
              backgroundColor: Colors.transparent,
              borderColor: Colors.transparent, 
              hintColor: Color.fromRGBO(0, 0, 0, 0.3),
              margin: EdgeInsets.all(3), 
              hintSize: 17,
              fontSize: 22,
              hintText: "Buscar um participante" 
            ),  
        ),
        (widget.hideButtons != true) 
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
                    textColor: primaryColor,
                    backgroundColor: Colors.transparent,
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