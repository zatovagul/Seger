import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/Templates/mat_list.dart';
import 'package:seger/Screens/Templates/mat_set.dart';
import 'package:seger/Screens/Templates/oxide_role_set.dart';
import 'package:seger/Screens/Templates/folder_lists.dart';
import 'package:seger/Screens/calc_screen.dart';
import 'package:seger/Screens/menu_screen.dart';

import 'package:seger/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2),
        (){
          Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.fade,child:CalculatorScreen(edit: false,),
              duration: Duration(milliseconds: 250)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
                child:SvgPicture.asset("assets/images/seger_icon.svg", width: 100.0),
            ),
          ),
          Container(
            height: 150,
            child: Center(
              child: SvgPicture.asset("assets/images/byovo_white.svg", width: 180.0),
            ),
          )
        ],
      ),
      backgroundColor: SegerItems.blue,
    );
  }
}

