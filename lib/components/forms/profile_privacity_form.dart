import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/checkbox/widget_checkbox.dart';
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePrivacityForm extends StatefulWidget {

  final bool display;

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue;

  ProfilePrivacityForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.cancelOnclick,
    this.display = true
  }) : super(key: key);
  @override
  ProfilePrivacityFormState createState() => ProfilePrivacityFormState();
} 

class ProfilePrivacityFormState extends State<ProfilePrivacityForm> with CustomForm{

  Map<String, dynamic>? _initialValue;

  GlobalKey<CustomCheckBoxState>? _checkBoxConfirmKey = GlobalKey();
 
  void updateInitialValue(initialValue){
    setState((){
      _initialValue = initialValue;
    });
    if (_initialValue!['showProfile'] == true) _checkBoxConfirmKey!.currentState!.check();
  }

  @override
  void initState(){ 
    super.initState();

    setState((){
      _initialValue = widget.initialValue;
    });

    onFinalSubmit = _onFinalSubmit;
    onFinalSubmitError = _onFinalSubmitError;

    if( !mounted ) return;

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

  void _onFinalSubmit(){
    User user = new User();
    user.showProfile = _checkBoxConfirmKey!.currentState!.isChecked();
    submit(
      (){ 
        widget.feedback(user, "privacity").then((r){});
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
            margin: EdgeInsets.only(
              top: 10,
              bottom: 15,
              left: 5
            ),
            child: CustomCheckBox(
              key: _checkBoxConfirmKey,
              textSize: 15.6,
              boxColor: Colors.black.withOpacity(0.125),
              textColor: Colors.grey,
              checked: false,
              text: "Deixar meu perfil disponível"
            )
          ),
          ( widget.hideButtons != true ) 
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