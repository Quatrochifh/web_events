import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatMessage extends StatefulWidget {

  final String? messageType;

  final String message;

  final bool enabled;

  final Function? onClose;

  const FloatMessage({
    Key? key,
    this.onClose,
    required this.message,
    required this.enabled,
    this.messageType = 'attention'
  }) : super(key: key);

  @override
  FloatMessageState createState() => FloatMessageState();
}

class FloatMessageState extends State<FloatMessage>{

  Color _backgroundColor = attentionColor;
  Color _textColor      = Colors.black;
  bool _enabled         = true;

  void _closeMessage(){
    if(!mounted) return; 
    setState((){
      _enabled = false;
    });
    if (widget.onClose != null) {
      widget.onClose!();
    }
  }

  @override 
  void initState(){
    super.initState();
    
    _checkMessageType();
  }

  void _checkMessageType() {
    if(!mounted) return;

    if (widget.messageType != null ) {
      switch(widget.messageType!){
        case 'warning':
          _backgroundColor = warningColor;
          _textColor       = Colors.black;
        break;
        case 'success':
          _backgroundColor = successColor;
          _textColor       = Colors.black;
        break;
      }
    }
    setState((){
      _enabled         = widget.enabled;
      _textColor       = _textColor;
      _backgroundColor = _backgroundColor;
    });
  }

  @override
  void didUpdateWidget(p) {
    super.didUpdateWidget(p);

    _checkMessageType();
  }

  @override
  Widget build(BuildContext context) {

    if(!_enabled){
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: 85 + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: _backgroundColor,
        boxShadow: const [ darkShadow ],
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.black.withOpacity(0.125)
          )
        )
      ),
      child: SafeArea(
        bottom: false,
        child: Row( 
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10
              ),
              margin: EdgeInsets.all(0),
              child: Text(
                widget.message, 
                maxLines: 4,
                style: TextStyle( 
                  color: _textColor, 
                  fontSize: 16.6,
                  overflow: TextOverflow.ellipsis
                )
              )
            ),
          ),
          PrimaryButton(
            onClick: _closeMessage, 
            onlyIcon: true,
            noBorder: true,
            backgroundColor: Colors.transparent,
            width: 55,
            height: 55, 
            iconSize: 22.5,
            padding: noPadding,
            textColor: Colors.black.withOpacity(0.15),
            icon: FontAwesomeIcons.xmark,
          )
        ]
      )
    )
    );
  }
  
}