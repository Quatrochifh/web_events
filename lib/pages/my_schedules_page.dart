import 'package:appweb3603/components/buttons/widget_primary_button.dart'; 
import 'package:appweb3603/components/schedule/widget_schedule_days.dart';
import 'package:appweb3603/components/schedule/widget_schedules.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_message.dart'; 
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Schedule.dart';
import 'package:appweb3603/helpers.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart'; 

class MySchedulePages extends StatefulWidget{ 

  final String? startFeed;

  MySchedulePages({Key? key, this.startFeed}) : super(key : key);

  @override
  MySchedulePagesState createState() => new MySchedulePagesState();
} 

class MySchedulePagesState extends State<MySchedulePages> with PageComponent {  
 
  bool get wantKeepAlive => true; 

  Controller controller  = Modular.get<Controller>();  

  List<String> _daysItem = []; 

  List<Schedule> _actitivities = [];

  GlobalKey<SchedulesState> _schedulesState = new GlobalKey(); 

  @override 
  void initState(){
    super.initState(); 

    showLoading(); 

    /*
      Vamos buscar pelas datas de atividades
    */
    Modular.get<Controller>().event.then((event){
      Modular.get<EventService>().eventActivitiesSubscriptionsDates( event.id ).then((results){
        hideLoading();
        if( results != null ){  
          _daysItem  = results;

          //Vamos carregar, automaticamente, o primeiro item.
          fetchActivities( _daysItem.isNotEmpty ? _daysItem[0] :  null );
        }
      });
    });
  }

  void fetchActivities(String? date) {
    showLoading();

    if(date == null) {
      hideLoading();
      return;
    }
    /*
      Vamos buscar pelo atividade
    */
      Modular.get<Controller>().event.then((event){
        Modular.get<EventService>().eventActivities( event.id , date, true ).then((results){
          hideLoading(); 
          if( results != null ){   
            _actitivities = results; 
          }else{
            _actitivities = [];
          }
          _schedulesState.currentState!.updateSchedules(_actitivities);
        });  
    });
    

  }

  @override
  Widget build(BuildContext context){
      
    return content(
      color: mainBackgroundColor,
      padding: EdgeInsets.only(top: 45),
      body: <Widget>[ 
        Expanded( 
            flex: 6, 
            child: _daysItem.isEmpty 
              ? 
                EmptyMessage()
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
          fontSize: 13.5,
          title: "Agenda do Evento",
          onClick:(){ 
            navigatorPushNamed(context, '/view-schedules');
          },
          iconMargin: EdgeInsets.only(left: 10),
        ),
        event: controller.currentEvent,
        back: true,
        hideUser: true,
        title: "Minha Agenda",
        user: controller.currentUser
      )
    );
  
  }

}      