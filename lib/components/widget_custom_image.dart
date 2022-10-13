import 'dart:io';

import 'package:appweb3603/utils/CacheImage.dart';
import 'package:appweb3603/components/loader/widget_image_loader.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/utils/File.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  final dynamic image;

  final double? width;

  final double height;

  final bool? https;

  final bool? local;

  final BoxFit? fit;

  final String? defaultImage;

  CustomImage(
      {Key? key,
      this.defaultImage,
      this.local = false,
      this.image,
      this.fit,
      this.https = false,
      this.width,
      this.height = 0.0})
      : super(key: key);

  @override
  CustomImageState createState() => CustomImageState();
}

class CustomImageState extends State<CustomImage>
    with AutomaticKeepAliveClientMixin {
  dynamic _image;

  @override
  bool get wantKeepAlive => false;

  Widget? _imageComponent;

  void update(dynamic image) {
    if (isUrl(image) && widget.local != true) {
      getInternetImage(image, https: widget.https!).then((results) {
        if (!mounted) return;
        setState(() {
          _image = results;
        });
      });
    } else {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (!mounted) return;

    if (isUrl(widget.image) && widget.local != true) {
      loadImageFromUrl(widget.image);
    } else {
      _image = widget.image;
    }
  }

  Future loadImageFromUrl(String imageUrl) async {
    CacheImage.fetch(imageUrl).then((results) async {
      String? filePath = await getFilePath(results);
      if (results != null && results.isNotEmpty && filePath != null) {
        if (!mounted) return;
        setState(() {
          _imageComponent = Image.file(
            File(filePath),
            width: widget.width ?? double.infinity,
            height: widget.height,
            fit: widget.fit,
          );
        });
      } else {
        CacheImage.download(imageUrl);
        getInternetImage(imageUrl, https: widget.https!).then((results) {
          if (!mounted) return;
          setState(() {
            _image = results;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_imageComponent != null && _image.runtimeType.toString() != "Uint8List" && _image.runtimeType.toString() != "_File") {
      return _imageComponent!;
    }
    debugPrint(_image.runtimeType.toString());
    if (_image.runtimeType.toString() == "Uint8List") {
      debugPrint("Foto Uint8List carregada.");
      return Image.memory(
        _image,
        fit: widget.fit,
        width: widget.width,
        height: widget.height
      );
    } else if (widget.local == true &&
        _image.runtimeType.toString() == 'String') {
      return Image.asset(
          _image.isNotEmpty ? _image : "assets/images/loading.gif",
          fit: widget.fit,
          width: widget.width ?? double.infinity,
          height: widget.height);
    } else if (isUrl(_image)) {
      try {
        return CachedNetworkImage(
          fadeOutDuration: Duration(milliseconds: 10),
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          imageUrl: _image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      } catch (e) {
        if (widget.defaultImage == null) {
          return ImageLoader();
        }
        return Image.asset(
          widget.defaultImage ?? "assets/images/no_image.png",
          width: widget.width ?? double.infinity,
          height: widget.height,
          fit: widget.fit,
        );
      }
    } else if (_image.runtimeType.toString() == '_File') {
      return Image.file(
        _image,
        width: widget.width ?? double.infinity,
        height: widget.height,
        fit: widget.fit,
      );
    } else {
      if (widget.defaultImage == null) {
        return Container(
          alignment: Alignment.center,
          child: CustomImage(
            local: true,
            image: "assets/images/no_image.png",
            width: 90,
            height: 90,
            fit: BoxFit.contain,
          )
        );
      }
      return Image.asset(
        widget.defaultImage ?? "assets/images/no_image.png",
        width: widget.width ?? double.infinity,
        height: widget.height,
        fit: widget.fit,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
