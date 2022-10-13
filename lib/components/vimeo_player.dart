 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class VimeoPlayerCustom extends StatefulWidget {
  final String videoId;

  const VimeoPlayerCustom({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  @override
  VimeoPlayerCustomState createState() => VimeoPlayerCustomState();
}

class VimeoPlayerCustomState extends State<VimeoPlayerCustom> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WebView(
      initialUrl: _videoPage(widget.videoId),
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  String _videoPage(String videoId) {
    final html = '''
            <html>
              <head>
                <style>
                  body {
                   background-color: lightgray;
                   margin: 0px;
                   }
                </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                <iframe 
                src="https://player.vimeo.com/video/$videoId?loop=0&autoplay=0" 
                width="100%" height="100%" frameborder="0" allow="fullscreen" 
                allowfullscreen></iframe>
             </body>
            </html>
            ''';
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(html));
    return 'data:text/html;base64,$contentBase64';
  }
}