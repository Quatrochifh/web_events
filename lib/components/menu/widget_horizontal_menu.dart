import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class HorizontalMenu extends StatefulWidget {
  final Map<String, Function> items;

  const HorizontalMenu({Key? key, required this.items}) : super(key: key);

  @override
  HorizontalMenuState createState() => HorizontalMenuState();
}

class HorizontalMenuState extends State<HorizontalMenu> {

  List<_MenuItem> _menuItems = [];
  Map<String, GlobalKey<_MenuItemState>> _globalkeys = {};

  void changeItem(Function f, String currentKey) {
    _globalkeys.forEach((k, g) {
      if (k != currentKey && g.currentState != null) {
        g.currentState!.deactive();
      }
    });
    f();
  }

  @override
  void initState() {
    super.initState();

    widget.items.forEach((key, function) {
      GlobalKey<_MenuItemState> globalkey = new GlobalKey();
      _globalkeys[key] = globalkey;
      _menuItems.add(
        _MenuItem(
          key: globalkey,
          text: key,
          onClick: () {
            changeItem(function, key);
          },
          current: _menuItems.length == 0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 246, 246),
        border: Border(
          bottom: BorderSide(
            width: 0.35,
            color: Colors.black.withOpacity(0.1)
          ),
          top: BorderSide(
            width: 0.35,
            color: Colors.black.withOpacity(0.1)
          )
        )
      ),
      child: ListView(
        padding: noPadding,
        scrollDirection: Axis.horizontal,
        children: _menuItems
      )
    );
  }
}

class _MenuItem extends StatefulWidget {
  final String text;

  final bool? current;

  final Function onClick;

  const _MenuItem({Key? key, required this.text, this.current = false, required this.onClick}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {

  bool _current = false;

  void active() {
    if (!mounted) return;
    setState(() {
      _current = true;
    });
  }

  void deactive() {
    if (!mounted) return;
    setState(() {
      _current = false;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.current == true) {
      active();
    } else {
      deactive();
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        active();
        widget.onClick();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.5,
              color: _current == true ? primaryColor : Colors.transparent
            ),
          )
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: 2,
            bottom: 2,
            right: 5
          ),
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            right: 7,
            left: 7
          ),
          height: 40,
          alignment: Alignment.center,
          child: Text(
            widget.text,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15.6,
              overflow: TextOverflow.ellipsis,
              fontWeight: _current == true ? FontWeight.bold : null,
              color: _current == true ? primaryColor : Colors.grey
            ),
          )
        )
      )
    );
  }
}