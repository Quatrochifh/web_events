
import 'package:appweb3603/entities/Link.dart' as elink;
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; 

class Link extends StatelessWidget { 

  final IconData? icon;

  final elink.Link link;

  Link({
    Key? key,
    this.icon,
    required this.link
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) { 
    return InkWell(
      onTap: () async { 
        try{
          await launch(link.url); 
        }catch(e) {
          debugPrint(e.toString()); 
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity, 
        constraints: BoxConstraints( 
          maxHeight: 120,  
        ),
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        decoration: BoxDecoration( 
          color: Colors.white, 
          border: Border.all( width: 0.4, color: Color.fromRGBO(0, 0, 0, 0.1) ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ 
            Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              height: 200,
              width: 60,
              color: Colors.grey.withOpacity(0.125),
              child: icon != null ? FaIcon(icon, color: Colors.black, size: 35) : FaIcon(CupertinoIcons.link, color: Colors.black, size: 35)
            ), 
            Expanded(  
              child:  
              Container(  
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only( bottom: 12 ),
                      child: Text(
                        link.title,
                        style: titleS3Style,
                        maxLines: 1, 
                      ), 
                    ),
                    SizedBox(
                      child: Text(
                        link.description, 
                        style: TextStyle( 
                          fontSize: 14, 
                          color: Colors.grey, 
                          overflow: TextOverflow.ellipsis 
                        ),
                        maxLines: 2,
                      ), 
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        dateTimeFormat(link.dateRegister), 
                        style: TextStyle(
                          fontSize: 12,  
                          overflow: TextOverflow.ellipsis 
                        ),
                        maxLines: 1,
                      ), 
                    ),
                  ],
                )
              )
            ), 
            Container(
              alignment: Alignment.center,
              height: 45,
              width: 45,  
              child: FaIcon( CupertinoIcons.chevron_right , color: Colors.grey )
            ), 
          ],
        ),
      ),
    );
  }

}