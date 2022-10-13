import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class ProfileActionContainer extends StatefulWidget{ 

  final Widget child;

  final IconData icon;

  final double? iconSize;

  final Color? iconColor;

  final Function onTap;

  final List<double>? buttonSize;

  final Color? buttonColor;

  final List<double>? distanceBottom;
  
  ProfileActionContainer({Key? key, this.iconColor, this.distanceBottom = const [10, 10], this.buttonColor, required this.onTap, this.iconSize, this.buttonSize = const [30, 30], required this.icon, required this.child}) : super(key: key);

  @override
  ProfileActionContainerState createState() => ProfileActionContainerState();
} 

class ProfileActionContainerState extends State<ProfileActionContainer> with AutomaticKeepAliveClientMixin{ 

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context){
    super.build(context);

    return Container( 
      margin: EdgeInsets.all(0),
      child: Stack(
        children: [
          widget.child,
          Positioned(
            top: 80,
            bottom: 80,
            right: 80,
            left: 80,
            child: PrimaryButton(
              icon: widget.icon,
              iconSize: widget.iconSize ?? 25,
              padding: noPadding,
              noBorder: false, 
              marginBottom: widget.distanceBottom![0],
              marginRight: widget.distanceBottom![1],
              borderRadius: 100, 
              width: widget.buttonSize![0],
              height: widget.buttonSize![1],
              onlyIcon: true,
              iconColor: widget.iconColor ?? Colors.white,
              title: "Atualizar",
              onClick: widget.onTap, 
              backgroundColor: Colors.white.withOpacity(0.5)
            )
          )
        ],
      )
    );
  }

}