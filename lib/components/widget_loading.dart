import 'package:flutter/material.dart';

class Loading extends StatefulWidget{
  Loading( { Key? key } ) : super( key : key );

  @override
  LoadingState createState() => new LoadingState();
}

class LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation posiAnimation;


  @override
  void initState() {
    super.initState();
    controller =  AnimationController(vsync: this, duration: Duration(seconds: 1 ));
    colorAnimation = ColorTween(begin: Color.fromRGBO(0, 0, 0, 0.16), end:  Color.fromRGBO(0, 0, 0, 0.25)).animate(controller);
    posiAnimation  = Tween<double>(begin: 0.1, end: 0.50 ).animate(controller);

    // In initState
    controller.addListener(() {
    setState(() {});
    });

    //Repeat the animation after finish
    controller.forward();
  }



  @override 
  Widget build(BuildContext context) {

    Widget loadingBox = new Container(   
        margin: EdgeInsets.only( 
          left: ((MediaQuery.of(context).size.width)/2 - 45 ), 
          right: ((MediaQuery.of(context).size.width)/2 - 45 ), 
          top:  ((MediaQuery.of(context).size.height) * 0.5)  - 45 ,
          bottom:  ((MediaQuery.of(context).size.height) * 0.5)  - 45  
        ), 
        child: Container(  
          margin: EdgeInsets.all(0),
          child: new Container(  
            padding: EdgeInsets.all(10),
            height: 90,
            width: 90, 
            decoration: BoxDecoration(
              color: Colors.white, 
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.025), width: 3.0),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 11.0,
                  offset: new Offset(0, -1.0),
                ),
              ],
            ),
            child: Card( 
              elevation: 0.0,
              child: Image.asset('assets/images/loading.gif', fit: BoxFit.cover, width: 40, height:40)
            ),
          ),
        )
    );
  
    return Container( 
      width: double.infinity,
      height: double.infinity, 
      color: colorAnimation.value,  
      child: loadingBox
    );
  
  }
 
 @override
 void dispose(){ 
   controller.dispose();
   super.dispose();
 }
}