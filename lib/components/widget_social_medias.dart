import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_list_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedias extends StatefulWidget {

  final Map<String, String> items;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final Color? backgroundColor;

  final double? dimension;

  final double? fontSize;

  final Alignment? alignment;


  const SocialMedias({Key? key, this.alignment, this.fontSize, this.dimension, this.backgroundColor, this.padding, this.margin, required this.items}) : super( key : key);

  @override
  SocialMediasState createState() => SocialMediasState();
}


class SocialMediasState extends State<SocialMedias> {

  final List<PrimaryButton> medias = [];


  @override
  void initState() {
    super.initState();


    /*
      Vamos gerar os botões das redes sociais do usuário... 
    */
    widget.items.forEach((key, value){
      if (value.isNotEmpty) {
        medias.add(
          PrimaryButton(
            key: GlobalKey(), 
            title: key,
            onlyIcon: true,
            textColor: Colors.grey,
            backgroundColor: widget.backgroundColor ?? Colors.grey.withOpacity(0.185),
            icon: globalIcons[key] ?? CupertinoIcons.link,
            onClick: (){ 
              try{
                launch(Uri.decodeFull(value));
              } catch(e) {
                debugPrint(e.toString());
              }
            },
            padding: noPadding,
            iconSize: widget.fontSize ?? 25,
            borderRadius: 100,
            width: widget.dimension ?? 50, 
            height: widget.dimension ?? 50
          )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      alignment: widget.alignment ?? Alignment.center,
      height: widget.dimension == null ? 55 : widget.dimension! + (widget.dimension! * 0.1),
      width: double.infinity,
      child: ListComponent( 
        direction: Axis.horizontal,
        children: medias
      )
    );
  }
}