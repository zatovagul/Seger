import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seger/main.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0, bottom: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
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
                      child: Text("by\nOVO TRIMMING TOOLS",
                          style: SegerItems.mainStyle(14),
                          textAlign: TextAlign.center)),
                  Container(
                    margin: EdgeInsets.only(top: 60.0),
                    child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            child:
                            Text("Calculator", style: SegerItems.mainTextStyle),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            child:
                            Text("Recipes", style: SegerItems.mainTextStyle),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            child:
                            Text("Materials", style: SegerItems.mainTextStyle),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            child:
                            Text("Oxide Role", style: SegerItems.mainTextStyle),
                          ),
                        ]),
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
