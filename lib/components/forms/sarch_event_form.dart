import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/components/widget_message.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SearchEventForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final bool? leftPosition; 

  final bool? onlyBtnIcon;  

  final String? initialValue; 

  SearchEventForm( {Key? key, this.onlyBtnIcon, this.leftPosition, this.initialValue, this.hideButtons, required this.feedback, required this.cancelOnclick} ) : super( key: key );

  @override
  SearchEventFormState createState() => SearchEventFormState();
} 

class SearchEventFormState extends State<SearchEventForm> with CustomForm{ 
 
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

    if( widget.leftPosition != true ){
      return Form( 
        child: Column( 
          children: <Widget>[
            Container( 
              margin: EdgeInsets.only(top: 10, bottom: 30),
              height: 50,
              child: success != null ? 
                Message(
                  icon:  success == true ? FontAwesomeIcons.checkDouble :  FontAwesomeIcons.exclamation ,
                  bgColor: success  == true ? successColor : warningColor,
                  textColor: Colors.white,  
                  fontSize: 15.8,
                  fontWeight: FontWeight.w200,
                  margin: EdgeInsets.all( 0 ),
                  padding: EdgeInsets.only( top: 8, left: 10, bottom: 8, right: 10 ),
                  text: message,  
                )
              : 
                SizedBox.shrink()
              ,
            ),    
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
              textColor: Colors.white,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.095),
              borderColor: Colors.transparent, 
              hintColor: Color.fromRGBO(255, 255, 255, 0.7),
              margin: EdgeInsets.all(3), 
              hintSize: 17,
              fontSize: 15,
              hintText: "Buscar um evento" 
            ), 
            ( widget.hideButtons != true ) 
              ? 
                Container(
                  margin: EdgeInsets.only(top:widget.leftPosition != true ? 30 : 0), 
                  child: Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButton(
                        onClick: (){ widget.cancelOnclick(); },
                        marginLeft:  widget.onlyBtnIcon != true ? 0 : 20,
                        width: widget.onlyBtnIcon != true ? 120 : 50, 
                        height: widget.onlyBtnIcon != true ? 45 : 50, 
                        title: "Meus Eventos", 
                        borderRadius: 100,
                        onlyIcon: widget.onlyBtnIcon,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
                      ),
                      PrimaryButton(
                        onClick: _onFinalSubmit,
                        marginLeft:  widget.onlyBtnIcon != true ? 0 : 20,
                        width: widget.onlyBtnIcon != true ? 130 : 50, 
                        height: widget.onlyBtnIcon != true ? 45 : 50, 
                        icon: CupertinoIcons.search, 
                        title: "Buscar", 
                        borderRadius: 100,
                        onlyIcon: widget.onlyBtnIcon,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.25),
                      )
                    ],
                  ),
                )  
            :
              SizedBox.shrink() 
          ] 
        ),
      );
    }else{
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
                textColor: Colors.white,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.125),
                borderColor: Colors.transparent, 
                hintColor: Color.fromRGBO(255, 255, 255, 0.7),
                margin: EdgeInsets.all(3), 
                hintSize: 17,
                fontSize: 15,
                hintText: "Buscar um evento" 
              ),  
          ),
          ( widget.hideButtons != true ) 
            ? 
              Container(
                margin: EdgeInsets.only(top:widget.leftPosition != true ? 30 : 0), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      onClick: _onFinalSubmit,
                      marginLeft:  widget.onlyBtnIcon != true ? 0 : 20,
                      width: widget.onlyBtnIcon != true ? 130 : 50, 
                      height: widget.onlyBtnIcon != true ? 45 : 50, 
                      icon: CupertinoIcons.search, 
                      title: "Buscar", 
                      borderRadius: 100,
                      onlyIcon: widget.onlyBtnIcon,
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
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

}