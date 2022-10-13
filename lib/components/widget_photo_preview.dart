import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:flutter/material.dart'; 

class PhotoPreview extends StatefulWidget{ 

  final double? width;

  final double? height;

  final EdgeInsets? margin;

  final dynamic imageUrl;  

  final Function? callback;

  final double? borderRadius;

  PhotoPreview({
    Key? key,
    this.callback,
    required this.imageUrl,
    this.margin,
    this.width,
    this.height,
    this.borderRadius
  }) : super(key: key); 

  @override
  PhotoPreviewState createState() => PhotoPreviewState();

}


class PhotoPreviewState extends State<PhotoPreview>{   

  final GlobalKey<CustomImageState> _keyImageNetwork = new GlobalKey();

  void removeImage(){
    _keyImageNetwork.currentState!.update( "" );
  }

  void updateImage( dynamic imageUrl){ 
    _keyImageNetwork.currentState!.update( imageUrl );
  }

  @override 
  Widget build( BuildContext context ){
    return InkWell( 
      onTap: (){ 
        if( widget.callback != null ){
          widget.callback!();
        }
      },
      child: 
        Container(
          width: widget.width,
          height: widget.height ?? 300,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            border: Border.all(
              width: 0.4,
              color: Colors.black.withOpacity(0.120)
            ),
            borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : null
          ), 
          clipBehavior: Clip.antiAlias,
          child: CustomImage(key: _keyImageNetwork, image: widget.imageUrl, height: widget.height ?? double.infinity, width: widget.width ?? double.infinity, fit: BoxFit.cover ),
        )
    );
  }

}