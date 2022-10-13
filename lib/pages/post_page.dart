import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Post.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/post/widget_post_action.dart';
import 'package:appweb3603/components/post/widget_post_comment.dart'; 
import 'package:appweb3603/components/post/widget_post_comment_form.dart';
import 'package:appweb3603/components/post/widget_post_comments.dart';
import 'package:appweb3603/components/post/widget_post_content.dart';
import 'package:appweb3603/components/post/widget_post_header.dart';
import 'package:appweb3603/components/post/widget_post_link.dart';
import 'package:appweb3603/components/post/widget_post_reactions.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Post.dart' as post_entity;
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/mobx/feed.dart' as feed_mobx; 
import 'package:appweb3603/bloc/Feed.dart' as feed_bloc;
import 'package:appweb3603/bloc/Post.dart' as post_bloc;
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostPage extends StatefulWidget{  
   
  post_entity.Post post;

  PostPage({Key? key, required this.post}) : super(key: key);

  @override
  PostPageState createState() => new PostPageState();
}


class PostPageState extends State<PostPage> with PageComponent, AutomaticKeepAliveClientMixin{ 

  @override
  bool get wantKeepAlive => true;

  Controller controller = Modular.get<Controller>();

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.post.content.isEmpty) {
        showLoading();
        (globalDIContainer.get(post_bloc.Post) as Post).fetchPostById(widget.post.id).then((post){
          if (post.runtimeType.toString() == "Post") {
            setState((){
              widget.post = post;
            });
          }
          hideLoading();
        });
      }
    });
  }

  @override
  

  @override
  Widget build(BuildContext context){
    super.build(context);

    return content(
      resizeToAvoidBottomInset: true,
      color: mainBackgroundColor,
      body:  <Widget>[
        (widget.post.content.isEmpty) 
          ?
            LoadingBlock()
          :
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  Expanded(
                    flex: 6, 
                    child: PostPageContent(
                      currentUser: globalDIContainer.get(User) as User,
                      post: widget.post
                    )
                  )
                ]
              ) 
            )
      ],
      drawer: NavDrawer(),
      header: TemplateAppBar(
        event: controller.currentEvent,
        back: true,
        hideMenu: true,
        hideUser: true,
        title: "POST DE ${widget.post.user.firstName()}",
        user: controller.currentUser
     ),
   );  
             
  }
}


class PostPageContent extends StatefulWidget{

  final post_entity.Post post; 

  final User currentUser;

  PostPageContent({Key? key, required this.currentUser, required this.post}) : super(key: key);

  @override
  PostPageContentState createState() => new PostPageContentState();
}


