import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/splash_screen.dart';

abstract class SegerItems{
  static const blue = Color(0xFF007AFF);
  static const blueGrey = Color(0xFF9ABCFF);
  static const greyi = Color(0xFFF6F6F6);

  static const mainTextStyle=TextStyle(color: blue,fontSize: 17.0);
  static const menuIcon=Icon(
    Icons.menu_outlined,
    size: 35.0,
    color: Colors.white,
  );
  static SvgPicture segerTopPic=SvgPicture.asset("assets/images/seger_icon.svg", width: 70.0);

  static const textFieldDecoration=InputDecoration(
  hintText: "Enter name",
  border:UnderlineInputBorder(
  borderSide: BorderSide(color: SegerItems.blue)
  ) ,
  enabledBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: SegerItems.blue)
  ),
  focusedBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: SegerItems.blue)
  ),
  );
  static const whiteTextFieldDecoration=InputDecoration(
    hintText: "Enter name",
    hintStyle: TextStyle(color: blueGrey),
    border:UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ) ,
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ),
  );
  static final FilteringTextInputFormatter doubleFilter =
  FilteringTextInputFormatter.allow(RegExp(r'^\d+[\,\.]?\d*'));

  static TextStyle mainStyle(double x){
    return TextStyle(color: blue,fontSize: x);
  }
  static TextStyle whiteStyle(double x){
    return TextStyle(color: Colors.white,fontSize: x);
  }

  static BoxDecoration pageDecoration=BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    color: Colors.white,
  );
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final db=AppDatabase();
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => db.oxideDao),
      Provider(create: (_) => db.matDao),
      Provider(create: (_) => db.matOxideDao),
      Provider(create: (_) => db.recipeDao),
      Provider(create: (_) => db.recipeMatDao),
      Provider(create: (_) => db.folderDao),
    ],
    child: MaterialApp(
      home: SplashScreen(),
    ),
  ));
}

