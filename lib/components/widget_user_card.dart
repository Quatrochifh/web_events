import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/helpers.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class UserCard extends StatefulWidget{ 

  final User user;

  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  UserCardState createState() => UserCardState();
}

class UserCardState extends State<UserCard>{ 

  @override 
  Widget build( BuildContext context ){
 
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        navigatorPushNamed(context, '/view-user', arguments: { 'user' : widget.user });
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
          right: 15
        ),
        margin: EdgeInsets.only( 
          top: 5,
          left: 10, 
          right: 10
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderMainRadius,
          border: Border.all(
            color: bgWhiteBorderColor,
            width: 0.5
          )
        ),
        child: Row( 
          children: [ 
            Avatar(
              onClick: (){
                navigatorPushNamed(context, '/view-user', arguments: { 'user' : widget.user });
              },
              borderRadius: 100,
              width: 55, 
              height: 55,
              avatar: widget.user.avatar, 
              borderColor: Color.fromRGBO(0, 0, 0, 0.08),  
            ), 
            Expanded( 
              child: Container( 
                margin: EdgeInsets.only(
                  left: 15
                ),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container( 
                      margin: noMargin,
                      child: Row( 
                        children: [ 
                          Text(
                            widget.user.name,  
                            maxLines: 1, 
                            style: TextStyle( 
                              fontSize: 22,
                              fontWeight: FontWeight.bold, 
                              color: Colors.black, 
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ]
                      )
                    ),
                    ( widget.user.company.isNotEmpty ) 
                      ?
                        Wrap( 
                          children: [
                            Text(
                              widget.user.role, 
                              style: TextStyle(
                                color: Colors.grey, 
                                fontSize: 13
                              ),
                            ),
                            Text(
                              " na empresa ", 
                              style: TextStyle(
                                color: Colors.grey, 
                                fontSize: 13
                              ),
                            ),
                            Text(
                              widget.user.company, 
                              style: TextStyle(
                                color: Colors.grey, 
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ] 
                        )
                      : 
                        SizedBox.shrink()
                    ,
                  ]
                ) 
              )
            ), 
          ],
        )
      )
    );
  }

}