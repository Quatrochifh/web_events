import 'dart:async';
import 'dart:ui';

import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/plans/widget_plan_card.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_title_h3.dart';
import 'package:appweb3603/entities/Plan.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventPlanService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlansPage extends StatefulWidget {

  final String eventCode;

  final String eventName;

  final String eventLogo;

  final String? eventBackground;

  final String? loginEmail;

  final String? loginPassword;

  PlansPage({
    Key? key,
    this.eventBackground,
    required this.eventCode,
    required this.eventName,
    required this.eventLogo,
    this.loginEmail,
    this.loginPassword
  }) : super(key : key);

  @override
  PlansPageState createState() => new PlansPageState();
} 

class PlansPageState extends State<PlansPage> with PageComponent{

  Timer? _timer;

  List<PlanCard>? _planCards;

  DecorationImage? _decorationBackgroundImage;

  @override
  void initState() {
    super.initState();

    if(!mounted) return;

    setState(() {
      if(widget.eventBackground != null) {
        try {
          _decorationBackgroundImage = DecorationImage(
            image: NetworkImage(widget.eventBackground!),
            fit: BoxFit.cover,
          );
        } catch(e) {
          debugPrint(e.toString());
        }
      }else{ 
        _decorationBackgroundImage =  DecorationImage(
          image: AssetImage("assets/images/background/background_points_branco.png"),
          fit: BoxFit.cover,
        );
      }
    });

    _loadPlans();
  }

  void _loadPlans() async {
    EventPlanService planService = new EventPlanService();
    dynamic plans = await planService.fetchPlansByEventCode(widget.eventCode);

    _planCards ??= [];

    if (plans != null) {
      plans.forEach((Plan plan) {
        _planCards!.add(
          PlanCard(
            plan: plan,
            onTap: () {
              navigatorPushNamed(
                context,
                '/view-register',
                arguments: {
                  'eventCode': widget.eventCode,
                  'eventName': widget.eventName,
                  'eventLogo': widget.eventLogo,
                  'eventBackground': widget.eventBackground,
                  'planId' : plan.id
                }
              );
            }
          )
        );
      });
    }

    if (!mounted) return;

    setState(() {
      _planCards = _planCards;
    });
  }

  @override
  Widget build(BuildContext context){

    return content(
      resizeToAvoidBottomInset: true,
      showFooter: false,
      body: <Widget>[
        Expanded(
          child: Container( 
            alignment: Alignment.center,
            width: double.infinity, 
            decoration: BoxDecoration(
              image: _decorationBackgroundImage,
              color: Colors.white, 
              backgroundBlendMode: BlendMode.darken
            ), 
            child: ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: new Container( 
                  decoration: new BoxDecoration(
                    color: Colors.black.withOpacity(0.5)
                  ),
                  child: Stack(
                    children: [ 
                      ListView(
                        padding: noPadding,
                        physics: NeverScrollableScrollPhysics(),
                        children: [  
                          SafeArea( 
                            top: true, 
                            bottom: false,
                            child: Row(
                              children:[  
                                PrimaryButton(
                                  onClick: (){ 
                                    Navigation.changeToBack(context);
                                  },
                                  marginRight: 5,
                                  width: 150, 
                                  height: 35, 
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  icon: CupertinoIcons.back,  
                                  borderRadius: 100,
                                  iconSize: 16,
                                  iconMargin: EdgeInsets.only(
                                    left: 10
                                  ),
                                  title: "Voltar",
                                  textColor: Colors.grey,
                                  backgroundColor: Colors.transparent
                                ), 
                              ]
                            ) 
                          ),
                          Column(
                            children: [    
                              Container(
                                margin: EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                        top: 10
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 10
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.white.withOpacity(0.125),
                                            width: 1.1
                                          )
                                        )
                                      ),
                                      child: CustomImage(
                                        local: false, 
                                        image: widget.eventLogo, 
                                        width: 122, 
                                        height: 65, 
                                        fit: BoxFit.fitHeight
                                      )
                                    ),
                                    TitleH3(
                                      margin: EdgeInsets.only(
                                        left: 10
                                      ),
                                      title: "Ingressos",
                                      fontColor: Colors.white.withOpacity(0.65),
                                      fontSize: 22,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 40,
                                  left: 10,
                                  right: 10,
                                  bottom: 30
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height - 295,
                                  child: ListView(
                                    padding: noPadding,
                                    children: (_planCards == null) ? [LoadingBlock()] : _planCards!
                                  ),
                                )
                              ),
                            ]
                          ),
                          Container(
                            width: 140,
                            height: 30,
                            child: Image.asset(
                              "assets/images/logo_principal_preto.png",  
                              width: 140, 
                              height: 30,  
                            )
                          )
                        ],
                      ),
                    ]
                  )
                ),
              )
            )
          )
        )
      ]
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
}