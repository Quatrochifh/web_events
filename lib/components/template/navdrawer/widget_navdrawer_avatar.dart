import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class AppDrawerAvatar extends StatefulWidget{

  final String avatar;

  AppDrawerAvatar( { Key? key , required this.avatar } ) : super( key : key );

  @override
  _AppDrawerAvatarState createState() => _AppDrawerAvatarState();

}

class _AppDrawerAvatarState extends State<AppDrawerAvatar>{ 
  @override
  Widget build( BuildContext context ){
    return Container( 
      width: 120, 
      height: 120,
      decoration: BoxDecoration(  
        borderRadius: BorderRadius.circular(100),
      ),
      child:  Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(  
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [darkShadow]
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          child: CustomImage(
            fit: BoxFit.cover,
            local: widget.avatar.isEmpty ? true : false,
            image: widget.avatar.isEmpty ? "assets/images/default_avatar.png" : widget.avatar,
            defaultImage: "assets/images/default_avatar.png",
            height: 55,
            width: 45
          ),
        )
      ), 
    );
  }

}