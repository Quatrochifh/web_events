import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/utils/Permissions.dart';
import 'package:appweb3603/components/buttons/widget_button_badge.dart';
import 'package:appweb3603/components/buttons/widget_button_chiclete.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_avatar.dart'; 
import 'package:appweb3603/components/widget_submit_photo.dart'; 
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/mobx/feed.dart' as feed_mobx;
import 'package:appweb3603/bloc/Feed.dart' as feed_bloc;
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget { 

  final String? startFeed;  
   
  HomePage({Key? key, this.startFeed}) : super(key: key); 

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with PageComponent {

  bool _hasUpload = false;
  bool _noMorePosts = false;
  bool? _noFixedPosts;
  int _currentPage = 1;
  feed_mobx.Feed feedMobx   = Modular.get<feed_mobx.Feed>();
  feed_bloc.Feed? feedBloc  = Modular.get<feed_bloc.Feed>();
  List<Widget>  _postsList      = [];
  List<Widget>  _fixedPostsList = [];
  Controller controller = Modular.get<Controller>();
  String? _feedPhoto;
  ScrollController feedController =  ScrollController();
  double _currentFeedPointerPosition = 0.0;
  
  @override 
  void initState(){
    super.initState();

    feedController.addListener(feedControllerListener);

    _loadFixedPosts();
    _loadPosts();
  }

  void feedControllerListener() {
    _currentFeedPointerPosition = feedController.position.pixels;

    if (mounted) {
      setState(() {
        _currentFeedPointerPosition = _currentFeedPointerPosition;
      });
    }

    if (feedController.position.atEdge) {
      bool isTop = feedController.position.pixels <= templateFooterHeigth;
      if (!isTop && !_noMorePosts) {
        _loadPosts();
      }
    }
  }

  /// Inserção de imagem
  void _showPhotoForm() async {

    bool hasPermission = await Permissions.checkGalleryPermission().then((permission){
      if (permission != true) {
        return Permissions.requestGalleryPermission().then((results){
          if (results != PermissionStatus.granted) {
            return false;
          } else {
            return true;
          }
        });
      } else {
        return true;
      }
    });

    if (hasPermission != true){
      registerNotification(message: "Acesse as configurações e permita o acesso total à Galeria e Câmera.");
      return;
    }

    showFloatScreen(
      title: "Adicionar Foto",
      child: SubmitPhoto(
        photoBase64: _feedPhoto,
        okCallback: _afterPhotoSelected,
        cancelCallback: _afterPhotoCanceled
      )
    );
  }

  /// Quando há a seleção de imagem
  void _afterPhotoSelected(photoBase64){
    hideFloatScreen();
    if (photoBase64 == null) {
      setState((){
        _hasUpload = false; 
        _feedPhoto = photoBase64;
      });
    } else {
      setState((){
        _feedPhoto = photoBase64;
        _hasUpload = true;
      });
    } 
  } 

  /// Quando se cancela a inserção de imagem
  void _afterPhotoCanceled() {
    hideFloatScreen();
  }

  /// 
  /// Esta função é chamada apos a publicacao de um novo post.  
  /// O post deverá ser inserido na posição inicial.
  ///
  Future _afterPostFormPublish(String content) async {

    FocusScope.of(context).requestFocus(new FocusNode());
    
    /// Exibir o loading
    showLoading();
    feedBloc!.publishPost(content, _feedPhoto ?? "").then((results) {
      if(results != false){
        setState((){ 
          _hasUpload = false;
          _feedPhoto = null;
          _postsList.insert(0, results); 
        });
        feedController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.linear);
      }
      hideLoading();
    }); 
  }

  /// Carregará os posts normais
  void _loadPosts(){
    showLoading();
    feedBloc!.fetchPosts(page: _currentPage).then((results){
      if(results.isNotEmpty){
        setState((){
          if(_currentPage > 1){
            _postsList       = _postsList + results;
          }else{
            _postsList       = results + _postsList;
          } 
          hideLoading(); 
          _currentPage = _currentPage + 1;
        }); 
      }else{   
        setState(() {
          _noMorePosts = true;
        });
        hideLoading(); 
      } 
    });  
  }

  /// Carregará os posts fixados
  void _loadFixedPosts(){
    feedBloc!.fetchPosts(page: 1, fixed: true).then((results){
      if(results.isNotEmpty){
        debugPrint("${results.length.toString()} publicações encontradas!");
        setState((){
          _fixedPostsList = results;
          _noFixedPosts = false;
        });
      }else{   
        setState(() {
          _noFixedPosts = true;
        });
      } 
    });  
  }

  @override 
  Widget build(BuildContext context) {
    return content(
      color: mainBackgroundColor,
      positioned:
          _currentFeedPointerPosition > templateHeaderHeigth
        ?
          <Widget>[
          Container(
              margin: EdgeInsets.only(
                top: templateHeaderHeigth + (MediaQuery.of(context).padding.top / 1.5)
              ),
              child: Container(
                width: double.infinity,
                child: FeedFormText(
                  fixed: true,
                  hasUpload: _hasUpload, 
                  showPhotoForm: _showPhotoForm, 
                  initialValue: widget.startFeed, 
                  user: controller.currentUser, 
                  afterPostSubmit: _afterPostFormPublish 
                ),
              )
            )
          ]
        :
          null,
      body:  <Widget>[
        Expanded( 
          flex: 6, 
          child: Stack(
            children: [   
              Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.075), 
                  image:  new DecorationImage( 
                    image: AssetImage('assets/images/background/search_event_page_background.png')
                  ) 
                ),
                child: ListView(
                  controller: feedController,
                  padding: const EdgeInsets.only(
                    bottom: templateFooterHeigth
                  ),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Container(
                          width: double.infinity,
                          child: FeedFormText(
                            hasUpload: _hasUpload,
                            showPhotoForm: _showPhotoForm,
                            initialValue: widget.startFeed,
                            user: controller.currentUser,
                            afterPostSubmit: _afterPostFormPublish
                          ),
                        ),
                        (_fixedPostsList.isNotEmpty)
                        ?
                          Column(
                            key: new GlobalKey(),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _fixedPostsList
                          )
                        :
                          (_noFixedPosts == null)
                          ?
                            LoadingBlock(
                              text: "Carregando publicações fixadas"
                            )
                          :
                            SizedBox.shrink(),
                        Column(
                          key: new GlobalKey(),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: _postsList
                        ),
                        (_noMorePosts)
                        ?
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "Você chegou ao fim."
                            )
                          )
                        :
                          SizedBox.shrink()
                      ]
                    ) 
                  ] 
                )
              ),
            ]
          )
        )
      ],
      drawer: NavDrawer(),
      header: TemplateAppBar(
        title: "FEED",
        back: true,
        hideMenu: true,
        hideUser: true,
        event:  Modular.get<Controller>().currentEvent,
        user: Modular.get<Controller>().currentUser
      ) 
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}
class FeedFormText extends StatefulWidget{
  
