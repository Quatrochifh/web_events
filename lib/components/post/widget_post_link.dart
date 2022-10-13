import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PostLink extends StatefulWidget {
  final Post post;

  const PostLink({Key? key, required this.post}) : super(key: key);

  @override
  PostLinkState createState() => PostLinkState();
}

class PostLinkState extends State<PostLink> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async { 
        try{
          await launch(widget.post.link); 
        }catch(e) {
          debugPrint(e.toString()); 
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(
          top: 7,
          bottom: 7,
          right: 15,
          left: 15
        ),
        height: 75,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.125),
          border: Border.all(
            width: 0.5,
            color: Colors.black.withOpacity(0.125)
          ),
          borderRadius: borderMainRadius,
        ),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.link,
              size: 17,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.link,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  Text(
                    "Clique para acessar o link anexado.",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15.6,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}