class PostPageContentState extends State<PostPageContent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _noMoreReplies           = false;

  int _currentPage              = 1;

  String _postInfos             = '';

  List<PostComment>? _replies;

  String? _reactionsNamesS;

  feed_mobx.Feed feedMobx       = Modular.get<feed_mobx.Feed>();

  feed_bloc.Feed feedBloc       = Modular.get<feed_bloc.Feed>();
  
  Controller controller         = Modular.get<Controller>();
 
  @override 
  void initState(){ 
    super.initState();

    this._fetchReplies();
    this._reactionsNames();
  }


  /*
   *  Vamos pegar os nomes das 3 pessoas quem curtiram a publicação
  */
  void _reactionsNames() {
    (globalDIContainer.get(Post) as Post).fetchReactionsByPostId(widget.post.id).then((results){
      int currentReaction = 0;
      results.forEach((value){
        if (_reactionsNamesS != null) {
          if ((results.length == 2 && widget.post.likes == 3)|| (currentReaction == 1 && results.length == 2)) {
           _reactionsNamesS = "${_reactionsNamesS!} e ";
          } else {
            _reactionsNamesS = "${_reactionsNamesS!}, ";
          }
        } else {
          _reactionsNamesS ??=  "";
        }
        _reactionsNamesS = _reactionsNamesS! + value;
        currentReaction+= 1;
      });
      if (widget.post.likes > results.length && _reactionsNamesS != null) {
        _reactionsNamesS = "${_reactionsNamesS!} e outros ${(widget.post.likes - results.length).toString()}";
      } else {
        _reactionsNamesS = _reactionsNamesS ?? "";
      }

      if (!mounted) return;
      setState((){
        _reactionsNamesS = _reactionsNamesS;
      });
    });
  }

  /*
    Callback para quando o botao de like for clicado.
  */
  void likeButtonCallback() {
    this.feedBloc.likePost(widget.post.id).then((results){
      if (!mounted) return;
      if(results == true || results == false){
        setState((){ 
          widget.post.reacted = results;
        });
      } 
    });
  }

  /*
    Buscar comentários / replies para o POST
  */
  void _fetchReplies({bool inLast = false}){

    feedBloc.fetchReplies(_currentPage, widget.post.id).then((replies) {
      _replies ??= [];
      if(replies != null){ 
        setState((){ 
          if(!inLast){
            _replies = replies + _replies;
          }else{
            _replies = _replies! + replies;
          }
          _currentPage = _currentPage + 1;
        });
      }else{
        setState((){
          _noMoreReplies = true;
        }); 
      }
    }); 
  } 

  /*
   * Publicar um comentário
  */
  void submitComment(String content) {
    showLoading();
    feedBloc.publishReply(content, widget.post.id).then((reply) {
      hideLoading();
      if(reply != null){ 
        setState((){
          widget.post.replies = widget.post.replies + 1;
          _replies!.insert(0, reply);
        });
      } 
    });
  }  


  /*
    Chamado pelo botão de "Carregar posts"
  */
  void _loadMoreReplies() async {   
    /*
      Vamos inserir a caixa de loading e atualizar o State.
      * Como o botao esta dentro do StreamBuilder, é necessário colocar de forma Async.
    */  
    _fetchReplies(inLast : true);
  }

  @override
  Widget build(BuildContext context){  
    super.build(context);

    double repliesRatio  = (_replies == null || _replies!.isEmpty) ? 1 : (_replies!.length) / (10 * (_currentPage-1));

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [  
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 5,
                    right: 5
                  ),
                  decoration: BoxDecoration(
                    borderRadius: borderMainRadius,
                    color: Colors.white,
                    boxShadow: const [ligthShadow],
                    border: Border.all(
                      width: 0.3,
                      color: Colors.black.withOpacity(0.2)
                    )
                  ), 
                  child: Column(
                    children: [
                      PostHeader(user: widget.post.user, post: widget.post),
                      //Conteudo do post
                      PostContent(post: widget.post),
                      (_postInfos.isNotEmpty) 
                        ? 
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              _postInfos, 
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, .7)
                              )
                            )
                          )
                        :
                        SizedBox.shrink(),
                        (_reactionsNamesS != null && _reactionsNamesS!.isNotEmpty)
                          ?
                            PostReactions(
                              reactionsString: "${_reactionsNamesS!} ${widget.post.likes > 1 ? "curtiram" : "curtiu"}"
                            )
                          :
                            SizedBox.shrink(),

                      (widget.post.hasLink)
                        ?
                          PostLink(
                            post: widget.post
                          )
                        :
                          SizedBox.shrink(),
                        //Acoes do post
                        PostAction(
                          likeButtonCallback : likeButtonCallback,
                          viewPostCallback : (postId){ }, 
                          post: widget.post
                        ),
                        PostCommentForm(
                          user: controller.currentUser,
                          afterCommentSubmit: submitComment
                        ),
                    ]
                  )
                ),
                PostComments(
                  user: feedMobx.oCurrentUser.value,
                  comments: _replies
                ),
                (!_noMoreReplies && _replies != null && _replies!.isNotEmpty && repliesRatio >= 1) 
                  ?
                    PrimaryButton(
                      marginBottom: 50,
                      marginTop: 20,
                      marginRight: 7.5,
                      marginLeft: 7.5,
                      backgroundColor: primaryColor,
                      textColor: Colors.white,
                      onClick: _loadMoreReplies,
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
          ),
        ],
      )
    ); 
  }
}