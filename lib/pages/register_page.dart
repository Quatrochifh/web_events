import 'dart:async';
import 'dart:ui';
import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/form/widget_input.dart';
import 'package:appweb3603/components/radio/widget_radio_group.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/components/widget_title_h3.dart';
import 'package:appweb3603/entities/Plan.dart';
import 'package:appweb3603/entities/form/Field.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventPlanService.dart';
import 'package:appweb3603/services/EventSubscriptionService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  final String eventCode;

  final String eventName;

  final String eventLogo;

  final String? eventBackground;

  final String? loginEmail;

  final String? loginPassword;

  final int planId;

  RegisterPage({
    Key? key,
    required this.planId,
    this.eventBackground,
    required this.eventCode,
    required this.eventName,
    required this.eventLogo,
    this.loginEmail,
    this.loginPassword
  }) : super(key : key);

  @override
  RegisterPageState createState() => new RegisterPageState();
} 

class RegisterPageState extends State<RegisterPage> with PageComponent {

  Timer? _timer;
  DecorationImage? _decorationBackgroundImage;
  Plan? _plan;
  List<dynamic> _inputs = [];
  List<TitleH3> _texts = [];
  List<Widget> _formFields = [];
  Map<dynamic, dynamic> _formFieldsValues = {}; // Processado ao clicar em submeter formulário

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

    _loadPlan();
  }


  void _loadPlan() async {
    EventPlanService planService = new EventPlanService();
    dynamic plan = await planService.fetchPlanById(widget.planId);

    if (plan != null) {
      _plan = plan;
    } else { 
      _plan = new Plan();
    }

    if (!mounted) return;

    setState(() {
      _plan = _plan;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      _loadPlanForm();
    });
  }

  void _loadPlanForm() async {
    EventPlanService planService = new EventPlanService();
    dynamic planForm = await planService.fetchPlanForm(widget.planId, _plan!.eventId);

    if (planForm == null) {
      return;
    }

    planForm.forEach((Field field) {

      GlobalKey<State> fieldGK = new GlobalKey();

      // Campo do tipo input
      if (field.fieldType == "text") {
        _formFieldsValues[field.keyName] = fieldGK;
        _texts.add(
          TitleH3(
            title: field.title,
            fontWeight: FontWeight.normal,
            fontSize: 13.4,
            fontColor: Colors.white.withOpacity(0.7),
            margin: EdgeInsets.only(
              bottom: 3
            ),
          )
        );
        _inputs.add(
          Input(
            key: fieldGK,
            margin: EdgeInsets.only(
              bottom: 15.6
            ),
            width: double.infinity,
            height: 40,
            labelText: field.title,
            borderColor: Colors.white.withOpacity(0.125),
            validatorFunction: () {},
            obscureText: field.keyName == "password",
          )
        );
      }

      // Campo do tipo radio
      if (field.fieldType == "radio") {
        _formFieldsValues[field.keyName] = fieldGK;
        _texts.add(
          TitleH3(
            title: field.title,
            fontWeight: FontWeight.normal,
            fontSize: 13.4,
            fontColor: Colors.white.withOpacity(0.7),
            margin: EdgeInsets.only(
              bottom: 3
            ),
          )
        );
        _inputs.add(
          RadioGroup(
            key: fieldGK,
            groupId: field.objectId,
            options: field.options
          )
        );
      }
    });

    if (!mounted) return;

    for (int p = 0; p < _inputs.length; p++) {
      _formFields.add(
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              _texts[p],
              _inputs[p],
            ],
          ),
        )
      );
    }

    _formFields.add(
        Container(
          margin: EdgeInsets.only(
            top: 40,
            left: 5,
            right: 5
          ),
          child: PrimaryButton(
            onClick: _formSubmit,
            title: "Inscrever-se",
            borderRadius: 10,
          )
        )
      );

    if (!mounted) return;
    setState(() {
      _formFields = _formFields;
    });
  }

  /*
    * Efetuar o cadastro do participante
  */
  void _formSubmit() async {

    if (!mounted) return;

    Map<String, dynamic> formFiels = {};

    _formFieldsValues.forEach((key, value) {
      dynamic fValue;
      dynamic stateName = value.currentState.toString().split('#')[0];
      if (stateName == "InputState") {
        fValue = value.currentState.getValue().toString();
      } else if (stateName == "RadioGroupState") {
        fValue = value.currentState.getValue().toString();
      }
      formFiels[key] = fValue;
    });

    // Show loading
    showLoading();

    EventSubscriptionService subscription = new EventSubscriptionService();
    dynamic results = await subscription.subscriptionInEvent(_plan!.eventId, _plan!.id, formFiels);

    if (results['status'] == 1) {
      showNotification(message: results['message'], type: 'success');
    } else {
      showNotification(message: results['message'], type: 'warning');
    }

    //Hide loading
    hideLoading();
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
                                margin: EdgeInsets.only(
                                  top: 10
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 10,
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TitleH3(
                                          margin: EdgeInsets.only(
                                            left: 10
                                          ),
                                          title: "Inscreva-se",
                                          fontColor: Colors.white.withOpacity(0.65),
                                          fontSize: 22,
                                          alignment: Alignment.center,
                                        ),
                                        _plan == null
                                          ?
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: LoadingBlock(imageSize: 15)
                                            )
                                          :
                                            (
                                              _plan!.id < 1
                                                ?
                                                  SizedBox.shrink()
                                                :
                                                  TitleH3(
                                                    margin: EdgeInsets.only(
                                                      top: 1.5,
                                                      left: 10
                                                    ),
                                                    maxLines: 1,
                                                    alignment: Alignment.center,
                                                    fontColor: Colors.white,
                                                    fontSize: 20,
                                                    title: _plan!.title,
                                                  )
                                            )
                                      ]
                                    )
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
                                    children:
                                    [
                                      _plan == null || _formFields.isEmpty
                                       ?
                                        LoadingBlock()
                                      :
                                        (
                                          _plan!.id < 1
                                            ?
                                              Message(
                                                textAlign: TextAlign.center,
                                                padding: EdgeInsets.all(10),
                                                text: "Plano selecionado não existe.",
                                              )
                                            :
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: 75
                                                ),
                                                child:  Column(
                                                  children: _formFields,
                                                )
                                              )
                                        )
                                    ]
                                  ),
                                )
                              ),
                            ]
                          ),
                          Container(
                            width: 140,
                            height: 35,
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