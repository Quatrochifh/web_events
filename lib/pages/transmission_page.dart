import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Post.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/forms/video_comment_form.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/video/video_comment.dart';
import 'package:appweb3603/components/widget_empty_box.dart';
import 'package:appweb3603/components/widget_loading_block.dart'; 
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/components/widget_section_main.dart';
import 'package:appweb3603/components/widget_text_icon.dart';
import 'package:appweb3603/components/widget_title_h3.dart';  
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Transmission.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/components/vimeo_player.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers.dart';
 
class TransmissionPage extends StatefulWidget{   

  final Transmission transmission;

  TransmissionPage({
    Key? key,
    required this.transmission
  }) : super(key: key);

  @override
  TransmissionPageState createState() => new TransmissionPageState();
}


class TransmissionPageState extends State<TransmissionPage> {
  @override
  Widget build(BuildContext context) {
    return _TransmissionPageVideo(transmission: widget.transmission);  
  }
}  

class _TransmissionPageVideo extends StatefulWidget { 

  final Transmission transmission;

  _TransmissionPageVideo({Key? key, required this.transmission}) : super(key: key);  

  @override
   _TransmissionPageVideoState createState() => _TransmissionPageVideoState();

}

class _TransmissionPageVideoState extends State<_TransmissionPageVideo> with PageComponent, AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  int _currentPage = 1;

  List<VideoComment>? _comments;

  bool _noMoreReplies = false;

  Controller controller = Modular.get<Controller>();
 
  @override 
  void initState(){
    super.initState();

    this._fetchComments();
  }

  Future _submitComment({String comment = ""}) {
    Post post = new Post();
    return post.publishPost(comment, "", reference: "transmission", referenceId: widget.transmission.id).then((results){
      if (results != false) {
        _comments!.add(
          VideoComment(
            post: results
          )
        );
      }

      return results != false;
    });
  }

  void _fetchComments() {
    Post post = new Post();
    post.fetchPosts(reference: "transmission", page: _currentPage, referenceId: widget.transmission.id).then((results) {
       _comments ??= [];

      if(results.isNotEmpty){
        results.forEach((value) {
          _comments!.add(
            VideoComment(
              post: value
            )
          );
        });
        _currentPage = _currentPage + 1;
      }else{
        setState((){
          _noMoreReplies = true;
        }); 
      }

      setState(() {
        _comments = _comments;
        _currentPage = _currentPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return content(
      resizeToAvoidBottomInset: true,
      color: mainBackgroundColor,
      padding: EdgeInsets.only(top:10),
      body:  <Widget>[ 
        Expanded( 
          child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: VimeoPlayerCustom(
                videoId: widget.transmission.videoId()!
              )
            ),
            Container(
              width: double.infinity, 
              decoration: BoxDecoration(
                color: Colors.transparent
              ), 
              child: SectionMain(
                background: Colors.white,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container( 
                      margin: EdgeInsets.only(bottom: 15), 
                      child: Text(
                        widget.transmission.title,
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle( 
                          overflow: TextOverflow.ellipsis, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 18.5, 
                          color: Color.fromRGBO(0, 0, 0, 1),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 15
                      ),
                      child: Row( 
                        children: [ 
                          Expanded(
                            child: Row( 
                              children: [
                                TextIcon(
                                  iconMargin: 7,
                                  size: 12,
                                  text: dateTimeFormat(widget.transmission.dateRegister, dateFormat:  'dd/MM/yy' ),
                                  icon: FontAwesomeIcons.calendar, 
                                  color: Color.fromARGB(221, 36, 36, 36),
                                ), 
                                TextIcon(
                                  iconMargin: 7,
                                  size: 12,
                                  text: widget.transmission.duration,
                                  icon: FontAwesomeIcons.clock, 
                                  color: Color.fromARGB(221, 36, 36, 36),
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    TitleH3(
                      title: "Descrição",
                    ),
                    Message(
                      fontSize: 16.6,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10
                      ),
                      noBorder: true,
                      bgColor: Colors.transparent,
                      textColor: Colors.black,
                      text: widget.transmission.description,
                    )
                  ]
                )
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent
              ), 
              child: SectionMain(
                background: Colors.white,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VideoCommentForm(
                      user: globalDIContainer.get(User) as User,
                      feedback: _submitComment,
                      cancelOnclick: () {},
                    )
                  ]
                )
              )
            ),
            Container(
              width: double.infinity, 
              decoration: BoxDecoration( 
                color: Colors.transparent
              ), 
              child: SectionMain(
                background: Colors.white,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child:  Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 25
                      ), 
                      child: Text(
                        "Comentários",
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(
                          letterSpacing: primaryLetterSpacing,
                          overflow: TextOverflow.ellipsis, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 22.5, 
                          color: Color.fromRGBO(0, 0, 0, 1),
                        )
                      ),
                    ),
                    (_comments == null)
                      ?
                        LoadingBlock()
                      :
                        (_comments != null && _comments!.isNotEmpty)
                          ?
                            Column(
                              children: _comments!,
                            )
                          :
                            EmptyBox(
                              message: "Seja o primeiro a comentar.",
                            ),
                    (!_noMoreReplies) 
                      ?
                        PrimaryButton(
                          marginBottom: 50,
                          marginTop: 20,
                          marginRight: 7.5,
                          marginLeft: 7.5,
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                          onClick: _fetchComments,
                          icon: CupertinoIcons.arrow_down,
                          fontSize: 16,
                          onlyBorder: true,
                          borderRadius: 10,
                          title: "Carregar comentários"
                        )
                      :
                        SizedBox.shrink()
                  ]
                )
              )
            )
          ],
        )
        )
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar(
        event: controller.currentEvent,
        back: true,
        hideUser: true,
        hideMenu: true,
        title: widget.transmission.title,
        user: controller.currentUser
      ),
    );
  }
}  