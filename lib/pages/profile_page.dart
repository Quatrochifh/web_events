import 'dart:convert';
import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/components/widget_submit_photo_avatar.dart';
import 'package:appweb3603/utils/Permissions.dart';
import 'package:appweb3603/bloc/Account.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/forms/profile_form.dart';
import 'package:appweb3603/components/forms/profile_medias_form.dart';
import 'package:appweb3603/components/forms/profile_privacity_form.dart';
import 'package:appweb3603/components/menu/widget_horizontal_menu.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_profile_action_container.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:appweb3603/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';  
import 'package:flutter_modular/flutter_modular.dart';
import 'package:appweb3603/bloc/Account.dart' as profile_bloc;
import 'dart:core';

import 'package:permission_handler/permission_handler.dart';
 
class ProfilePage extends StatefulWidget{ 

  final String? startFeed;

  ProfilePage({Key? key, this.startFeed}) : super(key: key);

  @override
  ProfilePageState createState() => new ProfilePageState();
} 

class ProfilePageState extends State<ProfilePage> with PageComponent, AutomaticKeepAliveClientMixin{ 

  @override
  bool get wantKeepAlive => true;

  // Bloc para assuntos relacionados ao perfil do usuário
  Account accountBloc = (globalDIContainer.get(Account) as Account);

  Controller controller = Modular.get<Controller>();
  Account  _accountBloc = Modular.get<profile_bloc.Account>();
  Validate validate     = Modular.get<Validate>();
  
  final GlobalKey<AvatarState> _keyAvatar = GlobalKey();
  final GlobalKey<ProfileFormState> _profileFormKey = GlobalKey();
  final GlobalKey<ProfileMediasFormState> _profileMediasFormKey = GlobalKey();
  final GlobalKey<ProfilePrivacityFormState> _profilePrivacityFormKey = GlobalKey();

  Map<String, dynamic>? _userProfile;
 
  dynamic __userProfileBase64;

  String? _currentForm = "basic";

