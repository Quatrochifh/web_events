import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/loader/widget_schedule_loader.dart';
import 'package:appweb3603/components/schedule/widget_schedule_days.dart';
import 'package:appweb3603/components/schedule/widget_schedules.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_list_component.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Schedule.dart';
import 'package:appweb3603/helpers.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart'; 

class SchedulesPage extends StatefulWidget{ 

  final String? startFeed;

  SchedulesPage({Key? key, this.startFeed}) : super(key: key);

  @override
  SchedulesPageState createState() => new SchedulesPageState();
} 

class SchedulesPageState extends State<SchedulesPage> with PageComponent {  

  bool get wantKeepAlive => true; 

  Controller controller  = Modular.get<Controller>();  

  List<String> _daysItem = []; 

  List<Schedule> _actitivities = [];

  GlobalKey<SchedulesState> _schedulesState = new GlobalKey(); 

  @override 
  void initState(){
    super.initState(); 

    //Exibir o loading
    showLoading(); 

    //Vamos buscar pelas datas de atividades 
    Modular.get<Controller>().event.then((event){
      Modular.get<EventService>().eventActivitiesDates(event.id).then((results) {

        //Vamos esconder o loading
        hideLoading();
        if( results != null && results.isNotEmpty ){  
          _daysItem  = results;

          //Vamos carregar, automaticamente, o primeiro item.
          fetchActivities(_daysItem[0]);
        }
      }); 
    });
  }

  void fetchActivities(String date){ 
    showLoading();
    Modular.get<Controller>().event.then((event){
      Modular.get<EventService>().eventActivities(
        event.id,
        date,
        false
      ).then((results){
        hideLoading(); 
        if(results != null && _schedulesState.currentState != null){
          _actitivities = results;
          _schedulesState.currentState!.updateSchedules(_actitivities);
        } 
      });  
    });
  }

  @override
  Widget build(BuildContext context){  

    //Requerer autenticação para esta tela
    controller.requireAuthentication(context);  
      
    return content(
      color: mainBackgroundColor,
      padding: EdgeInsets.only(top: 45),
      body:  <Widget>[ 
        Expanded( 
          flex: 6, 
          child: _daysItem.isEmpty 
            ? 
              ListComponent(
                children: const [
                  ScheduleLoader(),
                  ScheduleLoader(),
                  ScheduleLoader(),
                ]
              )
            : 
            Stack( 
              children: [
                Container(
                  margin: EdgeInsets.all(0),
                  child: Schedules(
                    key: _schedulesState,
                    user: Modular.get<Controller>().currentUser, event: Modular.get<Controller>().currentEvent
                  ),
                ),
                Positioned(
                  child: ScheduleDays(
                    dates: _daysItem,
                    feedback: fetchActivities
                  ), 
                )
              ],
            )
        )
      ],
      drawer: NavDrawer(),
      header: TemplateAppBar(
        customButton: PrimaryButton(
          textColor: primaryColor,
          borderRadius: 100,
          backgroundColor: primaryColorLigther,
          width: 180,
          height: 40,
          icon: CupertinoIcons.calendar,
          title: "Minha Agenda",
          onClick:(){
            navigatorPushNamed(context, '/view-my-schedules');
          },
          iconMargin: EdgeInsets.only(left: 10),
        ),
        event: controller.currentEvent,
        back: true,
        hideUser: true,
        title: "Agenda",
        user: controller.currentUser
      )
    );
  }
}