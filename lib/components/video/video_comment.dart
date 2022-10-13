import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/entities/Post.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoComment extends StatefulWidget {

  final Post post;

  const VideoComment({Key? key, required this.post}) : super(key: key);

  @override
  VideoCommentState createState() => VideoCommentState();

}

class VideoCommentState extends State<VideoComment> {

  bool _showActionMenu = false;

  bool _expanded = false;

  void _actionTap() {
    if (!mounted) return;
    setState(() {
      _showActionMenu = !_showActionMenu;
    });
  }

  void _showMore() {
    if (!mounted) return;
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 6.5
      ),
      width: double.infinity,
      padding: EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 7.5),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoCommentHeader(post: widget.post),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.125)
                    ),
                    child: Wrap(
                      children: [
                        Text(
                          widget.post.content,
                          maxLines: !_expanded ? 2 : 100,
                          style: TextStyle(
                            fontSize: 13.7,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w100
                          ),
                        ),
                        PrimaryButton(
                          mainAxisAlignment: MainAxisAlignment.start,
                          width: 80,
                          height: 25,
                          padding: noPadding,
                          fontSize: 12,
                          textColor: Colors.black,
                          onClick: (){
                            _showMore();
                          },
                          backgroundColor: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          title: !_expanded ? "Ler mais" : "Ler menos"
                        )
                      ],
                    )
                  )
                ]
              )
            )
          ),
        ],
      )
    );
  }

}


class VideoCommentAction extends StatefulWidget {

  final Function onTap;

  const VideoCommentAction({Key? key, required this.onTap}) : super(key: key);

  @override
  VideoCommentActionState createState() => VideoCommentActionState();
}

class VideoCommentActionState extends State<VideoCommentAction> {

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      width: 110,
      height: 30,
      borderRadius: 10,
      fontSize: 12.5,
      fontWeight: FontWeight.bold,
      onClick: widget.onTap,
      backgroundColor: greyBtnMoreBackground,
      textColor: greyBtnMoreTextColor,
      title: "Responder",
      iconSize: 12,
      iconMargin: EdgeInsets.only(
        left: 3.5,
        right: 3.5
      ),
      icon: FontAwesomeIcons.share,
    );
  }

}

class VideoCommentHeader extends StatelessWidget {

  final Post post;

  const VideoCommentHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10
      ),
      child: Column(
        children: [
          Row(
            children:[
              Avatar(
                margin: EdgeInsets.only(right: 10),
                avatar: post.user.avatar,
                width: 35,
                height: 35,
                borderColor: Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    post.user.name,
                    style: TextStyle(
                      fontSize: 15.4,
                      letterSpacing: primaryLetterSpacing,
                      fontWeight: FontWeight.w900
                    )
                  ),
                  Text(
                    post.publishedAt,
                    style: TextStyle(
                      color: textMuted
                    ),
                  )
                ]
              )
            ]
          ),
        ]
      )
    );
  }

}