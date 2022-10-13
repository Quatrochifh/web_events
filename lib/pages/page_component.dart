import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/components/template/widget_template_footer.dart';
import 'package:appweb3603/components/widget_float_message.dart';
import 'package:appweb3603/components/widget_float_screen.dart';
import 'package:appweb3603/components/widget_loading.dart';
import 'package:appweb3603/components/widget_page_positioned.dart';
import 'package:appweb3603/components/widget_popup_message.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

mixin PageComponent <T extends StatefulWidget > on State<T> { 

  BoxDecoration? _containerDecoration;

  List<Widget> _positioned = [];

  /*
    * Notificações
  */
  Map<GlobalKey, Widget> _notifications = {};

  /*
    Float Loading
  */ 
  bool _showLoading = false;

  /*
    * Alert
  */
  bool _showAlert   = false; 
  String _showAlertTitle = "";
  String _showAlertMessage = "";
  IconData? _showAlertIcon = CupertinoIcons.check_mark;
  Function? _showAlertCallback;
  Function? _showCancelCallback;
  String? _showAlertCancelTitle;
  String? _showAlertsuccessBtnText;

  /*
    Float Screen
  */ 
  bool _floatScreenActived = false;
  String? _floatScreenTitle;
  Widget? _floatScreenChild;
  Color? _floatScreenBackgroundColor;
  Color? _floatScreenHeaderItemColor;

  void showFloatScreen({String? title, Widget? child, Color? backgroundColor, Color? headerItemColor}){
    if (!mounted) return;
    hideFloatScreen();

    setState((){
      _floatScreenActived = true;
      _floatScreenTitle = title;
      _floatScreenChild = child;
      _floatScreenBackgroundColor = backgroundColor;
      _floatScreenHeaderItemColor = headerItemColor;
    });
  }

  void hideFloatScreen(){
    if (!mounted) return;
    setState((){
      _floatScreenActived = false;
    });
  }

  void registerNotification({message, type}) {
    if (!mounted) return;
    GlobalKey key = new GlobalKey();
    setState((){
      _notifications[key] = 
        Positioned(
        child: Container(
          width: MediaQuery.of(context).size.width, 
          child: FloatMessage(message: message, enabled: true, messageType: type, onClose: (){ 
            _notifications.removeWhere((k, v) => k == key);
            setState((){
              _notifications = _notifications;
            });
          })
        )
      );
    });

    Future.delayed(Duration(seconds: 20), (){
      _notifications.removeWhere((k, v) => k == key);
      if(!mounted) return;
      setState((){
        _notifications = _notifications;
      });
    });
  }
  
  Widget loadingComponent(){
    if(_showLoading == true){
      return PagePositioned(
        child: Loading()
      );
    }
    return SizedBox.shrink();
  } 

  Widget alertComponent(){
    if(_showAlert == true){
      return  PagePositioned(
        child: PopUpMessage(
          title: _showAlertTitle,
          text: _showAlertMessage,
          icon: _showAlertIcon,
          showCancelButton: _showCancelCallback != null,
          cancelCallback: _showCancelCallback,
          cancelTitle: _showAlertCancelTitle,
          successBtnText: _showAlertsuccessBtnText,
          okCallback: _showAlertCallback != null ? (){
            _showAlertCallback!();
          } : (){
            setState(() {
              _showAlert = false;
            });
          }
        )
      );
    }
    return SizedBox.shrink();
  }

  Widget floatScreenComponent(){
    return FloatScreen(
      onClose: (){
        setState((){
          _floatScreenActived  = false;
          _floatScreenTitle = "";
          _floatScreenChild = null;
        });
      }, 
      actived: _floatScreenActived,
      title: _floatScreenTitle,
      child: _floatScreenChild
    );
  }

  setDecoration(BoxDecoration decoration){
    if (!mounted) return;
    setState((){ 
      _containerDecoration = decoration;
    });
  }
  
  void showAlert({title = "", callback, message = "", dynamic icon, cancelCallback, String? cancelTitle, String? successTitle}) {
    if (!mounted) return;
    setState((){
      _showAlertCallback = callback;
      _showAlert = true;
      _showAlertTitle = title;
      _showAlertMessage = message;
      _showAlertIcon = icon;
      _showCancelCallback = cancelCallback;
      _showAlertCancelTitle = cancelTitle;
      _showAlertsuccessBtnText = successTitle;
    });
  }

  void hideAlert() {
    if (!mounted) return;
    setState((){
      _showAlert = false;
    });
  }

  void showLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState((){ 
        _showLoading = true;
      });
    });
  }

  void hideLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState((){ 
        _showLoading = false;
      });
    });
  }  

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), (){
      updateDIContainerFunctions();
    });
  }

  void updateDIContainerFunctions() {
    /*
     * Aqui injetamos na globalDIContainer funções para acessar as funções da página
    */
    globalDIContainer.set("showFloatScreen", showFloatScreen);
    globalDIContainer.set("hideFloatScreen", hideFloatScreen);
    globalDIContainer.set("showNotification", registerNotification);
    globalDIContainer.set("hideLoading", hideLoading);
    globalDIContainer.set("showLoading", showLoading);
    globalDIContainer.set("showAlert", showAlert);
    globalDIContainer.set("hideAlert", hideAlert);
  }

  @override
  void dispose() { 
    super.dispose();
  }

  Widget content(
    {
      body,
      color,
      header,
      drawer,
      positioned,
      padding,
      bool resizeToAvoidBottomInset = false,
      bool showFooter = true
    }
  ){

    updateDIContainerFunctions();

    if (body.runtimeType.toString() != "List<Widget>") {
      body = <Widget>[ body ];
    }

    positioned ??= <Widget>[SizedBox.shrink()];

    _positioned =  positioned;
    
    List<Widget> functions = <Widget>[ 
      loadingComponent(),
      alertComponent()
    ];

    return WillPopScope(  
      onWillPop: () {  
        return Future.value(false);
      },
      child: Scaffold(
        drawer: drawer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset, 
        body: GestureDetector(
          onTap: (){ 
            FocusScope.of(context).requestFocus(FocusNode());
          }, 
          child: Container(
            width: double.infinity, 
            height: double.infinity,
            color: color ?? Colors.white, 
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    header != null 
                      ?
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: header
                        )
                      : 
                        SizedBox.shrink(),
                    Expanded( 
                      child: Container(
                        decoration: _containerDecoration, 
                        child: Column(
                          children: body
                        ), 
                      ) 
                    ),
                    (showFooter == true)
                      ?
                        Container(
                          padding: EdgeInsets.only(
                            bottom: templateFooterHeigth
                          ),
                        )
                      :
                        SizedBox.shrink()
                  ]
                ),
                showFooter == true
                ? 
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: AppFooter()
                    )
                  )
                : SizedBox.shrink()
              ] + _positioned
              +
                [
                  FloatScreen(
                    onClose: (){
                      setState((){
                        _floatScreenActived  = false;
                      });
                    },
                    headerItemColor: _floatScreenHeaderItemColor,
                    backgroundColor: _floatScreenBackgroundColor,
                    actived: _floatScreenActived,
                    title: _floatScreenTitle,
                    child: _floatScreenChild
                  )
                ]
              + List<Widget>.from(_notifications.values.map((value) => value).toList())
              + functions
            ) 
          )
        )
      )
    );
  }
}