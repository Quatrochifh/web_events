import 'dart:convert';
import 'dart:io'; 
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_message_fixed.dart';
import 'package:appweb3603/components/widget_photo_preview.dart';
import 'package:appweb3603/components/widget_profile_action_container.dart';
import 'package:appweb3603/style.dart';  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart'; 

class SubmitPhotoAvatar extends StatefulWidget{ 

  final Function? okCallback;

  final Function? cancelCallback;

  final String? photoBase64;

  SubmitPhotoAvatar({
    Key? key,
    this.photoBase64,
    this.okCallback,
    this.cancelCallback
  }) : super(key: key);

  @override
  SubmitPhotoAvatarState createState() => SubmitPhotoAvatarState();
}
 
class SubmitPhotoAvatarState extends State<SubmitPhotoAvatar>{ 
  
  @override
  Widget build(BuildContext context) {
    return _Actions(
      photoBase64: widget.photoBase64,
      okCallback: widget.okCallback,
      cancelCallback: widget.cancelCallback
    );
  }
} 

class _Actions extends StatefulWidget { 

  final Function? okCallback;

  final Function? cancelCallback;

  final String? photoBase64;

  _Actions({Key? key,
    this.photoBase64,
    this.okCallback,
    this.cancelCallback
  }) : super(key: key);

  @override
  _ActionsState createState() => _ActionsState();
}

class _ActionsState extends State<_Actions> {

  GlobalKey<PhotoPreviewState> _keyPhoto = new GlobalKey();
  GlobalKey<MessageFixedState> _keyMessageError = new GlobalKey();
 
  bool _waitingUpload = false;
  bool _imageSelected = false;
  bool _hasError = false;
  bool _showOptionsUpload = true;
  bool _sourceCamera = false;

  String? _base64File;

  @override
  void initState(){
    super.initState();   
  }

  void _newCamera() {
    setState(() {
      _sourceCamera = true;
    });
    _newPhoto();
  }

  void _newGalery() {
    setState(() {
      _sourceCamera = false;
    });
    _newPhoto();
  }

