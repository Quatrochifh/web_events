import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class ViewHeader extends StatefulWidget{

  final String title;

  final Function? callback;  

  ViewHeader({Key? key, required this.title, required this.callback}) : super(key: key);

  @override
  ViewHeaderState createState() => ViewHeaderState();
}

class ViewHeaderState extends State<ViewHeader>{ 

  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;  

  @override
  void initState(){ 
    super.initState(); 
  }

  @override
  Widget build( BuildContext context ){
    return Container( 
      padding: EdgeInsets.all(12), 
      alignment: Alignment.center,
      child: Row( 
        children: [
          ( widget.callback != null )
          ?
          Expanded( 
            flex: 1,
            child: Container( 
              margin: EdgeInsets.zero,
              constraints: BoxConstraints( 
                maxWidth: 30,
                maxHeight: double.infinity
              ),
              child: ClipRRect( 
                  child: IconButton( 
                  padding: EdgeInsets.only( right:15), 
                  icon: Icon( Icons.arrow_back_ios , size: 22 ), 
                  color: Colors.white,
                  onPressed: () => {   
                    widget.callback!()
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ), 
              ),
              color: Colors.transparent
            )
          )
          : 
          SizedBox.shrink(),
          
          Expanded( 
            flex: 6,
            child:
            Text( 
              widget.title, 
              style: TextStyle( 
                fontSize: 18,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            )
          )
        ]
      ), 
      decoration: BoxDecoration(  
        color: primaryColor
      )
    );
    
  }
}