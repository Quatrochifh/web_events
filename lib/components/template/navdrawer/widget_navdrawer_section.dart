import 'package:appweb3603/components/buttons/widget_button_chiclete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

class NavDrawerSection extends StatefulWidget{ 

  final bool? visibility;

  final String? title;

  final List<Widget> children;

  final double? height;

  NavDrawerSection( { Key? key, this.height, this.visibility, this.title, required this.children } ) : super( key : key );

  @override
  NavDrawerSectionState createState() => NavDrawerSectionState();
  
}
 

class NavDrawerSectionState extends State<NavDrawerSection>{   

  bool _sectionVisible = false;

  void _changeVisibility(){
    if(!mounted) return; 

    setState((){
      _sectionVisible =  _sectionVisible ? false : true;
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

    return Container( 
        padding: EdgeInsets.all(10),
        width: double.infinity, 
        height: widget.height ?? ((widget.title != null) ? 90 : 0) + (widget.children.length * (_sectionVisible == true ? 50 : 0)) ,
        decoration: BoxDecoration(  
          border: Border( 
            //bottom: BorderSide( color: Color.fromRGBO(0, 0, 0, 0.125), width: 0.5 ), 
            //top: BorderSide( color: Color.fromRGBO(0, 0, 0, 0.125), width: 0.5 ) 
          )
        ),
        child: Column( 
          children: <Widget>[ 
            ( widget.title != null ) 
              ?
                Container( 
                  padding: EdgeInsets.all(5),
                  child: Row( 
                    children: [ 
                      Expanded( 
                        child: Text( 
                          widget.title!, 
                          style: TextStyle( 
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13, 
                            color: Colors.grey
                          ),
                        )
                      ),
                      ButtonChiclete( onClick: _changeVisibility , icon: _sectionVisible ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_up  , iconColor: Colors.grey, )
                    ],
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
                  child: 
                    Container( 
                      decoration: BoxDecoration( 
                        borderRadius: BorderRadius.circular(2)
                      ),
                      child: Column(
                        children: widget.children , 
                      ),
                    clipBehavior: Clip.antiAlias,
                  ) 
                )
              
              ]
            : 
              [ SizedBox.shrink() ] 
            ),
        ), 
    );

  }

}