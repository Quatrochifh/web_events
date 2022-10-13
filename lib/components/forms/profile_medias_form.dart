import 'dart:convert';

import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/checkbox/widget_checkbox.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/form/widget_label.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileMediasForm extends StatefulWidget {

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue;

  final bool display;

  ProfileMediasForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick,
    this.display = true
  }) : super(key: key);

  @override
  ProfileMediasFormState createState() => ProfileMediasFormState();
} 

class ProfileMediasFormState extends State<ProfileMediasForm> with CustomForm{

  Map<String, dynamic>? _initialValue;

  void updateInitialValue(initialValue){
    setState((){
      _initialValue = initialValue;
    });
    if (_initialValue!['medias'].runtimeType.toString() != "String") return;

    _initialValue!['medias'] = JsonDecoder().convert(_initialValue!['medias']);

    if (_initialValue!['medias'] != null) {
      _initialValue!['medias'].forEach((k, v){
        formKeys['social_${k.toString()}']!.currentState!.inputController().text = v;
      });
    }
  }

  @override
  void initState(){ 
    super.initState();

    setState((){
      _initialValue = widget.initialValue;
    });

    formKeys = {
      'social_facebook' : GlobalKey(),
      'social_instagram' : GlobalKey(),
      'social_twitter' : GlobalKey(),
      'social_linkedin' : GlobalKey(),
      'social_link' : GlobalKey()
    };

    formFocus = {
      'social_facebook' : FocusNode(),
      'social_instagram' : FocusNode(),
      'social_twitter' : FocusNode(),
      'social_linkedin' : FocusNode(),
      'social_link' : FocusNode()
    };

    if(!mounted) return;

    onFinalSubmit = _onFinalSubmit;
    onFinalSubmitError = _onFinalSubmitError;

    setState((){ 
      formFocus = formFocus;
      formKeys = formKeys;
    });
  }

  void _onFinalSubmitError(error) { 
    if(!mounted) return;

    setState((){ 
      formFocus = formFocus; 
      success = false; 
      message = error;
    }); 
  } 

  void _onFinalSubmit() {
    Map<String, String> medias = {
      'facebook' : formKeys['social_facebook']!.currentState!.inputController().text,
      'twitter' : formKeys['social_twitter']!.currentState!.inputController().text,
      'instagram' : formKeys['social_instagram']!.currentState!.inputController().text,
      'linkedin' : formKeys['social_linkedin']!.currentState!.inputController().text,
      'link' : formKeys['social_link']!.currentState!.inputController().text,
    };

    User user = new User();
    user.medias = medias;
    submit(
      (){ 
        widget.feedback(user, "medias").then((r){});
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    if (widget.display != true) {
      return SizedBox.shrink();
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child:Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Label("Facebook"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['social_facebook'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['social_facebook'], initialValue: _initialValue == null ? "" : _initialValue!['social_facebook'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: FontAwesomeIcons.facebook, hintText: "Facebook" ),
              Label("Twitter"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['social_twitter'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['social_twitter'], initialValue: _initialValue == null ? "" : _initialValue!['social_twitter'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: FontAwesomeIcons.twitter, hintText: "Twitter" ),
              Label("Instagram"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['social_instagram'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['social_instagram'], initialValue: _initialValue == null ? "" : _initialValue!['social_instagram'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: FontAwesomeIcons.instagram, hintText: "Instagram" ),
              Label("Linkedin"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['social_linkedin'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['social_linkedin'], initialValue: _initialValue == null ? "" : _initialValue!['social_linkedin'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: FontAwesomeIcons.linkedinIn, hintText: "Linkedin" ),
              Label("Link"),
              Input(margin: EdgeInsets.all(5), borderRadius: 2, borderColor: Colors.black.withOpacity(0.125), backgroundColor: Color.fromRGBO(255, 255, 255, 1), focusNode: formFocus['social_link'], textColor: Colors.black54, formSubmitFunction: onSubmitFunction, key: formKeys['social_link'], initialValue: _initialValue == null ? "" : _initialValue!['social_link'], validatorFunction: (){ }, labelColor: Colors.black38, height: 50, hintColor: Colors.black26, icon: FontAwesomeIcons.link, hintText: "Link" ),
            ]
          ),
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