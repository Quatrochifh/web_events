 
import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Event.dart';
import 'package:appweb3603/bloc/Navigation.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/expositor/widget_expositor_preview.dart';
import 'package:appweb3603/components/loader/widget_banner_loader.dart';
import 'package:appweb3603/components/loader/widget_post_loader.dart';
import 'package:appweb3603/components/loader/widget_speaker_loader.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/components/widget_custom_banner.dart';
import 'package:appweb3603/components/widget_google_maps_open.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/components/widget_section_main.dart';
import 'package:appweb3603/components/widget_slide.dart';
import 'package:appweb3603/components/widget_social_medias.dart';
import 'package:appweb3603/components/widget_speaker_card.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Announcement.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb3603/entities/Event.dart' as entity;
import 'package:appweb3603/bloc/Feed.dart' as feed_bloc;
import 'package:appweb3603/bloc/Event.dart' as event_bloc;

class MainPage extends StatefulWidget{ 

  final String? startFeed;

  MainPage({Key? key, this.startFeed}) : super(key : key);

  @override
  MainPageState createState() => new MainPageState();
} 

class MainPageState extends State<MainPage> with PageComponent {

  List<SpeakerCard>? _speakersCard;
  List<CustomBanner>? _bannersList;
  List<Widget>? _postsList;
  List<Widget>? _expositorsList;
  Announcement? _liveTransmission;
  entity.Event event = globalDIContainer.get(entity.Event) as entity.Event;

  @override 
  void initState(){
    super.initState();

    _loadSpeakers();
    _loadBanners();
    _loadExpositors();
    _currentLive();
    _loadPosts();
  }

  /*
   *  Carregar expositores
  */
  void _loadExpositors(){
    (event_bloc.Event()).eventExpositors().then((expositors){
      _expositorsList = [];
      if (expositors != null) {
        for(int i = 0; i < expositors.length; i++) {
          _expositorsList!.add(
            ExpositorPreview(
              onTap: showFloatScreen,
              expositor: expositors[i],
            )
          );
        }
        setState((){
          _expositorsList = _expositorsList;
        });
      }
    });  
  }

  /*
   * Carregar posts
  */
  void _loadPosts(){
    (feed_bloc.Feed()).fetchPosts(page : 1, inline: true).then((results){
      if(results.isNotEmpty){
        setState((){ 
          _postsList = results;
        });
      } else {
        _postsList = [];
      }
    });  
  }

  void _currentLive() {
    /*  
      * Vamos checar se há evento ao vivo
    */ 
    Modular.get<EventService>().currentLive(event.id).then((results){
      // Vamos esconder o loading
      hideLoading();
      if(results != null){  
        _liveTransmission = Announcement( 
          linkUrl: results.videoUrl, 
          backgroundImage: results.thumbnail
        );
      }
    });
  }

  /*
   * Banners
  */
  void _loadBanners() {
    Modular.get<Event>().eventBanners(limit: 10, offset: 0).then((banners) {
      _bannersList = [];
      for(int i = 0; i < banners.length; i++) {
        _bannersList!.add(
          CustomBanner(
            announcement: banners[i],
            inSlide: true,
            ratio: 0.75,
            height: 190,
          )
        );
      }
      setState((){
        _bannersList = _bannersList;
      });
    });
  }

  /*
   * Palestrantes (apenas os 2 primeiros)
  */
  void _loadSpeakers() {
    Modular.get<Event>().eventSpeakers(limit: 10, offset: 0).then((speakers){
      _speakersCard = [];
      for(int i = 0; i < speakers.length; i++) {
        _speakersCard!.add(
          SpeakerCard(
            speaker: speakers[i]
          )
        );
      }
      setState((){
        _speakersCard = _speakersCard;
      });
    });
  }

