import 'dart:convert';
import 'dart:io'; 
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_message_fixed.dart';
import 'package:appweb3603/components/widget_photo_preview.dart';
import 'package:appweb3603/style.dart';  
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart'; 

class SubmitPhoto extends StatefulWidget{ 

  final Function? okCallback;

  final Function? cancelCallback;

  final String? photoBase64;

  SubmitPhoto({Key? key, this.photoBase64, this.okCallback, this.cancelCallback}) : super(key : key);

  @override
  SubmitPhotoState createState() => SubmitPhotoState();
}
 
class SubmitPhotoState extends State<SubmitPhoto>{ 
  
  @override
  Widget build(BuildContext context){
    return _Actions(
      photoBase64: widget.photoBase64,
      okCallback: widget.okCallback,
      cancelCallback: widget.cancelCallback
    );
  }
} 

class _Actions extends StatefulWidget{ 

  final Function? okCallback;

  final Function? cancelCallback;

  final String? photoBase64;

  _Actions( { Key? key, this.photoBase64, this.okCallback, this.cancelCallback } ) : super( key : key );

  @override
  _ActionsState createState() => _ActionsState();
}

class _ActionsState extends State<_Actions> {

  GlobalKey<PhotoPreviewState> _keyPhoto = new GlobalKey();
  GlobalKey<MessageFixedState> _keyMessageError = new GlobalKey();
 
  bool _waitingUpload = false;
  bool _imageSelected = false;
  bool _hasError = false;
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

  void _newPhoto() async{ 

    if(_waitingUpload == true){ 
      return;
    } 

    ImagePicker picker = ImagePicker();
    
    setState((){   
      _waitingUpload = true; 
      _base64File = null;
      _imageSelected = false;
      _hasError = false;
    });

     
    try{ 

      /*
        Tem imagens que não conseguimos fazer a seleção... 
        Neste caso, se o tempo de seleção for maior que 3s, sinal que houve algum erro mas sem retorno deste erro.
      */
      Future.delayed(Duration(seconds: 60), (){
        if( _waitingUpload == true && _imageSelected != true ){

          if( !mounted ) return;
 
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
    if( _waitingUpload == true ){ 
      return;
    } 
 
    setState((){    
      _keyPhoto.currentState!.removeImage();  
      _waitingUpload = false; 
      _base64File = null;
      _imageSelected = false;
    }); 
  } 

  @override
  Widget build( BuildContext context ){  
    return Column( 
          children: [ 
            Container(
              alignment:Alignment.bottomLeft,
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [   
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [  
                        ( _imageSelected == true || widget.photoBase64 != null ) ? 
                          PhotoPreview(imageUrl: (( widget.photoBase64 != null ) ?  Base64Decoder().convert(widget.photoBase64! ) : ""), key: _keyPhoto, height: 240)
                        : 
                          SizedBox.shrink(),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded( 
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryButton(
                                        height:55,
                                        padding: noPadding,
                                        icon: CupertinoIcons.folder,
                                        fontSize: 13,
                                        marginLeft: 5,
                                        marginRight: 5,
                                        onClick: _newGalery,
                                        title: "Adicionar da Galeria",
                                        textColor: primaryColor,
                                        backgroundColor: primaryColorLigther,
                                        onlyIcon: true,
                                      ),
                                    ),
                                    Expanded(
                                      child:PrimaryButton(
                                        height: 55,
                                        padding: noPadding,
                                        icon: CupertinoIcons.camera,
                                        fontSize: 13,
                                        marginLeft: 5,
                                        marginRight: 5,
                                        onClick: (_newCamera),
                                        title: "Adicionar da Câmera",
                                        textColor: primaryColor,
                                        backgroundColor: primaryColorLigther,
                                        onlyIcon: true,
                                      ), 
                                    )
                                  ],
                                )
                              ), 
                              (_imageSelected == true || widget.photoBase64 != null)
                              ?
                                PrimaryButton(
                                  width: 110,
                                  height:55,
                                  padding: noPadding,
                                  fontSize: 15,
                                  marginLeft: 5,
                                  marginRight: 5,
                                  onClick: _removePhoto,
                                  icon: CupertinoIcons.trash,
                                  title: "Remover",
                                  textColor: greyBtnCancelTextColor, backgroundColor: greyBtnCancelBackground,
                                  onlyIcon: true,
                                )
                              : 
                                SizedBox.shrink()
                            ],
                          )
                        )
                      ]
                    )
                  ),
                  (_imageSelected == true || widget.photoBase64 != null) 
                    ? 
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row( 
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // PrimaryButton(width: 130, backgroundColor: cancelColor, fontWeight: FontWeight.normal, icon: FontAwesomeIcons.arrowLeft,  padding: noPadding, title: "Cancelar", fontSize: 14, onClick:(){ widget.cancelCallback!( ); }),
                            Expanded(
                              child: PrimaryButton(height: 50, fontWeight: FontWeight.normal, icon: FontAwesomeIcons.check, padding: noPadding, title: "Concluir", fontSize: 17, onClick:(){ widget.okCallback!( _base64File ); })
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