  @override 
  void initState(){
    super.initState();

    if(!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadProfileData();
    });
  } 

  /*
   * Pega-se os dados do usuário atual, necessário para preencher o formulário e
   * carregará o avatar.
  */
  void _loadProfileData()
  {
    setState((){
      _userProfile = accountBloc.convertCurrentUserToJson();
    });
    Future.delayed(Duration(milliseconds: 200), (){
      _loadForm();
    });
  }

  /*
   * Preencherá o formulário e
   * carregará o avatar.
  */
  Future _loadForm() async
  {
    if (_profileFormKey.currentState != null) {
      // Adicionar os valores iniciais no formulário
      _profileFormKey.currentState!.updateInitialValue(_userProfile);
      // Atualizar o avatar
      // _keyAvatar.currentState!.updateAvatar(_userProfile!['avatar']);
      debugPrint(">>> Atualizando dados do form principal.");
    }
    if (_profilePrivacityFormKey.currentState != null) {
      debugPrint(">>> Atualizando dados do form de privacidade.");
      _profilePrivacityFormKey.currentState!.updateInitialValue(_userProfile);
    }
    if (_profileMediasFormKey.currentState != null) {
      debugPrint("Atualizando dados do form de redes sociais.");
      _profileMediasFormKey.currentState!.updateInitialValue(_userProfile);
    }
  }

  // Se uma foto for selecionada
  void _afterPhotoSelected(photoBase64){   
    hideFloatScreen();
    if(photoBase64 == null) {
      setState((){ 
        __userProfileBase64 = photoBase64;
        _keyAvatar.currentState!.updateAvatar(_userProfile!['avatar']);
      });
    }else{
      debugPrint("Foto selecionada.");
      setState((){ 
        __userProfileBase64 = photoBase64; 
        __userProfileBase64 = photoBase64;
        _keyAvatar.currentState!.updateAvatar(Base64Decoder().convert(photoBase64));
      });
    } 
  } 

  // Se a seleção de imagem for cancelada
  void _afterPhotoCanceled(){
    hideFloatScreen();
  }
  
  // Submeter formulário para atualizar dados do perfil do usuário
  Future<dynamic> _formBasicSubmit(User user, String route) {
    //Loading
    showLoading();

    user.avatar = __userProfileBase64 ?? "";
    return _accountBloc.updateAccount(user, route: route).then((results){
      if (__userProfileBase64 != null && __userProfileBase64.isNotEmpty) {
        setState((){
          _userProfile!['avatar'] = __userProfileBase64;
        });
      }

      //Esconder Loading
      hideLoading();

      if( results == true ){
        //Sucesso
        registerNotification(message: "Dados do perfil atualizado com sucesso!", type: "success");
        return true; 
      }else{
        //Erro
        registerNotification(message: results.toString(), type: "warning");
        return results.toString();
      }  
    });
  }

  /*
   * Inserção de imagem
  */
  void _showPhotoForm(){
    FocusScope.of(context).requestFocus(new FocusNode());
    Permissions.checkGalleryPermission().then((permission){
      if (permission != true) {
        Permissions.requestGalleryPermission().then((results){
          if (results != PermissionStatus.granted) {
            showNotification(
              message: "Acesse as configurações e permita o acesso total à Galeria e Câmera."
            );
            return;
          }
        });
      } else {
        showFloatScreen(
          title: "Foto de Perfil",
          child: SubmitPhotoAvatar(
            photoBase64: __userProfileBase64,
            okCallback: _afterPhotoSelected,
            cancelCallback: _afterPhotoCanceled
          )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {    
    super.build(context);

    return content(
      color: bgWhiteColor,
      body:  <Widget>[
        HorizontalMenu(
          items: {
            "Infor. Básicas" : () {
              if (!mounted) return;
              setState(() {
                _currentForm = "basic";
              });
              _loadProfileData();
            },
            "Redes Sociais" : () {
              if (!mounted) return;
              setState(() {
                _currentForm = "medias";
              });
              _loadProfileData();
            },
            "Privacidade" : () {
              if (!mounted) return;
              setState(() {
                _currentForm = "privacity";
              });
              _loadProfileData();
            },
          }
        ),
        (_currentForm == "basic")
          ?
          Expanded(
            child: Container(
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                (_userProfile == null)
                  ?
                    Container(
                      width: double.infinity,
                      child: LoadingBlock()
                    )
                  :
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      alignment: Alignment.center,
                      child: ProfileActionContainer(
                        onTap: _showPhotoForm,
                        distanceBottom: const [0, 0],
                        icon: CupertinoIcons.camera,
                        buttonSize: const [50, 50],
                        child: Avatar(
                          key: _keyAvatar,
                          borderColor: Colors.black.withOpacity(0.1),
                          borderWidth: 3,
                          width: 230,
                          height: 230,
                          avatar: _userProfile!['avatar'] ?? ""
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                        bottom: templateFooterHeigth * 2 + MediaQuery.of(context).padding.bottom
                      ),
                      child: 
                      (_userProfile == null)
                        ?
                          Container(
                            width: double.infinity,
                            height: 90,
                            child: LoadingBlock()
                          )
                        :
                          ProfileForm(
                            key: _profileFormKey,
                            feedback: _formBasicSubmit, 
                            cancelOnclick: (){ }, 
                            initialValue: _userProfile,
                          ),
                    ),
                ]
              )
            )
          )
        :
          SizedBox.shrink(),
        (_currentForm == "medias")
          ?
            Expanded(
            child: Container(
              width: double.infinity,
                child: ListView(
                  padding: noPadding,
                  children: [
                    ProfileMediasForm(
                      key: _profileMediasFormKey,
                      feedback: _formBasicSubmit, 
                      cancelOnclick: (){ }, 
                      initialValue: _userProfile,
                    )
                  ]
                )
              )
            )
          :
            SizedBox.shrink(),
        (_currentForm == "privacity")
          ?
            ProfilePrivacityForm(
              display: true,
              key: _profilePrivacityFormKey,
              feedback: _formBasicSubmit, 
              cancelOnclick: (){ }, 
              initialValue: _userProfile,
            )
          :
            SizedBox.shrink()
      ],  
      drawer: NavDrawer(),
      header: TemplateAppBar(event: controller.currentEvent, back: true, hideMenu: true, hideUser: true, title: "Seu perfil", user: controller.currentUser ),
    ); 
  } 
}  