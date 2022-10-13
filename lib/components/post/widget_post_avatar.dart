import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
 

class PostAvatar extends StatefulWidget{

  final double? width;

  final double? height;

  final User user;

  final bool? oficial;

  PostAvatar({
    Key? key,
    required this.user,
    this.width,
    this.height,
    this.oficial
  }) : super(key: key);

  @override
  PostAvatarState createState() => PostAvatarState();

}

class PostAvatarState extends State<PostAvatar> {

  @override
  Widget build(BuildContext context) {
    return Container( 
      width: widget.width ?? 53,
      height: widget.height ?? 53,
      margin: EdgeInsets.only(right: 8.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 2,
          color: widget.oficial != true ? Colors.grey.withOpacity(0.125) : primaryColor
        ),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: widget.width ?? 53, 
        height: widget.height ?? 53,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100)
        ),
        child: InkWell(
          onTap: (){
            //navigatorPushNamed(context, '/view-user', arguments: {'user': widget.user});
          },
          focusColor: Colors.transparent, 
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: CustomImage(
            fit: BoxFit.cover,
            image: widget.user.avatar,
            defaultImage: "assets/images/default_avatar.png",
            height: widget.height ?? 45, width: widget.width ?? 45
          ), 
        )
      ), 
    );
  }

}