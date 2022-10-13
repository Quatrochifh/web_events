import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
class PostReactions extends StatelessWidget {

  final String reactionsString;

  const PostReactions({
    Key? key,
    required this.reactionsString
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(
        top: 12,
        bottom: 2
      ),
      padding: EdgeInsets.all(
        6.5
      ),
      child: Row(
        children:[
          Container(
            width: 23,
            height: 23,
            margin: EdgeInsets.only(
              right: 10
            ),
            alignment: Alignment.center,
            child: Icon(
              CupertinoIcons.heart_fill,
              size: 16,
              color: likeBgColor,
            )
          ),
          Expanded(
            child: Text(
              reactionsString,
              maxLines: 2,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 80, 80, 80),
                fontWeight: FontWeight.w400
              )
            )
          )
        ]
      )
    );
  }

}