  @override
  Widget build(BuildContext context){

    // Vamos requerer a autenticação.
    Modular.get<Controller>().requireAuthentication( context ); 

    return content(
      color: mainBackgroundColor,
      padding: EdgeInsets.all(0), 
      body:  <Widget>[
        Expanded(
          child: ListView(
            padding: noPadding,
            children: [
              (_liveTransmission != null)
                ? 
                  CustomBanner(
                    inSlide: false,
                    onlyBackground: true,
                    announcement: _liveTransmission!
                  )
                : 
                  SizedBox.shrink(),
                  (_bannersList == null || _bannersList!.isNotEmpty) ?
                    Container(
                      child: _bannersList != null && _bannersList!.isNotEmpty ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slide(
                              itemExtent: true,
                              ratio: 0.75,
                              height: 190,
                              children: _bannersList!
                            ) 
                          ],
                        )
                      :
                        Slide(
                          ratio: 0.5,
                          height: 170,
                          children: const [
                            BannerLoader(),
                            BannerLoader(),
                            BannerLoader(),
                          ]
                        )
                    )
                  :
                    SizedBox.shrink(),
              (_postsList == null || _postsList!.isNotEmpty) ?
                SectionMain(
                  height: 465,
                  margin: EdgeInsets.only(bottom: 10),
                  title: "Feed",
                  icon: CupertinoIcons.chat_bubble_2,
                  child:
                  _postsList == null 
                  ?
                    Slide(
                      ratio: 0.85,
                      height: 280,
                      children: const [
                        PostLoader(),
                        PostLoader(),
                        PostLoader(),
                      ]
                    )
                  :
                    Column(
                      children:[
                        Slide(
                          ratio: 0.85,
                          height: 280,
                          children: _postsList!
                        ),
                        PrimaryButton(
                          onClick: (){
                            Navigation.changeToFeed(context);
                          },
                          icon: CupertinoIcons.chevron_right,
                          marginLeft: 10,
                          marginRight: 10,
                          marginTop: 10,
                          marginBottom: 50,
                          height: 45,
                          title: "Ver mais publicações",
                          iconRight: true,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          borderRadius: 5,
                          backgroundColor: primaryColor,
                        )
                      ]
                    )
                )
              :
                SizedBox.shrink(),
              
             (_speakersCard == null || _speakersCard!.isNotEmpty) ?
                SectionMain(
                  title: "Palestrantes",
                  borderColor: Colors.transparent,
                  icon: CupertinoIcons.person_2_square_stack_fill,
                  child: Container(
                    height: 180,
                    child: _speakersCard!= null && _speakersCard!.isNotEmpty ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slide(
                              ratio: 0.4,
                              height: 170,
                              children: _speakersCard!
                            ) 
                          ],
                        )
                      :
                        Slide(
                          ratio: 0.5,
                          height: 170,
                          children: const [
                            SpeakerLoader(),
                            SpeakerLoader(),
                            SpeakerLoader(),
                          ]
                        )
                      )
                )
              :
                SizedBox.shrink(),
              (_expositorsList == null || _expositorsList!.isNotEmpty)
                ?
                  SectionMain(
                    title: "Expositores",
                    icon: CupertinoIcons.cube_box,
                    borderColor: Colors.transparent,
                    child: Slide(
                      ratio: 1.25,
                      height: 220,
                      children: _expositorsList ?? []
                    )
                  )
                :
                  SizedBox.shrink(),
              SectionMain(
                margin: EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 25
                ),
                borderRadius: borderMainRadius,
                background: Colors.white,
                title: "Sobre ${event.title}",
                icon: CupertinoIcons.info,
                child: Column(
                  children: [
                    // Descrição do evento
                    Message(
                      bgColor: Colors.transparent,
                      margin: noMargin,
                      textColor: Colors.black,
                      text: event.description,
                    ),

                    // Outros detalhes
                    Details(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      titleColor: Colors.grey,
                      titleSize: 11.6,
                      marginBottom: 6,
                      descriptionColor: Colors.black,
                      inline: true,
                      items: {
                        "Inicio" : (globalDIContainer.get(entity.Event) as entity.Event).startDatetime,
                        "Término" : (globalDIContainer.get(entity.Event) as entity.Event).endDatetime,
                      }
                    ),

                    // Outros detalhes
                    Details(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      titleColor: Colors.grey,
                      titleSize: 11.6,
                      marginBottom: 6,
                      descriptionColor: Colors.black,
                      items: {
                        "Localização" : event.location,
                        "Endereço" : "${event.localityStreet}, Nº ${event.localityNumber}",
                        "CEP" : event.localityZipCode,
                      }
                    ),

                    // MapsComponent
                    GoogleMapsOpen(eventCode: event.code),

                    // Redes sociais do evento
                    SocialMedias(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      items: event.social
                    )
                  ],
                )
              )
            ],
          )
        )
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar(event:  Modular.get<Controller>().currentEvent, user:  Modular.get<Controller>().currentUser ) 
    );  
 
  }

} 

