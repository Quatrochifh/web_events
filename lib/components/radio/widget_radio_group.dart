import 'package:appweb3603/components/radio/widget_radio.dart';
import 'package:appweb3603/components/widget_empty_box.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {

  final dynamic groupId;

  final Map<dynamic, dynamic> options;

  const RadioGroup({Key? key, required this.options, required this.groupId}) : super(key: key);

  @override
  RadioGroupState createState() => RadioGroupState();
}

class RadioGroupState extends State<RadioGroup> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  dynamic _groupValue;

  List<CustomRadio>? _options;

  final Map<dynamic, GlobalKey<CustomRadioState>> _optionsKeys = {};

  @override
  void initState() {
    super.initState();

    _parseValues();
  }

  dynamic getValue() {
    return _groupValue;
  }

  void _changeValue(dynamic newValue) {
    if (!mounted) return;
    setState(() {
      _groupValue = newValue;
    });
    _optionsKeys.forEach((key, value) {
      if (key != newValue) {
        if (!mounted || value.currentState == null) return;
        value.currentState!.unSelect();
      } else {
        value.currentState!.select();
      }
    });
  }

  _parseValues() {
    _options ??= [];
    widget.options.forEach((key, value) {
      _optionsKeys[key] = new GlobalKey();
      _options!.add(
        CustomRadio(
          key: _optionsKeys[key],
          displayValue: value,
          value: key,
          onTap: _changeValue,
        )
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Column(
        children: 
        _options == null
          ?
            [LoadingBlock()]
          :
            (
              _options!.isNotEmpty
              ?
                _options!
              :
                [EmptyBox()]
            )
        
      ),
    );
  }

}