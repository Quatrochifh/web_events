import 'package:appweb3603/entities/User.dart';
import 'package:flutter/material.dart'; 

class PostCommentForm extends StatefulWidget{ 

  //Objeto do usuário
  final User user;

  final Function afterCommentSubmit;

  PostCommentForm({Key? key , required this.user , required this.afterCommentSubmit}) : super(key: key);

  @override
  PostCommentFormState createState() => PostCommentFormState();

}

class PostCommentFormState extends State<PostCommentForm>{

   
  final GlobalKey<FormState> _formKey                 = GlobalKey<FormState>();
  
  /*
    Campo pressionado ?
  */
  bool _fieldTapped = false;
  /*
    Erro ao enviar ?
  */
  bool _failure = false;
  /*
    Qual foi o erro?
  */
  String? _failureMessage;

  final TextEditingController _textController = new TextEditingController();


  void fieldTapped(){
    setState( ()=> {
      _fieldTapped = true
    });
  }

  @override
  Widget build(BuildContext context){   

    /* 
      Aqui validamos o campo de envio de uma mensagem. 
      Se ocorrer algum erro, vamos deixar com uma borda avermelhada.
      String formFieldValue
    */
    void validateForm( String formFieldValue ){ 

      setState(() {
        _failure = false; 

        //Se for vazia ou se tiver apenas espaços
        if( formFieldValue.trim().isEmpty ){
          _failure = true; 
          _failureMessage = "A mensagem não pode ser vazia.";
        } 

        //Se tiver mais de 500 caracteres
        if( formFieldValue.length > 500 ){
          _failure = true; 
          _failureMessage = "A mensagem não pode ser tão grande.";
        } 

        if( !_failure ){
          //Vamos limpar o formulário
          _textController.text = "";

          //Vamos passar para o callback
          widget.afterCommentSubmit(formFieldValue);
        } 
      });
       
    }

    /*
      Mensagem de erro.
    */
    Widget errorMessage(){
      return Container( 
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(10),
        child: Text( 
          _failureMessage!, 
          style: TextStyle( 
            color: Colors.red, 
            fontSize: 16 
          ) , 
          overflow: TextOverflow.ellipsis
        )
      );
    }
    
    return 
    Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 30
      ),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 0.3,
            color: Colors.black.withOpacity(0.2)
          )
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              _failure ? errorMessage() : SizedBox.shrink(),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: 30
                ),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(1),
                ),
                clipBehavior: Clip.antiAlias,
                child: Form(
                    key: _formKey,
                    child: Column( 
                      children: [ 
                        TextFormField(
                          controller : _textController,
                          onTap: fieldTapped, 
                          onFieldSubmitted: ((value) => { 
                            //Vamos validar o formulário
                            validateForm(value)
                          }),
                          style: TextStyle(
                            fontSize: _fieldTapped ? 18 : 13,
                            color: Colors.black
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textInputAction: TextInputAction.go,
                          decoration: new InputDecoration( 
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none, 
                            contentPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 11,
                              top: 11,
                              right: 15
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey
                            ),
                            hintText: "${widget.user.firstName()}, escreva um comentário ...",
                          ), 
                        )
                      ]
                    ),
                  )
              )
            ]
          )
        ],
      )
    );
  }

}