import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/components/widget_text_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeHeader extends StatelessWidget {

  final String startTime;

  final String endTime;

  final String date;

  final EdgeInsets? padding;

  const DateTimeHeader({Key? key, this.padding, required this.startTime, required this.endTime, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Details(
              titleColor: Colors.black,
              titleSize: 22,
              marginBottom: 5,
              inline: true,
              items: {
                TextIcon(text: "Data", icon: CupertinoIcons.calendar) : date,
              },
            )
          ),
          Expanded(
            flex: 2,
            child: Details(
              titleColor: Colors.black,
              titleSize: 22,
              marginBottom: 5,
              inline: true,
              items: {
                TextIcon(text: "Inicio", icon: CupertinoIcons.time): startTime,
                TextIcon(text: "Fim", icon: CupertinoIcons.time): endTime,
              },
            )
          )
        ],
      )
    );
  }

}