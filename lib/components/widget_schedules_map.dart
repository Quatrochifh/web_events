import 'package:appweb3603/components/schedule/widget_schedule.dart';
import 'package:appweb3603/components/widget_title_h3.dart';
import 'package:flutter/material.dart';


class SchedulesMap extends StatefulWidget {

  final List<Schedule> schedules;

  const SchedulesMap({Key? key, required this.schedules}) : super(key: key);

  @override
  SchedulesMapState createState() => SchedulesMapState();

}

class SchedulesMapState extends State<SchedulesMap> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleH3(
            title: "Palestrante em"
          )
        ] + widget.schedules,
      ),
    );
  }

}