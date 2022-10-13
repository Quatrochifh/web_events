import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/checkbox/widget_checkbox.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/form/widget_label.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileForm extends StatefulWidget {

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue;

  final bool display;

  ProfileForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick,
    this.display = true
  }) : super(key: key);
  @override
  ProfileFormState createState() => ProfileFormState();
} 

class ProfileFormState extends State<ProfileForm> with CustomForm{

  Map<String, dynamic>? _initialValue;

  GlobalKey<CustomCheckBoxState>? _checkBoxConfirmKey = GlobalKey();

  var telephoneMask = new MaskTextInputFormatter(
    mask: '(##) # ####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );
 
  void updateInitialValue(initialValue){
    setState((){
      _initialValue = initialValue;
    });

    formKeys['firstName']!.currentState!.inputController().text = _initialValue!['name'].split(" ")[0];
    formKeys['lastName']!.currentState!.inputController().text = _initialValue!['name'].split(" ").length > 1 ? _initialValue!['name'].split(" ")[1] : "";
    formKeys['company']!.currentState!.inputController().text = _initialValue!['company'];
    formKeys['role']!.currentState!.inputController().text = _initialValue!['role'];
    formKeys['telephone']!.currentState!.inputController().text = _initialValue!['telephone'];
  }

  @override
  void initState(){ 
    super.initState();

    setState((){
      _initialValue = widget.initialValue;
    });

    formKeys = { 
      'firstName' : GlobalKey(),
      'lastName' : GlobalKey(),
      'company' : GlobalKey(),
      'role' : GlobalKey(),
      'telephone' : GlobalKey()
    };

    formFocus = { 
      'firstName' : FocusNode(),
      'lastName' : FocusNode(),
      'company' : FocusNode(),
      'role' : FocusNode(),
      'telephone' : FocusNode()
    };

    if(!mounted) return;

    onFinalSubmit = _onFinalSubmit;
    onFinalSubmitError = _onFinalSubmitError;

    setState(() { 
      formFocus = formFocus;
      formKeys = formKeys;
    });
  }
  
  void _onFinalSubmitError(error) { 

    if( !mounted ) return;

    setState((){ 
      formFocus = formFocus; 
      success = false; 
      message = error;
    }); 
  } 

  void _onFinalSubmit() {
     
    String firstName = formKeys['firstName']!.currentState!.inputController().text;
    String lastName = formKeys['lastName']!.currentState!.inputController().text;
    String company = formKeys['company']!.currentState!.inputController().text;
    String role = formKeys['role']!.currentState!.inputController().text;
    String telephone = formKeys['telephone']!.currentState!.inputController().text;

    User user = new User();
    user.name = "$firstName $lastName";
    user.company = company;
    user.role = role;
    user.telephone = telephone;
    submit(
      (){ 
        widget.feedback(user, "update").then((r){});
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    if (widget.display != true) {
      return SizedBox.shrink();
    }
    return  Column(
        children: [
          Row( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [  
              Expanded( 
                child: Label("Nome"),
              ), 
              Expanded(
                child: Label("Sobrenome"),
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [  
              Expanded( 
                child: Input(margin: EdgeInsets.only(bottom: 5, top: 5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), borderWidth: 0, backgroundColor: Color.fromRGBO(255, 255, 255, 1 ), focusNode: formFocus['firstName'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['firstName'], initialValue: _initialValue == null ? "" : _initialValue!['name'].split(" ")[0], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: CupertinoIcons.person, hintText: "Primeiro nome" ),
              ), 
              Expanded(
                child: Input(margin: EdgeInsets.only(bottom: 5, top: 5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['lastName'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['lastName'], initialValue: _initialValue == null ? "" : (_initialValue!['name'].split(" ").length > 1 ? _initialValue!['name'].split(" ")[1] : ""), validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: CupertinoIcons.person, hintText: "Sobrenome" ),
              )
            ]
          ),
          Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Label("Empresa"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), borderWidth: 0, backgroundColor: Color.fromRGBO(255, 255, 255, 1 ), focusNode: formFocus['company'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['company'], initialValue: _initialValue == null ? "" : _initialValue!['company'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: CupertinoIcons.house, hintText: "Empresa" ),
            ]
          ),
          Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Label("Cargo"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['role'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['role'], initialValue: _initialValue == null ? "" : _initialValue!['role'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: CupertinoIcons.person_crop_circle, hintText: "Cargo" ),
            ]
          ),
          Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Label("Celular"),
              Input(mask:[telephoneMask], margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['telephone'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['telephone'], initialValue: _initialValue == null ? "" : _initialValue!['telephone'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: CupertinoIcons.phone, hintText: "Telefone" ),
            ]
          ),
          (widget.hideButtons != true) 
            ? 
              Container(
                margin: EdgeInsets.only(top: 30), 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      onClick: _onFinalSubmit,
                      width: 140,
                      height: 45,
                      icon: FontAwesomeIcons.check,
                      iconRight: true,
                      title: "Atualizar",
                      backgroundColor: primaryColor,
                      textColor: Colors.white
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