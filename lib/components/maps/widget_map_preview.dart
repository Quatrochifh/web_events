import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_details.dart';
import 'package:appweb3603/entities/RoomMap.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPreview extends StatelessWidget {

  final RoomMap map;

  const MapPreview({Key? key, required this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [ligthShadow],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: grey165Color, width: 0.2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              "Mapa: ${map.title}",
              style: TextStyle(
                fontSize: 15.6,
                color: Colors.grey
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: (){
                Function showFloatScreen = globalDIContainer.get("showFloatScreen") as Function;
                showFloatScreen(
                  title: map.title,  
                  child: Column(
                    children:[
                      Container(
                        width: double.infinity,
                        height: 500,
                        child: CustomImage(image: map.mapImage),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (map.url.isNotEmpty)
                              ?
                                PrimaryButton(
                                  onClick: (){
                                    try {
                                      launch (map.mapImage);
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                  },
                                  title: "Saiba Mais",
                                  fontSize: 14.7,
                                  iconSize: 25,
                                  marginRight: 20,
                                  icon: CupertinoIcons.link,
                                  fontWeight: FontWeight.normal,
                                  width: 130,
                                  height: 45,
                                  borderRadius: 20,
                                  backgroundColor: Colors.transparent,
                                  textColor: primaryColor,
                                )
                              :
                                SizedBox.shrink(),
                              PrimaryButton(
                                onClick: (){
                                  try {
                                    launch (map.mapImage);
                                  } catch (e) {
                                    debugPrint(e.toString());
                                  }
                                },
                                title: "Baixar Mapa",
                                fontSize: 14.7,
                                iconSize: 25,
                                icon: CupertinoIcons.cloud_download,
                                fontWeight: FontWeight.normal,
                                width: 170,
                                height: 45,
                                borderRadius: 20,
                                backgroundColor: primaryColorLigther,
                                textColor: primaryColor,
                              )
                          ],
                        ),
                      ),
                      Details(
                        key: new GlobalKey(),
                        margin: EdgeInsets.only(top: 40),
                        titleColor: Colors.black,
                        descriptionColor: Colors.grey,
                        titleSize: 15.3,
                        descriptionSize: 16.7,
                        items: {
                          "Informações Úteis" : 
                            Text(
                              map.description,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.7
                              ),
                            ),
                        }
                      )
                    ]
                  )
                );
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: CustomImage(image: map.mapImage),
              )
            )
          ),
        ],
      )
    );
  }
}