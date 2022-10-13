import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class FloatScreen extends StatefulWidget{ 

  final bool actived;

  final String? title;

  final Widget? child;

  final Function onClose;

  final Color? backgroundColor;

  final Color? headerItemColor;

  FloatScreen({Key? key, this.headerItemColor, this.backgroundColor, required this.onClose, required this.actived, this.title, this.child}) : super(key: key);

  @override
  FloatScreenState createState() => FloatScreenState();
}
 
class FloatScreenState extends State<FloatScreen>{  

  @override
  void initState(){ 
    super.initState();

    if ( !mounted ) return; 
  } 
  
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context){
    return AnimatedPositioned( 
        curve: Curves.fastOutSlowIn,
        duration: Duration(microseconds: 500000),
        bottom: widget.actived == true ? 0 : - MediaQuery.of(context).size.height,  
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width, 
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration( 
            color: widget.backgroundColor ?? Colors.transparent,
            border: Border.all(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              width: 0.6
            )
          ),
          child: SafeArea(
            top: widget.backgroundColor == null ? false : true,
            bottom: false,
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.only(
                top: widget.backgroundColor != null ? 0 : (templateHeaderHeigth + 100),
                left: 5,
                right: 5
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                boxShadow: widget.backgroundColor == null ? const [darkShadow, ligthShadow] : null,
                border: widget.backgroundColor == null ? 
                  Border.all(
                    width: 0.5,
                    color: Colors.black.withOpacity(0.125)
                  )
                :
                  null
              ),
              child: Stack(
                children: [ 
                  Container( 
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 7,
                      top: 57
                    ),
                    constraints: BoxConstraints( 
                      minHeight: 50, 
                    ),
                    decoration: BoxDecoration( 
                      color: widget.backgroundColor == null ? Colors.white : Colors.transparent,
                    ),
                    child: ListView( 
                      padding: noPadding,
                      children: [widget.child ?? SizedBox.shrink()],
                    ),
                  ),
                  Container( 
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 7,
                      top: 7
                    ),
                    constraints: BoxConstraints( 
                      minHeight: 50, 
                    ),
                    decoration: BoxDecoration( 
                      color: Colors.transparent,
                    ),
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title ?? "",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 22,
                              color: widget.headerItemColor ?? Colors.black, 
                              fontWeight: FontWeight.bold, 
                              overflow: TextOverflow.ellipsis
                            )
                          ),
                        ),
                        PrimaryButton(
                          width: 35, 
                          height: 35, 
                          padding: noPadding,
                          borderRadius: 35,
                          onClick: (){ widget.onClose(); },
                          noBorder: true,
                          backgroundColor: Color.fromARGB(255, 233, 233, 233),
                          textColor: widget.headerItemColor ?? Colors.black26,
                          fontSize: 9,
                          onlyIcon: true,
                          icon: FontAwesomeIcons.xmark
                        ),
                      ],
                    ),  
                  ),
                ],
              ),
            )
          ),
        )
    );
  }

}