import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCheckBox extends StatefulWidget {

  final bool checked;

  final EdgeInsets? margin;

  final String? text;

  final Color? boxColor;

  final Color? textColor;

  final double? textSize;

  const CustomCheckBox({Key? key, this.textSize, this.text, required this.checked, this.margin, this.boxColor, this.textColor}) : super(key: key);

  @override
  CustomCheckBoxState createState() => CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {

  bool _checked = false;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;

    setState((){
      _checked = widget.checked;
    });
  }

  void check() {
    if (!mounted) return;
    setState((){
      _checked = true;
    });
  }

  void unCheck() {
    if (!mounted) return;
    setState((){
      _checked = false;
    });
  }

  bool isChecked() {
    return _checked;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(!mounted) return;
        setState((){
          _checked = !_checked;
        });
      },
      child: Container(
        margin: widget.margin ?? EdgeInsets.all(0),
        child: Row(
          children: [
            CustomCheckBoxBox(
              checked: _checked,
              boxColor: widget.boxColor,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 22),
                child: Text(
                  widget.text ?? "",
                  style: TextStyle(
                    fontSize: widget.textSize ?? 11.5,
                    fontWeight: FontWeight.normal,
                    color: widget.textColor ?? Colors.white.withOpacity(0.6)
                  )
                )
              )
            )
          ],
        ),
      )
    );
  }

}


class CustomCheckBoxBox extends StatelessWidget {
  final bool checked;

  final Color? boxColor;

  const CustomCheckBoxBox({Key? key, required this.checked, this.boxColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: boxColor ?? Colors.white.withOpacity(0.125)
      ),
      child: checked ? Icon(FontAwesomeIcons.check, color: primaryColor, size: 17) : SizedBox.shrink()
    );
  }
}