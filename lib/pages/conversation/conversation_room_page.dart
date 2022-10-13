import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Conversation.dart';
import 'package:appweb3603/components/widget_empty_message.dart';
import 'package:appweb3603/entities/Conversation.dart' as entityconversation;
import 'package:appweb3603/components/buttons/widget_button_chiclete.dart';
import 'package:appweb3603/components/conversation/widget_conversation_content.dart';
import 'package:appweb3603/components/conversation/widget_conversation_form.dart';
import 'package:appweb3603/components/conversation/widget_conversation_message.dart';
import 'package:appweb3603/components/conversation/widget_conversation_receiver_header.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/ConversationService.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart';

class ConversationRoom extends StatefulWidget{ 

  final entityconversation.Conversation conversation;

  const ConversationRoom({Key? key, required this.conversation}) : super(key: key);

  @override
  ConversationRoomState createState() => ConversationRoomState();
}

class ConversationRoomState extends State<ConversationRoom> with PageComponent, AutomaticKeepAliveClientMixin{  

  @override 
  bool get wantKeepAlive => true;

  final Controller controller  = Modular.get<Controller>();

  List<ConversationMessage>? _messages;

  int receiverID = 0;
  String _receiverAvatar = "";
  String _receiverName = "";
  int _currentPage = 0;    

  Future<dynamic> loadMessages(){
    showLoading();

    setState((){
      _currentPage += 1;
    });

    List<ConversationMessage> messages = [];

    return Modular.get<Controller>().event.then((event){
      return Modular.get<ConversationService>().getMessagesByReceiver(event.id, receiverID, _currentPage).then((results){
        hideLoading();
        if( results != null && results.isNotEmpty ){
          results.forEach((value){
            messages.add( 
              ConversationMessage( conversation: value, rightPosition: value.author ?? false, )
            );
          });

          messages = messages.reversed.toList();

          if( !mounted ) return null;
          setState((){
            _messages = messages + _messages!;
          });

          return true;
        }else{
          return null;
        }
      });
    });
  }

  @override 
  void initState(){
    super.initState();

    receiverID =  widget.conversation.senderID.toString() == Modular.get<Controller>().currentUser.id.toString() ||  widget.conversation.senderID == 0
      ? 
        widget.conversation.receiverID 
      : 
        widget.conversation.senderID;
        
    setState((){
      _messages  = [];
      receiverID = receiverID;
    });

    if (widget.conversation.receiverName.isNotEmpty) {
      _receiverName = widget.conversation.receiverName;
      _receiverAvatar = widget.conversation.receiverAvatar;
      setState((){
        _receiverName = _receiverName;
        _receiverAvatar = _receiverAvatar;
      });
    }

    Modular.get<EventService>().findUser((globalDIContainer.get(Event) as Event).id, receiverID).then((results){
      if (results.runtimeType.toString() != 'String') {
        _receiverName = results['name'];
        _receiverAvatar = results['avatar'];
      }
      setState((){
        _receiverName = _receiverName;
        _receiverAvatar = _receiverAvatar;
      });
    });
  
    loadMessages();
  }

  Future<dynamic> _sendMessage({String message = "", String? attachment}){
    showLoading();
    return Modular.get<Conversation>().sendMessage(receiverID, message, attachment).then((conversation){
      hideLoading();
      if(conversation.runtimeType.toString() == "Conversation"){

        conversation.senderID =  Modular.get<Controller>().currentUser.id;
        conversation.senderAvatar =  Modular.get<Controller>().currentUser.avatar;

        _messages =_messages! + [ 
          ConversationMessage(conversation: conversation, rightPosition: true, imageBase64: attachment)
        ];

        if (!mounted) return true;

        setState((){
          _messages = _messages;
        });

        return true;
      } else {
        if (message.length <= 2) {
          registerNotification(message: "A mensagem deve ter pelo menos 3 caracteres.", type: "warning");
        }
        if (message.length >= 120) {
          registerNotification(message: "A mensagem deve ter até 120 caracteres.", type: "warning");
        }
        if (conversation.runtimeType.toString() == "String") {
          registerNotification(message: conversation ?? "", type: "warning");
        }
      }

      return conversation;
    });
  }

  @override
  Widget build(BuildContext context){
    super.build(context);

    return content(
      resizeToAvoidBottomInset: true,
      body: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              children: [
                ( _messages != null ) 
                  ?
                    ( _messages!.isEmpty ) 
                      ?
                        EmptyMessage(message: "Chat vazio. Envie uma mensagem!")
                      :
                        Expanded( 
                          child: ConversationContent(
                            messages: _messages!, 
                            loadMessagesFunction: loadMessages
                          ),
                        )
                  :
                    LoadingBlock(
                      text: "Carregando mensagens ..."
                    )
                ,
                Container(
                  padding: EdgeInsets.only(
                    bottom: templateFooterHeigth + MediaQuery.of(context).padding.bottom
                  ),
                )
              ],
            )
          )
        )
      ],
      showFooter: false,
      drawer: NavDrawer(),
      positioned: <Widget>[
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: templateHeaderHeigth + MediaQuery.of(context).padding.bottom,
            child: ConversationForm(currentUser: Modular.get<Controller>().currentUser, onSubmit: _sendMessage)
          )
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: templateHeaderHeigth + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration( 
              color: Colors.black.withOpacity(0.125)
            ),
            margin: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: bgWhiteBorderColor,
                    width: 0.5
                  )
                )
              ),
              height: 100,
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    ButtonChiclete(
                      onClick: (){ 
                        Navigator.of(context).pop();
                      },
                      iconColor: Colors.black,
                      icon: CupertinoIcons.back,
                    ),
                    (_receiverName.isNotEmpty)
                      ?
                        Expanded(
                          child: ConversationReceiverHeader(
                            receiverName: _receiverName,
                            receiverAvatar: _receiverAvatar,
                            receiverCargo: ""
                          )
                        )
                      :
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: LoadingBlock(imageSize: 20, transparent: true,)
                        )
                      )
                  ],
                )
              )
            ),
          )
        )
      ]
    );
  }

}