import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart'; 
import 'package:appweb3603/components/forms/custom_form.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/entities/User.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';

class VideoCommentForm extends StatefulWidget { 

  final Function cancelOnclick;

  final Function feedback;

  final bool? hideButtons;

  final User user;

  final Map<String, dynamic>? initialValue; 

  VideoCommentForm({
    Key? key,
    this.initialValue,
    this.hideButtons,
    required this.feedback,
    required this.user,
    required this.cancelOnclick
  }) : super(key: key);

  @override
  VideoCommentFormState createState() => VideoCommentFormState();
} 

class VideoCommentFormState extends State<VideoCommentForm> with CustomForm {

  bool _showSubmitButton = false;

  bool _publishing = false;

  TextEditingController? _inputController;

  @override
  void initState() {
    super.initState(); 

    formKeys = { 
      'comment' : GlobalKey(), 
    };

    formFocus = { 
      'comment' : FocusNode(), 
    };

    onFinalSubmit = _onFinalSubmit;

    if(!mounted) return; 

    setState((){ 
      formFocus = formFocus; 
      formKeys = formKeys; 
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (formKeys['comment'] == null || formKeys['comment']!.currentState == null) {
        debugPrint("Está com valor NULL");
        return;
      }
      _inputController = formKeys['comment']!.currentState!.inputController();
      _inputController!.addListener(_onTapping);
    });
  }

  void _onTapping() {
    if (formKeys['comment']!.currentState!.getCurrentLenght() > 0) {
      setState(() {
        _showSubmitButton = true;
      });
    } else if (formKeys['comment']!.currentState!.getCurrentLenght() < 1){
      setState(() {
        _showSubmitButton = false;
      });
    }
  }

  void _onFinalSubmit() {

    String comment = formKeys['comment']!.currentState!.inputController().text; 
     
    if(comment.length < 3 || comment.length > 1000) {
      showAlert(
        title: "Oops!",
        message: "Seu comentário deve ter entre 3 e 1000 caracteres!"
      );
      return;
    }

    setState(() {
      _publishing = true;
    });

    submit(
      (){ 
        widget.feedback( 
          comment: comment 
        ).then((error) {
          setState(() {
            _publishing = false;
          });
          Future.delayed(Duration(milliseconds: 50), () {
            if(error != true && error != null) {
              showAlert(
                title: "Falha ao publicar comentário",
                message: error.runtimeType.toString() == "bool" ? "Houve um erro ao efetuar a publicação do comentário. \n Tente novamente mais tarde." : error
              );
            } else {
              showNotification(
                message: "Comentário publicado!",
                type: "success"
              );
              setState((){
                formKeys['comment']!.currentState!.inputController().text = "";
              });
            }

            setState((){
              _showSubmitButton = false;
            });

            Future.delayed(Duration(milliseconds: 50), () {
              _inputController = formKeys['comment']!.currentState!.inputController();
              _inputController!.addListener(_onTapping);
            });
          });
        });
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: _showSubmitButton == false ? 45 : 125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                child: Avatar(
                  width: 43,
                  height: 43,
                  avatar: widget.user.avatar,
                  borderColor: Colors.transparent,
                )
              ),
              Expanded(
                child:
                (!_publishing)
                  ?
                    Container(
                      margin: EdgeInsets.all(0),
                      child: Input(
                        maxLines: 5,
                        margin: EdgeInsets.only(
                          left: 5,
                          right: 5
                        ),
                        fontSize: 19.5,
                        backgroundColor: Colors.transparent,
                        borderRadius: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        focusNode: formFocus['comment'],
                        textWeight: FontWeight.bold,
                        textColor: Colors.black,
                        formSubmitFunction: onSubmitFunction,
                        key: formKeys['comment'],
                        initialValue: widget.initialValue == null ? "" : widget.initialValue!['firstName'],
                        validatorFunction: (){ },
                        labelColor: Colors.black38,
                        height: _showSubmitButton == false ? 45 : 80,
                        hintColor: Colors.black26,
                        hintText: "${widget.user.name}, digite seu comentário ... "
                      ),
                    )
                  :
                    LoadingBlock(
                      transparent: true,
                      inline: true,
                      imageSize: 25,
                      textColor: Colors.grey,
                      text: "Publicando comentário ..."
                    )
              )
            ]
          ),
          (_showSubmitButton && !_publishing)
            ?
              PrimaryButton(
                onClick: _onFinalSubmit,
                width: 120,
                height: 35,
                fontSize: 13.5,
                iconSize: 12,
                fontWeight: FontWeight.w200,
                title: "Publicar",
                borderRadius: 5,
                backgroundColor: primaryColor,
                textColor: Colors.white,
                iconRight: true,
                icon: CupertinoIcons.arrow_right
              )
            :
              SizedBox.shrink()
        ]
      )
    );
  }

}