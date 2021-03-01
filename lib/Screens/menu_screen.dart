import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:seger/Screens/Templates/folder_lists.dart';
import 'package:seger/Screens/Templates/mat_list.dart';
import 'package:seger/Screens/Templates/oxide_role_set.dart';
import 'package:seger/Screens/calc_screen.dart';
import 'package:seger/main.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        decoration:  SegerItems.pageDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  SvgPicture.asset("assets/images/seger_blue_icon.svg",
                      width: 100.0),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TextButton(
                        child: Text("by\nOVO TRIMMING TOOLS",
                            style: SegerItems.mainStyle(14),
                            textAlign: TextAlign.center),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Builder(
                      builder: (context){
                        List<Widget> widgets=[];
                        for(int i=0;i<names.length;i++){
                          Widget page=CalculatorScreen();
                          if(i==1) page=FolderList();
                          else if(i==2) page=MatList(choose:false);
                          else if(i==3) page=OxideRoleSettings();
                          widgets.add(
                            Container(
                              margin: EdgeInsets.only(top: 15.0),
                              child:
                              TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: page,
                                          duration: Duration(milliseconds: 500)));
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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "SEGER F.A.Q.",
                  style: SegerItems.mainTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: SegerItems.blue,
    );
  }
}
