import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {

  final dynamic value;

  final String displayValue;

  final Function onTap;

  final bool? selected;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.displayValue,
    required this.onTap,
    this.selected
  }) : super(key: key);

  @override
  CustomRadioState createState() => CustomRadioState();
}

class CustomRadioState extends State<CustomRadio> {

  bool _selected = false;

  void unSelect() {
    if (!mounted) return;
    setState(() {
      _selected = false;
    });
  }

  void select() {
    if (!mounted) return;
    setState(() {
      _selected = true;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.selected == true) {
      select();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
        debugPrint("Radio com valor \"#${widget.value}\" selecionado!");
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _selected != true ? Colors.white : primaryColor,
                border: Border.all(
                  width: 2,
                  color: Colors.white
                )
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: 10
                ),
                child: Text(
                  widget.displayValue,
                  maxLines: 1,
                  style: TextStyle(
                    color: _selected != true ? Colors.white.withOpacity(0.8) : primaryColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.normal
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}