  final String? initialValue;

  final User user;

  final Function afterPostSubmit;

  final Function showPhotoForm;

  final bool? hasUpload;

  final bool fixed;

  FeedFormText({Key? key, this.fixed = false, this.hasUpload = false, required this.showPhotoForm, this.initialValue, required this.user, required this.afterPostSubmit}) : super(key: key);

  @override
  FeedFormTextState createState() => FeedFormTextState();
}

class FeedFormTextState extends State<FeedFormText> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  /*
    Erro ao enviar ?
  */
  bool _failure = false; 

  /*
    Clicou na caixa de feed?
  */
  bool _tappedInFeedForm = false; 


  /*
    Qual foi o erro?
  */
  String? _failureMessage;

  /*
    Botão submit ativado?
  */
  bool _buttonSubmitActived = false;

  bool _fieldTapped = false;

  final TextEditingController _textController = TextEditingController(); 

   
  void fieldTapped(){  
    setState( () {
      _fieldTapped = true;
      _failure = false; 
    } );
  }

  void keyPressed(){

    String value = _textController.text;

    setState( () { 
      //Se for vazia ou se tiver apenas espaços
      if(value.trim().isNotEmpty ){
        _buttonSubmitActived = true; 
      } else { 
        _buttonSubmitActived = false;
      }
    } );
  }

  /*
    Quando clicamos no botão de enviar foto
  */
  void afterPostCamera(){  
    widget.showPhotoForm(); 
  }

  /*
    Quando damos um submit num post, o tes
  */
  void afterPostSubmit( ){

    String value = _textController.text;

    setState(() {
      _failure = false;  

      //Se for vazia ou se tiver apenas espaços
      if( value.trim().isEmpty ){
        _failure = true; 
        _failureMessage = "A mensagem não pode ser vazia.";
      } 

      //Se tiver mais de 500 caracteres
      if( value.length > 500 ){
        _failure = true; 
        _failureMessage = "A mensagem não pode ser tão grande.";
      } 

      if( !_failure ){

        _buttonSubmitActived = false;
        
        //Vamos limpar o formulário
        _textController.text = ""; 

        //Vamos passar para o callback
        widget.afterPostSubmit(value);
      } 
    }); 
  }
 
  @override 
  void initState() {
    super.initState();     
    this._textController.text = widget.initialValue ?? "";  
  } 

  @override
  void dispose() { 
    _textController.dispose(); 
    super.dispose();
  }

  void _changeFeedFormStatus() {
    if(!mounted) return;
    setState((){
      _tappedInFeedForm = _tappedInFeedForm ? false : true;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    
    Widget feedFormWidget = Container(
      margin: widget.fixed ? null : EdgeInsets.all(8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: borderMainRadius,
        border: Border.all(color: bgWhiteColor, width: 0.5),
        color:Colors.white
      ),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 40, 
        maxHeight: _tappedInFeedForm ? 150 : 52,  
      ), 
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /*
            Campos de publicação do post
          */
          Container( 
            width: double.infinity,
            height: _tappedInFeedForm ? 90 : 40, 
            decoration: BoxDecoration(  
              borderRadius: new BorderRadius.circular(0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row( 
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10), 
                  child: Avatar(
                    borderColor: Colors.transparent,
                    avatar: widget.user.avatar.isEmpty ? "assets/images/default_avatar.png" : widget.user.avatar,
                    local: widget.user.avatar.isEmpty ? true : false
                  ) 
                ),
                ( _tappedInFeedForm  )
                  ?
                    Expanded(
                      flex:8, 
                      child: Form(
                      key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            TextFormField(
                              autofocus: true,
                              controller: _textController,
                              onChanged: ( (v) => { keyPressed() } ),
                              onTap: ( () => { fieldTapped() }), 
                              onFieldSubmitted: ( (value) => afterPostSubmit() ),
                              style: TextStyle( fontSize: _fieldTapped ? 21 : 17 ),
                              decoration: new InputDecoration( 
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding:EdgeInsets.only( right: 15),
                                hintText: "${widget.user.firstName()}, no que está pensando ?",
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textInputAction: TextInputAction.go,
                            ),
                            _failure ?
                              Container( 
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                color: Colors.red,
                                child: Text( 
                                  _failureMessage! , 
                                  style: TextStyle( 
                                    color: Colors.white,
                                    fontSize: 15
                                  )
                                )
                              )
                              :
                              SizedBox.shrink(), 
                          ]
                        ),
                      )
                    )
                  :
                    Expanded( 
                      child: InkWell(
                      onTap: _changeFeedFormStatus,
                      child:  Container( 
                        width: double.infinity,
                        alignment: Alignment.centerLeft, 
                        child: Text(
                          "Que tal compartilhar algo?", 
                          style: TextStyle( 
                            fontSize: 15, 
                            color: Colors.grey
                          ),
                        )
                      )
                    )
                  )
              ]
            ), 
          ),
          ( _tappedInFeedForm  )
            ?
              /*
                Ações da publicação
              */ 
              Container(   
                margin: EdgeInsets.all(0),
                child: Row( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (widget.hasUpload == true) ? 
                      Container( 
                        width: 45, 
                        height: 45,
                        alignment: Alignment.center,
                        child: ButtonBadge(
                          icon: CupertinoIcons.camera,
                          callback: afterPostCamera, 
                          backColor: Colors.white,
                          iconColor: primaryColor,
                          textColor: primaryColor,
                          count: 1,
                          size: 25
                        )
                      )
                    : 
                      PrimaryButton(onlyBorder: true, height: 45, noBorder: true, width: 45, fontSize: 25, title: "", icon: CupertinoIcons.camera, onlyIcon: true, onClick: afterPostCamera, textColor: primaryColor,), 
                    ( _buttonSubmitActived ) ?
                      PrimaryButton(width: 120, icon: CupertinoIcons.arrow_right, iconRight: true, fontSize: 13, padding: noPadding, height: 35, onClick: afterPostSubmit, title: "Publicar" )
                    :
                      SizedBox.shrink()
                  ],
                )
              )
            :
              SizedBox.shrink()
        ],
      ),  
    );

    return Focus(
      descendantsAreFocusable: true,
      child: Stack( 
        children: [ 
          feedFormWidget, 
          (_tappedInFeedForm) ?
            Positioned(
              top: 7, 
              right: 7, 
              child: ButtonChiclete(
                onClick: _changeFeedFormStatus,
                size: 18,
                iconColor: Colors.grey,
                icon: FontAwesomeIcons.xmark
              ),
            )
          :
            SizedBox.shrink()
        ]
      )
    );
    
  } 

}