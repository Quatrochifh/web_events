import 'package:appweb3603/components/widget_badge.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/components/widget_title_h3.dart';
import 'package:appweb3603/entities/Plan.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PlanCard extends StatefulWidget {

  final Function onTap;

  final Plan plan;

  const PlanCard({Key? key, required this.plan, required this.onTap}) : super(key: key);

  @override
  PlanCardState createState() => PlanCardState();
}

class PlanCardState extends State<PlanCard> {
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [darkShadow]
        ),
        child: Row(
          children:[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column (
                  children: [
                    TitleH3 (
                      title: widget.plan.title,
                      margin: EdgeInsets.only(
                        bottom: 5
                      ),
                      fontSize: 22,
                    ),
                    Message(
                      margin: noMargin,
                      padding: noPadding,
                      bgColor: Colors.transparent,
                      text: widget.plan.description,
                      fontSize: 16.5,
                      textColor: Colors.grey,
                    )
                  ]
                ),
              )
            ), 
            Container(
              padding: EdgeInsets.all(5),
              width: 120,
              height: 120,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (widget.plan.price > 10)
                  ?
                    Text(
                      "Preço",
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey
                      ),
                    )
                  :
                    SizedBox.shrink(),
                  (widget.plan.price <= 10)
                    ?
                      Badge(
                        width: 80,
                        height: 30,
                        text: "Grátis",
                        bgColor: primaryColor,
                      )
                    :
                      Text(
                        priceFormat(widget.plan.price),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      )
                  ]
              )
            )
          ]
        )
      )
    );
  }

}