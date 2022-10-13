

import 'package:appweb3603/components/widget_slide.dart';
import 'package:appweb3603/helpers.dart'; 
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart';
 

class ScheduleDays extends StatefulWidget{    

  final List<String> dates;

  final Function feedback;

  ScheduleDays({Key? key, required this.dates, required this.feedback}) : super(key : key);  

  @override
  ScheduleDaysState createState() =>  new ScheduleDaysState();
}

class ScheduleDaysState extends State<ScheduleDays> with AutomaticKeepAliveClientMixin{  

  List<_ScheduleItem> _items = []; 

  List<GlobalKey<ScheduleDaystate>> _itemsKeys = []; 

  @override 
  bool get wantKeepAlive => true; 

  @override
  void initState(){
    super.initState();

    widget.dates.forEach((value) {
      GlobalKey<ScheduleDaystate> key = GlobalKey();
      _itemsKeys.add(key);
      _items.add(_ScheduleItem(date: value, onSetCurrent: onSetCurrent, key: key));
    });

    setState((){
      _items = _items;
    });

    if(_itemsKeys.isNotEmpty){ 
      Future.delayed(Duration(microseconds: 20), (){
        if(_itemsKeys[0].currentState != null ) _itemsKeys[0].currentState!.setCurrent();
      }); 
    } 
  }
 
  void onSetCurrent(GlobalKey<ScheduleDaystate> key, func) {
    _itemsKeys.forEach((element){
      if(element.currentState != null) element.currentState!.unSetCurrent();
    });
    if( key.currentState != null ){
      key.currentState!.setCurrent();
      widget.feedback(key.currentState!.getCurrentDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
 
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.2,
            color: Colors.black.withOpacity(0.125)
          )
        )
      ),
      child: Slide(
        children: _items
      ),
    );
  }
} 



class _ScheduleItem extends StatefulWidget{

  final String date;

  final Function onSetCurrent;

  final bool? current;

  _ScheduleItem({Key? key, required this.date, this.current = false, required this.onSetCurrent}) : super(key : key); 


  @override
  ScheduleDaystate createState() => ScheduleDaystate();
}

class ScheduleDaystate extends State<_ScheduleItem> with AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true; 

  bool _current = false;

  void unSetCurrent(){ 
    if( !mounted ) return;

    setState((){
      _current = false;
    });
  }

  String getCurrentDate(){
    return widget.date;
  }

  void setCurrent(){ 
    if( !mounted ) return;

    setState((){
      _current = true;
    });
  }

  @override 
  void initState(){
    super.initState();

    if( !mounted ) return;

    _current = widget.current ?? false;
  }

  @override
  Widget build(BuildContext context){
    super.build( context );

    return InkWell( 
      onTap: (){
        widget.onSetCurrent(
          widget.key, setCurrent
        ); 
      },
      child:  Container(
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width * 0.2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _current != true ? Colors.transparent : primaryColor,
                width: 1.5
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [  
              Container(
                width: 30, 
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(100),
                ),
                clipBehavior: Clip.antiAlias,
                child: Text(
                  dateDayAndMonthName(widget.date).split("/")[0],
                  style: TextStyle( 
                    fontSize: 17, 
                    fontWeight: FontWeight.bold, 
                    color: _current == true ? primaryColor : Colors.grey
                  ),
                ),
              ),
              Text(
                dateDayAndMonthName(widget.date).split("/")[1],
                style: TextStyle( 
                  fontSize: 16,  
                  fontWeight: FontWeight.normal,
                  color: _current ? primaryColor : Colors.grey
                ),
              ), 
            ],
          ),
        )
    );
  }

}

   