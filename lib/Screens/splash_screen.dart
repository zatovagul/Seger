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
          Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.fade,child:CalculatorScreen(), duration: Duration(milliseconds: 500)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:SvgPicture.asset("assets/images/seger_icon.svg", width: 100.0),
      ),
      backgroundColor: SegerItems.blue,
    );
  }
}

