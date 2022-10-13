import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class ListComponent extends StatefulWidget{

  final Axis? direction;

  final List<Widget> children;

  final EdgeInsets? margin;

  final ScrollController? controller;

  const ListComponent({
    Key? key,
    this.margin,
    this.direction,
    required this.children,
    this.controller
  }) : super(key: key);

  @override
  ListComponentState createState() => ListComponentState();
  
}

class ListComponentState extends State<ListComponent>{

  List<Widget> _children = [];


  @override
  void initState(){
    super.initState();

    this.updateList(widget.children);
  }

  void updateList(List<Widget> children) {
    if(!mounted) return; 

    setState((){
      _children = children;
    });
  }

  @override
  Widget build( BuildContext context ){
    return Container(
      margin: widget.margin ?? EdgeInsets.all(0),
      child: ListView.builder(
        controller: widget.controller,
        padding: noPadding,
        itemBuilder: (context, index) => _children[index],
        itemCount: _children.length,
        scrollDirection: widget.direction ?? Axis.vertical,
        shrinkWrap: true
      ),
    );
  }
  
}