  void _newPhoto() async { 

    if(_waitingUpload == true){ 
      return;
    }

    ImagePicker picker = ImagePicker();
    
    setState((){   
      _waitingUpload = true; 
      _base64File = null;
      _imageSelected = false;
      _hasError = false;
      _showOptionsUpload = false;
    });

     
    try{
      /*
        Tem imagens que não conseguimos fazer a seleção... 
        Neste caso, se o tempo de seleção for maior que 3s, sinal que houve algum erro mas sem retorno deste erro.
      */
      Future.delayed(Duration(seconds: 60), (){
        if( _waitingUpload == true && _imageSelected != true ){

          if(!mounted) return;
          if (_keyMessageError.currentState == null) return;
          setState((){
            _imageSelected = false; 
            _waitingUpload = false; 
            _hasError = true;
            _keyMessageError.currentState!.show();
          }); 
          
        }
      });

      if (_sourceCamera) {
        await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 35
        ).then((pickedFile) {
          if(pickedFile != null){  

            File file = File(pickedFile.path);
            
            _base64File = base64Encode(file.readAsBytesSync());  

            setState((){
              _imageSelected = true;
            });

            Future.delayed(Duration(seconds: 1), (){  
              if (!mounted) return;

              setState((){
                _keyPhoto.currentState!.updateImage(file); 
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
      } else {
        await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 35
        ).then((pickedFile){
          if( pickedFile  != null ){  

            File file = File(pickedFile.path);
            
            _base64File = base64Encode(file.readAsBytesSync());  

            setState((){
              _imageSelected = true;
            });

            Future.delayed(Duration(seconds: 1), (){  
              if ( !mounted ) return;

              setState((){
                _keyPhoto.currentState!.updateImage(file); 
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
      }
    }catch(e){
      if (!mounted) return;
      setState((){
        _imageSelected = false; 
        _waitingUpload = false; 
      });
    }
  }

  void _removePhoto(){
    if(_waitingUpload == true) {
      return;
    } 
 
    setState((){    
      _keyPhoto.currentState!.removeImage();  
      _waitingUpload = false; 
      _base64File = null;
      _imageSelected = false;
      _showOptionsUpload = true;
    });
  }

  @override
  Widget build(BuildContext context) {  
    return Column( 
      children: [
        Container(
          alignment:Alignment.bottomLeft,
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [   
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 30),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [  
                    //( _imageSelected == true || widget.photoBase64 != null ) ?
                      ProfileActionContainer(
                        onTap: () {
                          setState(() {
                            _showOptionsUpload = true;
                          });
                        },
                        distanceBottom: const [0, 0],
                        icon: FontAwesomeIcons.camera,
                        buttonSize: const [50, 50],
                        child: PhotoPreview(
                          borderRadius: 200,
                          imageUrl: ((widget.photoBase64 != null) ? Base64Decoder().convert(widget.photoBase64!) : "assets/images/default_avatar.png"),
                          key: _keyPhoto,
                          width: 230,
                          height: 230
                        )
                      ),
                      /*PhotoPreview(
                        borderRadius: 200,
                        imageUrl: ((widget.photoBase64 != null) ? Base64Decoder().convert(widget.photoBase64!) : ""),
                        key: _keyPhoto,
                        width: 230,
                        height: 230
                      )*/
                    //: 
                      //SizedBox.shrink(),
                    (_showOptionsUpload == true)
                    ?
                      Container(
                        width: 160,
                        height: 60,
                        margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.all(3.5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black.withOpacity(0.125)
                          ),
                          borderRadius: BorderRadius.circular(100),
                          color: primaryColorLigther
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded( 
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      height:35,
                                      padding: noPadding,
                                      icon: CupertinoIcons.folder,
                                      fontSize: 12,
                                      marginLeft: 2.5,
                                      marginRight: 2.5,
                                      onClick: _newGalery,
                                      title: "Galeria",
                                      textColor: primaryColor,
                                      backgroundColor: Colors.transparent,
                                      onlyIcon: true,
                                    ),
                                  ),
                                  Expanded(
                                    child:PrimaryButton(
                                      height: 35,
                                      padding: noPadding,
                                      icon: CupertinoIcons.camera,
                                      fontSize: 12,
                                      marginLeft: 2.5,
                                      marginRight: 2.5,
                                      onClick: (_newCamera),
                                      title: "Tirar Foto",
                                      textColor: primaryColor,
                                      backgroundColor: Colors.transparent,
                                      onlyIcon: true,
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        )
                      )
                    :
                      SizedBox.shrink()
                  ]
                )
              ),
              (_showOptionsUpload != true && (_imageSelected == true || widget.photoBase64 != null)) 
                ? 
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(top: 50),
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (_imageSelected == true || widget.photoBase64 != null)
                          ?
                            PrimaryButton(
                              width: 150,
                              height: 55,
                              padding: noPadding,
                              fontSize: 15,
                              marginLeft: 5,
                              marginRight: 5,
                              borderRadius: 100,
                              onClick: _removePhoto,
                              icon: CupertinoIcons.trash,
                              title: "Remover",
                              textColor: greyBtnCancelTextColor,
                              backgroundColor: greyBtnCancelBackground
                            )
                          : 
                            SizedBox.shrink(),
                        Expanded(
                          child:PrimaryButton(
                            width: 150,
                            height: 55,
                            padding: noPadding,
                            fontSize: 15,
                            marginLeft: 5,
                            marginRight: 5,
                            borderRadius: 100,
                            fontWeight: FontWeight.normal,
                            icon: FontAwesomeIcons.check,
                            title: "Selecionar",
                            onClick:(){
                              widget.okCallback!(_base64File);
                            }
                          )
                        )
                      ]
                    ),
                  )
                :
                  SizedBox.shrink()
            ],
          )
        ),
        ( _waitingUpload == true ) ?
          LoadingBlock(transparent: true,)
        :
          SizedBox.shrink()
      ] 
    );
  }
  
}

class Header extends StatelessWidget{

  final String title;

  Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 25), 
      child: Text(
        title, 
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        )
      )
    );
  }
}