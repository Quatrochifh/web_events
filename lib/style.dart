import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Color headerDarkColor = Color.fromRGBO(50, 50, 50, 1);

const Color bodyDarkColor = Color.fromRGBO(23, 23, 23, 1);

const Color primaryColor = Color.fromRGBO(111, 192, 98, 1);

const Color primaryColorLigther = Color.fromRGBO(111, 192, 98, 0.125);

const Color secondaryColor = Color.fromRGBO(27, 161, 203, 1);

const Color bgWhiteBorderColor = Color.fromRGBO(238, 238, 230, 1);

const Color bgWhiteColor = Color.fromRGBO(230, 230, 230, 1);

const Color mainBackgroundColor = Color.fromARGB(255, 245, 248, 249);

const Color mainSecondaryBackgroundColor = Color.fromARGB(255, 239, 239, 239);

const Color textMuted = Color.fromARGB(255, 206, 206, 206);

const Color grey105Color = Color.fromRGBO(25, 25, 25, 1);

const Color grey165Color = Color.fromRGBO(165, 165, 165, 1);

const Color grey125Color = Color.fromRGBO(125, 125, 125, 1);

const Color greyBtnCancelBackground = Color.fromARGB(255, 202, 201, 201);

const Color greyBtnCancelTextColor = Color.fromARGB(255, 123, 123, 123);

const Color greyBtnMoreBackground = Color.fromARGB(255, 241, 241, 241);

const Color greyBtnMorePressed = Color.fromARGB(255, 234, 234, 234);

const Color greyBtnMoreTextColor = Color.fromARGB(255, 133, 133, 133);

const Color ligtherShadow = Color.fromRGBO(238, 239, 255, 1);

const Color cancelBackground = Color.fromARGB(66, 159, 159, 159);

const Color cancelTextColor = Color.fromARGB(66, 28, 28, 28);

const Color errorColor = Color.fromRGBO(212, 51, 113, 1);

const Color warningColor = Color.fromARGB(255, 174, 72, 72);

const Color attentionColor = Color.fromARGB(255, 240, 160, 56);

const Color successColor = Color.fromARGB(255, 173, 223, 120);

const Color infoColor = Color.fromARGB(255, 244, 233, 253);

const Color infoDarkColor = Color.fromARGB(255, 172, 88, 240);

const Color selectColor = Color.fromARGB(255, 116, 216, 130);

const Color cancelColor = Color.fromARGB(255, 176, 182, 177);

const Color likeBgColor = Color.fromRGBO(223, 17, 154, 1);

const Color postButtonTextColor = Color.fromARGB(255, 173, 170, 170);
const Color postButtonBgColor = Color.fromARGB(255, 249, 247, 247);

const Map<String, Color> statusColor = {
  'open': successColor,
  'pending': attentionColor,
  'finished': Color.fromARGB(255, 226, 224, 224),
  'warning': warningColor
};

const titleSmallStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

const titleS3Style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

const EdgeInsets noPadding = EdgeInsets.all(0);

const EdgeInsets noMargin = EdgeInsets.all(0);

const BoxShadow ligthShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.07),
  spreadRadius: 2,
  blurRadius: 2,
  offset: Offset(0, 0),
);

const BoxShadow darkShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.17),
  spreadRadius: 2,
  blurRadius: 3.5,
  offset: Offset(0, 1),
);

const BoxShadow black25Shadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  spreadRadius: 2,
  blurRadius: 3.5,
  offset: Offset(0, 1),
);

const BoxShadow darkShadowOffsetY35 = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.075),
  spreadRadius: 2,
  blurRadius: 3.5,
  offset: Offset(0, 3.5),
);

const Map<String, IconData> globalIcons = {
  'facebook': FontAwesomeIcons.facebook,
  'twitter': FontAwesomeIcons.twitter,
  'linkedin': FontAwesomeIcons.linkedin,
  'youtube': FontAwesomeIcons.youtube,
  'instagram': FontAwesomeIcons.instagram,
  'site': FontAwesomeIcons.link,
};

/*
  Transições 
*/
CustomTransition get customTransition => CustomTransition(
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    0.50,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );

const shimmerGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 241, 239, 239),
    Color.fromARGB(255, 218, 217, 217),
    Color.fromARGB(255, 233, 232, 232)
  ],
  stops: [
    0.1,
    0.2,
    0.29,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

/*
  * DarkMode
*/

const firstLayerBgColor = Color.fromARGB(118, 239, 239, 239);
const secondLayerBgColor = Color.fromARGB(255, 255, 255, 255);
const infoSecondLayerTextColor = Color.fromARGB(255, 37, 37, 37);
const Color infoFirstLayerBgColor = Color.fromARGB(255, 242, 246, 247);
const Color infoFirstLayerTextColor = Colors.black;

BorderRadius borderMainRadius = BorderRadius.circular(3);

const double primaryLetterSpacing = -.62;

const double templateFooterHeigth = 55;
const double templateHeaderHeigth = 70;

///
/// Layout default do APP
///
const String appLogoPrincipal = "assets/images/logo_principal.png";
const String appLogoPrincipalBranco = "assets/images/original_logo_branco.png";
const Color appPrimaryColor = Color.fromRGBO(247, 106, 65, 1);
