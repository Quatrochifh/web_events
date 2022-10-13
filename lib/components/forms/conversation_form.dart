import 'dart:convert';
import 'dart:io';
import 'package:appweb3603/utils/Permissions.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart'; 
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_message_fixed.dart';
import 'package:appweb3603/components/widget_photo_preview.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ConversationForm extends StatefulWidget{ 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final Map<String, dynamic>? initialValue; 

  ConversationForm({Key? key, this.initialValue, this.hideButtons, required this.feedback, required this.cancelOnclick}) : super(key: key);

  @override
  ConversationFormState createState() => ConversationFormState();
} 

class ConversationFormState extends State<ConversationForm> with CustomForm{

  GlobalKey<PhotoPreviewState> _keyPhoto = new GlobalKey();
  GlobalKey<MessageFixedState> _keyMessageError = new GlobalKey();
  bool _waitingUpload = false;
  bool _imageSelected = false;
  String? _base64File;
 
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

    if(!mounted) return; 

    setState((){ 
      formFocus = formFocus;
      formKeys = formKeys;
    });
  }
  
  void _onFinalSubmitError(error){ 

    if(!mounted) return; 

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

    submit(
      (){ 
        widget.feedback(
          message: msg,
          attachment: _base64File
        ).then((r){
          if( r != true && r != null ){
          } else {
            formKeys['msg']!.currentState!.inputController().text = "";
            if (_imageSelected == true) {
              _imageSelected = false;
              _base64File = null;
            }
          }
        });
      }
    );
  }

  void _newPhoto() async{ 

    if( _waitingUpload == true ){ 
      return;
    }

    bool hasPermission = await Permissions.checkGalleryPermission().then((permission){
      if (permission != true) {
        return Permissions.requestGalleryPermission().then((results){
          if (results != PermissionStatus.granted) {
            showNotification(message: "Acesse as configurações e permita o acesso à Galeria.");
            return false;
          }
          return false;
        });
      }
      return true;
    });

    if (hasPermission != true) return;

    ImagePicker picker = ImagePicker();
    
    setState((){   
      _waitingUpload = true; 
      _base64File = null;
      _imageSelected = false;
    });

     
    try{ 

      /*
        Tem imagens que não conseguimos fazer a seleção... 
        Neste caso, se o tempo de seleção for maior que 3s, sinal que houve algum erro mas sem retorno deste erro.
      */
      Future.delayed(Duration(seconds: 60), (){
        if( _waitingUpload == true && _imageSelected != true ){

          if( mounted) return;
 
          setState((){
            _imageSelected = false;
            _waitingUpload = false;
            _keyMessageError.currentState!.show();
          }); 
          
        }
      });

      await picker.pickImage(source: ImageSource.gallery, imageQuality: 5).then((pickedFile) async { 
        if( pickedFile  != null ){

          File file = File(pickedFile.path);
          
          _base64File = base64Encode(file.readAsBytesSync());  

          setState((){
            _imageSelected = true;
          });

          Future.delayed(Duration(milliseconds: 500), (){  
            if (!mounted) return;

            setState((){
              // _keyPhoto.currentState!.updateImage(file); 
              _waitingUpload = false; 
            });  
          });
          
        }else{  
          setState((){
            _imageSelected = false; 
            _waitingUpload = false; 
          }); 
        }
      });
    }catch( e ){
      if ( !mounted ) return;
      setState((){
        _imageSelected = false; 
        _waitingUpload = false; 
      }); 
      debugPrint( e.toString() );
    }
  }
  

  @override
  Widget build( BuildContext context ){  
    return  Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageSelected != true
              ?
                PrimaryButton(
                  onClick: _newPhoto,
                  width: 45,
                  height: 45,
                  onlyBorder: true,
                  borderColor: Colors.transparent,
                  icon: CupertinoIcons.camera,
                  textColor: primaryColor
                )
              :
                Container(
                  margin: EdgeInsets.only(
                    right: 15,
                    left: 5,
                  ),
                  width: 45,
                  height: 45,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: CustomImage(
                    key: _keyPhoto,
                    image: Base64Decoder().convert(_base64File!),
                    width: 45,
                    height: 45,
                    fit: BoxFit.contain,
                  ),
                ),
              Expanded(
                child: Input(
                  margin: EdgeInsets.only(
                    left: 5,
                    right: 5
                  ),
                  fontSize: 14,
                  borderRadius: 50,
                  backgroundColor: Colors.black.withOpacity(0.125),
                  borderColor: Colors.transparent,
                  focusNode: formFocus['msg'],
                  textColor: Colors.black,
                  formSubmitFunction: onSubmitFunction,
                  key: formKeys['msg'],
                  initialValue: widget.initialValue == null ? "" : widget.initialValue!['firstName'],
                  validatorFunction: (){ },
                  labelColor: Colors.black38,
                  height: 45,
                  hintColor: Colors.black.withOpacity(0.125),
                  hintText: "Sua mensagem ..."
                ),
              ),
              PrimaryButton(
                onClick: _onFinalSubmit,
                width: 45,
                height: 45,
                onlyBorder: true,
                borderColor: Colors.transparent,
                icon: FontAwesomeIcons.paperPlane,
                textColor: primaryColor
              )
            ]
          ),
        ],
      )
    );
  }

}