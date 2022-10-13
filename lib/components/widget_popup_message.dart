import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PopUpMessage extends StatefulWidget{  

  final String text;   

  final String title;   

  final Color? bgColor;

  final Color? textColor;

  final IconData? icon;

  final Function okCallback;

  final bool showCancelButton;

  final Function? cancelCallback;

  final String? successBtnText;

  final String? cancelTitle;

  PopUpMessage({
    Key? key,
    required this.title,
    this.successBtnText,
    this.showCancelButton = false,
    required this.okCallback,
    this.icon,
    this.bgColor,
    this.textColor,
    required this.text,
    this.cancelCallback,
    this.cancelTitle
  }) : super(key: key);

  @override
  PopUpMessageState createState() => PopUpMessageState();
}


class PopUpMessageState extends State<PopUpMessage>{  

  @override
  Widget build(BuildContext context) {  
    return   Container(  
        width: MediaQuery.of(context).size.width * 0.75, 
        alignment: Alignment.topCenter,
        constraints: BoxConstraints( 
          minHeight: 40,
          maxHeight: 230, 
        ), 
        child: Stack( 
          children: [
            Container( 
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(  
                color: Colors.white, 
                border: Border.all(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.25)),
                borderRadius: BorderRadius.circular(10)
              ), 
              padding: EdgeInsets.only( 
                top: 30, 
                bottom: 10, 
                left: 20, 
                right: 20
              ),
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Container(
                    padding: EdgeInsets.all(2.5),
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: Text( 
                      widget.title, 
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyle( 
                        fontSize: 16.7,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: widget.textColor ?? Colors.black54,
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle( 
                          fontSize: 16.7,
                          overflow: TextOverflow.ellipsis,
                          color: widget.textColor ?? Colors.black54,
                        )
                      )
                    )
                  ), 
                  Container(
                    alignment:Alignment.bottomLeft, 
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (widget.showCancelButton) 
                          ?
                            PrimaryButton(
                              width: 90,
                              title: widget.cancelTitle ?? "Cancelar",
                              fontSize: 16,
                              height: 40,
                              padding: noPadding,
                              backgroundColor: Color.fromARGB(255, 233, 233, 233),
                              textColor: Colors.black,
                              borderRadius: 100,
                              onClick: () {
                                if (widget.cancelCallback != null) widget.cancelCallback!();
                              }
                            )
                          :
                            SizedBox.shrink(),
                        PrimaryButton(
                          width: 160,
                          title: widget.successBtnText ?? "Ok",
                          height: 40,
                          fontSize: 17,
                          padding: noPadding,
                          onClick: widget.okCallback,
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                          borderRadius: 100,
                        )
                      ],
                    )
                  )
                ] 
              )
            ),
            (widget.icon != null)
              ? 
                Positioned( 
                  top: 0, 
                  left: 0, 
                  right: 0, 
                  child: Container(  
                    alignment: Alignment.center,
                    child: Container( 
                      width: 65, 
                      height: 65, 
                      decoration: BoxDecoration( 
                        color: primaryColor, 
                        borderRadius: BorderRadius.circular(100)
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Icon(
                        widget.icon,
                        size: 45,
                        color: widget.textColor ?? Colors.white
                      )
                    ) 
                  ) 
                )
              :
                SizedBox.shrink() 
          ]
        ), 
         
      );
  }
}