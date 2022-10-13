import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/components/widget_social_medias.dart';
import 'package:appweb3603/entities/Expositor.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpositorPreview extends StatefulWidget {

  final Expositor expositor;

  final bool? fullDisplay;

  final Function? onTap;

  ExpositorPreview({Key? key, this.onTap, this.fullDisplay, required this.expositor}) : super(key: key);

  @override
  ExpositorPreviewState createState() => ExpositorPreviewState();
}


class ExpositorPreviewState extends State<ExpositorPreview> {
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: new GlobalKey(),
      onTap: (){
        if (widget.onTap != null) {
          widget.onTap!(
            child: ExpositorPreview(
              expositor: widget.expositor, 
              fullDisplay: true
            )
          );
        }
      },
      child: Container(
          clipBehavior: Clip.antiAlias,
          width: widget.fullDisplay == true ? double.infinity : 250,
          height:  widget.fullDisplay == true ? MediaQuery.of(context).size.height : 250,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderMainRadius,
            boxShadow:  widget.fullDisplay != true ? const [ligthShadow] : null
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                width: double.infinity,
                height: 110,
                child: CustomImage(
                  width: double.infinity,
                  height: 110,
                  fit: BoxFit.contain,
                  image: widget.expositor.image
                ),
              ),
              Positioned(
                top: 120,
                left: 0,
                child: Container(
                  width: widget.fullDisplay == true ? (MediaQuery.of(context).size.width - 20) : 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.expositor.title,
                        maxLines: 1,
                        style: TextStyle(
                          wordSpacing: -3.5,
                          overflow: TextOverflow.ellipsis,
                          fontSize:  widget.fullDisplay == true ? 24 : 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SocialMedias(
                        fontSize: 17,
                        dimension: 35,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        items: widget.expositor.medias
                      ),
                      (widget.fullDisplay == true) 
                        ?
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: 50
                            ),
                            child: 
                              Text(
                                widget.expositor.description,
                                maxLines: 5,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w100
                                ),
                              )
                          )
                        :
                          SizedBox.shrink(),

                      (widget.fullDisplay == true) 
                        ?
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 50),
                            child: Column(
                              children:[
                                Details(
                                  titleColor: Colors.black,
                                  titleSize: 14,
                                  inline: true,
                                  items: {
                                    "Telefone" : widget.expositor.telephone.isEmpty ? globalMessages['NO_DISPONIBLE'] : widget.expositor.telephone,
                                    "E-mail" : widget.expositor.email.isEmpty ? globalMessages['NO_DISPONIBLE'] : widget.expositor.email,
                                  }
                                ),
                                Details(
                                  titleColor: Colors.black,
                                  titleSize: 14,
                                  items: {
                                    "Endereço" : widget.expositor.address.isEmpty ? globalMessages['NO_DISPONIBLE'] : widget.expositor.address
                                  }
                                )
                              ]
                            )
                          )
                        :
                          SizedBox.shrink(),
                      (widget.fullDisplay == true)
                        ?
                          PrimaryButton(
                            onClick: (){
                              try {
                                launch(widget.expositor.url);
                              } catch(e) {
                                debugPrint(e.toString());
                              }
                            },
                            marginTop: 80,
                            backgroundColor: primaryColorLigther,
                            textColor: primaryColor,
                            height: 50,
                            title: "Acessar Site",
                            icon: CupertinoIcons.link,
                          )
                        :
                          SizedBox.shrink()
                    ],
                  )
                )
              )
            ],
          )
        )
    );
  }

}