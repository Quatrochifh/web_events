import 'package:flutter/cupertino.dart';

class MainNotificationCard extends StatefulWidget {

  final String text;
  
  const MainNotificationCard({Key? key, required this.text}) : super(key: key);

  @override
  MainNotificationCardState createState() => MainNotificationCardState();
}

class MainNotificationCardState extends State<MainNotificationCard> {
  
  @override
  Widget build(BuildContext context) {
    return Text("...");
  }

}