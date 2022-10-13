import 'package:appweb3603/entities/User.dart';
import 'package:flutter/material.dart';

import 'widget_navdrawer_avatar.dart';

class NavDrawerHeader extends StatefulWidget{ 

  final User user;

  NavDrawerHeader({Key? key, required this.user}) : super(key: key);

  @override
  NavDrawerHeaderState createState() => NavDrawerHeaderState();
  
}
 

class NavDrawerHeaderState extends State<NavDrawerHeader>{

  @override
  Widget build( BuildContext context ){
    return  Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration( 
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.125),
            width: 0.5
          )
        )
      ),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [ 
          /*ActionContainer(
            onTap: (){
              Navigation.changeToEditProfile(context);
            },
            iconSize: 15.6,
            buttonSize: const [35, 35],
            distanceBottom: const [5, 5],
            buttonColor: Colors.black,
            icon: FontAwesomeIcons.userPen,
            iconColor: Colors.black,
            child: AppDrawerAvatar(avatar: widget.user.avatar),
          ),*/
          AppDrawerAvatar(avatar: widget.user.avatar),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( 
                    widget.user.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle( 
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis
                    ),
                  ), 
                  Container( 
                    margin: EdgeInsets.only( top: 3 ),
                    child:Text( 
                      widget.user.email,
                      maxLines: 1,
                      style: TextStyle( 
                        fontSize: 13.4, 
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis
                      )
                    ) 
                  ) 
                ],
              )
            )
          ), 
        ],
      ),
    );
  }

}