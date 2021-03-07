import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:seger/Screens/Templates/folder_lists.dart';
import 'package:seger/Screens/Templates/mat_list.dart';
import 'package:seger/Screens/Templates/oxide_role_set.dart';
import 'package:seger/Screens/calc_screen.dart';
import 'package:seger/main.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  List<String> names=["Calculator", "Recipes", "Materials", "Oxide Role"];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0, bottom: 20.0),
        decoration:  SegerItems.pageDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 18, right: 18 ),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(onTap:(){
                      Navigator.pop(context);
                    },child: Container(padding:EdgeInsets.all(2),child: SvgPicture.asset("assets/images/cross.svg", width: 18,))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: SvgPicture.asset("assets/images/seger_blue_icon.svg",
                        width: 85),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 13.0),
                      child: SvgPicture.asset("assets/images/byovo_blue.svg",
                          width: 185,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Builder(
                      builder: (context){
                        List<Widget> widgets=[];
                        for(int i=0;i<names.length;i++){
                          Widget page=CalculatorScreen(edit: false,);
                          if(i==1) page=FolderList(choose: false,);
                          else if(i==2) page=MatList(choose:false);
                          else if(i==3) page=OxideRoleSettings();
                          widgets.add(
                            Container(
                              margin: EdgeInsets.only(top: 15.0),
                              child:
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context).pushAndRemoveUntil(PageTransition(child: page, type: PageTransitionType.fade, duration: Duration(milliseconds: 250)), (route) => false);
                                },
                                  child: Text(names[i], style: SegerItems.mainTextStyle)),
                            ),
                          );
                        }
                        return Column(
                          children: widgets,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 45),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      _launchUrl("https://www.instagram.com/ovo_ceramics/");
                    },
                    child: Container(
                      child: SvgPicture.asset("assets/images/instagram.svg",width: 30,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _launchUrl("https://ceramicschool.ru/ovoshop");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Ovo Tools Website",
                        style: SegerItems.mainTextStyle,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                        _launchUrl("https://ceramicschool.ru/seger");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "SEGER F.A.Q.",
                        style: SegerItems.mainTextStyle,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: SegerItems.blue,
    );
  }

  void _launchUrl(String url) async{
      await(canLaunch(url)) ? await launch(url) : throw 'Could not launch $url';
  }
}
