import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListLinks extends StatefulWidget{ 

  final Map<String, String> sections;

  final bool? inline;

  final bool? clean;

  final Color? textColor;

  final double? fontSize;

  final Color? backgroundColor;

  final bool? safeArea;

  final MainAxisAlignment? mainAxisAlignment;


  ListLinks({ Key? key, this.safeArea, this.backgroundColor, this.mainAxisAlignment, this.fontSize, this.textColor, required this.sections, this.inline, this.clean }) : super( key: key );

  @override
  ListLinksState createState() => ListLinksState();
}

class ListLinksState extends State<ListLinks>{  

  List<Widget> _sections = [];

  @override 
  void initState(){ 
    super.initState();

    if( !mounted ) return;  

    widget.sections.forEach((k, v){
      _sections.add(ListLink(title: k, url: v, borderBottom: true, inline: widget.inline, clean: widget.clean, fontSize: widget.fontSize, textColor: widget.textColor, ));
    });

  }

  @override 
  Widget build( BuildContext context ){ 

    return 
        Container( 
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(0),  
          decoration: BoxDecoration( 
            color: widget.backgroundColor ?? Colors.transparent,  
          ),
          child: SafeArea( 
              top: widget.safeArea ?? false, 
              bottom: widget.safeArea ?? false,  
              child:
                widget.inline == true 
                  ?  
                    Row( 
                      mainAxisAlignment:  widget.mainAxisAlignment ?? MainAxisAlignment.start,
                      children: _sections
                    )
                  : 
                    Column( 
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _sections
                    )
          )
        );
  }

}
 

class ListLink extends StatelessWidget{ 

  final String title;

  final String url;

  final bool? borderBottom;

  final IconData? icon;

  final bool? inline;

  final bool? clean; 

  final Color? textColor;

  final double? fontSize;

  ListLink({
    Key? key,
    this.fontSize,
    this.textColor,
    this.inline,
    this.clean,
    required this.title,
    required this.url,
    this.icon,
    this.borderBottom = false
  })
  :
  super(key: key);

  @override 
  Widget build(BuildContext context) {
    return 
      InkWell(  
        child: Container(  
          constraints: BoxConstraints( 
            minHeight: clean == true ? 30 : 60
          ),
          margin: clean == true  ? EdgeInsets.all(2.5)  : EdgeInsets.all(15), 
          padding: clean == true  ? EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 6)  : EdgeInsets.all(5), 
          decoration: BoxDecoration( 
            color: clean == true ? Colors.transparent : Colors.white,   
            border: clean == true ? null : Border.all(width: 0.5, color: grey105Color )
          ),
          child: 
          (inline == true)  ? 
            Row( 
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ 
                (icon != null) ?
                  Container(
                    margin: EdgeInsets.only(
                      right: 10
                    ),
                    child: Icon(
                      icon,
                      size: 35
                    ),
                  ) 
                : 
                  SizedBox.shrink(),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: fontSize ?? 18,
                    fontWeight: FontWeight.bold
                  )
                ),
              ],
            )
          :
            Stack( 
              alignment: AlignmentDirectional.centerStart,
              children: [ 
                Row( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ 
                    ( icon != null ) ?
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          icon,
                          size: 35,
                          color: textColor ?? Colors.black
                        )
                      ) 
                    : 
                      SizedBox.shrink(),
                    Expanded( 
                      child: Text(
                        title,
                        softWrap: true,
                        maxLines: 5,
                        style: TextStyle(
                          color: textColor ?? Colors.black,
                          fontSize: fontSize ?? 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis
                        )
                      ),
                    )
                  ],
                ),  
              ],
            )
        ), 
        onTap: (){  
          try{
            launch(Uri.decodeFull(url));
          } catch(e) {
            debugPrint("...");
          }
        },
      );
      
  
  }

}