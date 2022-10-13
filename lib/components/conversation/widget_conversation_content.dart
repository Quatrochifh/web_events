import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/conversation/widget_conversation_message.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart'; 

class ConversationContent  extends StatefulWidget {  

  final List<ConversationMessage> messages;

  final Function loadMessagesFunction;

  ConversationContent({Key? key, required this.loadMessagesFunction, required this.messages}) : super(key: key); 

  @override
  ConversationContentState createState() => ConversationContentState();

}

class ConversationContentState  extends State<ConversationContent> {  

  bool _showButtonShowMore = true;

  @override
  void initState(){ 
    super.initState();  
  }

  @override 
  Widget build(BuildContext context){ 

    return Container( 
      width: double.infinity,
      child: Stack(  
        children: [
          Container(
            margin: EdgeInsets.only(top: 0),
            child: ListView.builder(
              reverse: true,
              itemCount: widget.messages.length,
              itemBuilder: (context, index){ 
                return widget.messages[ (widget.messages.length - 1) - index ];
              }
            )
          ),
          /*
            Botão de carregar mensagens
          */
          ( _showButtonShowMore == false ) 
            ?
              Positioned(
                child: SizedBox.shrink()
              )
            :
              Positioned(
                top: templateHeaderHeigth + MediaQuery.of(context).padding.top,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: PrimaryButton(
                    onClick: (){
                      widget.loadMessagesFunction().then((r){
                        if(!mounted) return;
                        if( r == null ){
                          setState((){
                            _showButtonShowMore = false;
                          });
                        }else{
                          setState((){
                              _showButtonShowMore = true;
                          });
                        }
                      });
                    },
                    title: "Carregar mensagens", 
                    borderRadius: 100,
                    padding: noPadding,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    backgroundColor: primaryColor,
                    width: 260,
                    height: 45,
                    textColor: Colors.white,
                    shadow: true,
                    icon: CupertinoIcons.arrow_2_circlepath
                  )
                ),
              )
        ],
      )
    );

  }


}
