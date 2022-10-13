
import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/components/buttons/widget_logout_button.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer_footer.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer_header.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer_section.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../buttons/widget_primary_button.dart';

class NavDrawer extends StatefulWidget{

  NavDrawer({Key? key}) : super(key: key);  

  @override
  NavDrawerState createState() =>  new NavDrawerState();
}

class NavDrawerState extends State<NavDrawer> with AutomaticKeepAliveClientMixin{

  @override 
  bool get wantKeepAlive => true;

  int currentStep = 0;

  @override 
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        top: true, 
        bottom: false, 
        child: Container(
          height: MediaQuery.of(context).size.height, 
          child: Column(
              children: [
                NavDrawerHeader(user: globalDIContainer.get(User) as User),
                Expanded(
                  child: ListView(
                    padding: noPadding,
                    children: [
                      NavDrawerSection(
                        visibility: true,
                        height: 60,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: LogoutButton()
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  title: "Meu Perfil",
                                  onClick: (){
                                    Navigation.changeToEditProfile(context);
                                  },
                                  icon: CupertinoIcons.profile_circled,
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  borderRadius: 50,
                                  noBorder: true,
                                  textColor: Colors.black.withOpacity(0.5),
                                  fontSize: 13.5,
                                  iconSize: 16,
                                  height: 35,
                                  padding: EdgeInsets.all(8.5), 
                                )
                              )
                            ],
                          ) 
                        ]
                      ),
                      NavDrawerSection(
                        visibility: true,
                        children: [
                          Expanded(
                            child:
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToMain(context); },
                                title: "Home",
                                icon: CupertinoIcons.house,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                              fontSize: 16.8,
                                iconSize: 18, 
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child:
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToFeed(context); },
                                title: "Feed",
                                icon: CupertinoIcons.square_on_square,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                              fontSize: 16.8,
                                iconSize: 18, 
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToMySchedules(context); },
                                title: "Minha Agenda",
                                icon: CupertinoIcons.calendar_today,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21, 
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToFiles(context); },
                                title: "Documentos",
                                icon: CupertinoIcons.doc_plaintext,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21, 
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child:
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToMaps(context); },
                                title: "Mapas",
                                icon: CupertinoIcons.map,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 18, 
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToParticipants(context); },
                                title: "Participantes",
                                icon: CupertinoIcons.person_3,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21,
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ), 
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToSpeakers(context); },
                                title: "Palestrantes",
                                icon: CupertinoIcons.person_2_square_stack,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21,
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToGaleria(context); },
                                title: "Galeria",
                                icon: CupertinoIcons.photo_on_rectangle,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21,
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ), 
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToTransmissions(context); },
                                title: "Vídeos",
                                icon: CupertinoIcons.play_circle,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21,
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){ Navigation.changeToLinks(context); },
                                title: "Links úteis",
                                icon: CupertinoIcons.link,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21,
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                          Expanded(
                            child: 
                              PrimaryButton(
                                iconMargin: EdgeInsets.only(right: 20),
                                onClick:(){
                                  Navigation.changeToSecurity(context);
                                },
                                title: "Conf. de Conta",
                                icon: CupertinoIcons.gear,
                                backgroundColor: Colors.transparent,
                                borderRadius: 0,
                                noBorder: true,
                                textColor: Colors.black.withOpacity(0.7),
                                iconColor: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.8,
                                iconSize: 21,
                                height: 35,
                                padding: noPadding,
                                mainAxisAlignment: MainAxisAlignment.start
                              )
                          ),
                        ]
                      ),
                    ],
                  )
                ),
                NavDrawerFooter(event: globalDIContainer.get(Event) as Event),
              ],
            )
        )
      )
    );
  }
} 

   