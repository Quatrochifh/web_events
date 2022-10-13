import 'package:appweb3603/components/buttons/widget_button_chiclete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

class Section extends StatefulWidget{ 

  final bool? visibility;

  final String? title;

  final List<Widget> children;

  final double? height;

  final double? titleSize;

  final IconData? icon;

  Section( { Key? key, this.icon, this.titleSize, this.height, this.visibility, this.title, required this.children } ) : super( key : key );

  @override
  SectionState createState() => SectionState();
  
}
 

class SectionState extends State<Section>{   

  bool _sectionVisible = false;

  void _changeVisibility(){
  //  if(!mounted) return; 

    setState((){
      _sectionVisible =  _sectionVisible ? false : true ;
    });
  }

  @override
  void initState(){
    super.initState();

    if( !mounted ) return;


    setState((){  
      _sectionVisible = widget.visibility ?? false; 
    }); 

  }

  @override
  Widget build( BuildContext context ){ 

    return SizedBox( 
        child: Container( 
          padding: EdgeInsets.all(10),
          width: double.infinity, 
          height: widget.height != null ? !_sectionVisible ? 70 : widget.height : !_sectionVisible ? 70 : ( ( widget.title != null ) ? 70 : 0 ) +  MediaQuery.of(context).size.height,
          decoration: BoxDecoration(  
            border: Border( 
              bottom: BorderSide( color: Color.fromRGBO(0, 0, 0, 0.125), width: 0.5 ), 
              //top: BorderSide( color: Color.fromRGBO(0, 0, 0, 0.125), width: 0.5 ) 
            )
          ),
          child: Column( 
            children: <Widget>[ 
              ( widget.title != null ) 
                ?
                  InkWell( 
                    onTap: _changeVisibility,
                    child: Container( 
                      padding: EdgeInsets.all(5),
                      child: Row( 
                        children: [ 
                          Container( 
                            width: 35, 
                            height: 35,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration( 
                              borderRadius: BorderRadius.circular(100),
                             // color: Colors.grey.withOpacity(0.14), 
                             // border: Border.all( width: 0.5, color: Colors.black.withOpacity(0.1) )
                            ),
                            child: Icon(widget.icon, size: 26, color: Colors.black),
                          ),
                          Expanded( 
                            child: Text( 
                              widget.title!, 
                              style: TextStyle( 
                                overflow: TextOverflow.ellipsis,
                                fontSize: widget.titleSize ?? 13, 
                                color: Colors.black
                              ),
                            )
                          ),
                          ButtonChiclete(size: 25, onClick: _changeVisibility , icon: _sectionVisible ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_up, bgColor: Colors.grey.withOpacity(0.2), iconColor: Colors.grey, )
                        ],
                      )
                    )
                  )
                : 
                  SizedBox.shrink()
            ] + 
            ( 
              _sectionVisible == true
              ? 
                [ 
                  Expanded( 
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      child: Column(
                        children: widget.children,
                      ),
                    ) 
                  )
                
                ]
              : 
                [ SizedBox.shrink() ] 
              ),
          ), 
        )
    );

  }

}