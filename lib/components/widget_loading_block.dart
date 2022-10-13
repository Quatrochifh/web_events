import 'package:flutter/material.dart'; 

class LoadingBlock extends StatefulWidget{
  final String? text;

  final bool transparent;

  final Color? textColor;

  final double? imageSize;

  final bool? inline;

  LoadingBlock({
    Key? key,
    this.inline,
    this.textColor,
    this.text,
    this.transparent = false,
    this.imageSize
  }) : 
  super(key : key); 

  @override
  LoadingBlockState createState() => new LoadingBlockState();
}

class LoadingBlockState extends State<LoadingBlock>{  
 
 

  @override 
  Widget build(BuildContext context) {

    double left  = 0;
    double right = 0;

    final loadingComponents = [
          new Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0)),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0),
                  blurRadius: 11.0,
                  offset: new Offset(0, -1.0),
                ),
              ],
            ),
            child: Card( 
              color: Colors.transparent,
              elevation: 0.0,
              child: Image.asset('assets/images/loading.gif', width: widget.imageSize ?? 40, height: widget.imageSize ?? 40)
            ),
          ),
          (widget.text != null) ?
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                widget.text!,
                style: TextStyle(
                  color: widget.textColor ?? Colors.black,
                  fontSize: 13.4
                )
              )
            )
          :
          SizedBox.shrink()
        ];

    final Widget loadingBox = new Container(
      width: double.infinity, 
      constraints: BoxConstraints( 
        minHeight: 20
      ),
      color: widget.transparent == true ? Colors.transparent : Colors.transparent,
      margin: EdgeInsets.only( 
        left:  left, 
        right: right,  
      ), 
      padding: EdgeInsets.all(10),
      child: 
        (widget.inline == true)
          ?
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: loadingComponents
            )
          :
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: loadingComponents
            )
    );
  
    return Container(  
      child: loadingBox
    );
  
  }
 
}