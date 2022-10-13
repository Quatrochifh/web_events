import 'dart:ui';

import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/conf.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapsOpen extends StatelessWidget {

  final String eventCode;

  GoogleMapsOpen({Key? key, required this.eventCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: borderMainRadius,
        border: Border.all(
          width: 0.1,
          color: bgWhiteBorderColor
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(0),
            child: CustomImage(
              width: double.infinity,
              height: 200,
              local: true,
              image: "assets/images/maps/default_map_background.png",
              fit: BoxFit.cover
            )
          ),
          Container(
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 3.1, sigmaY: 3.1),
                  child: SizedBox.shrink(),
                )
            )
          ),
          Positioned(
            bottom: 5,
            left: 5,
            right: 5,
            child: PrimaryButton(
              width: 200,
              height: 46,
              textColor: Colors.black,
              borderRadius: 10,
              backgroundColor: Colors.black.withOpacity(0.125),
              onClick: (){
                try {
                  late Uri url;
                  if(serverHttps){
                    url = Uri.https(serverHost + ( serverPort != null ? ":${serverPort.toString()}" : ''),  "$serverPath/event/toGoogleMaps/${eventCode.toString()}" );  
                  }else{
                    url = Uri.http(serverHost + ( serverPort != null ? ":${serverPort.toString()}" : ''),  "$serverPath/event/toGoogleMaps/${eventCode.toString()}" );  
                  }
                  launchUrl(url);
                } catch(e) {
                  debugPrint(e.toString());
                }
              },
              title: "Abra no Google Maps",
              icon: CupertinoIcons.map
            ),
          )
        ],
      )
    );
  }
}