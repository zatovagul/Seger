import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/splash_screen.dart';

abstract class SegerItems{
  static const blue = Color(0xFF007AFF);
  static const blueGrey = Color(0xFF9ABCFF);
  static const greyi = Color(0xFFF6F6F6);

  static SvgPicture menuIcon=SvgPicture.asset("assets/images/menu.svg",width: 24,);
  static SvgPicture segerTopPic=SvgPicture.asset("assets/images/seger_icon.svg", width: 50.0);

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
    contentPadding: EdgeInsets.only(bottom: 5),isDense: true,
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
    FilteringTextInputFormatter.allow(RegExp(r'^\d+[\,\.]?\d{0,4}'));
  static final FilteringTextInputFormatter nameFilter=
    FilteringTextInputFormatter.allow(RegExp(r'^.{0,50}'));
  static final dateFormat=DateFormat("dd.MM.yyyy");

  static TextStyle mainStyle(double x){
    return TextStyle(color: blue,fontSize: x, fontFamily: 'PTSans');
  }
  static TextStyle whiteStyle(double x){
    return TextStyle(color: Colors.white,fontSize: x, fontFamily: "PTSans",);
  }

  static BoxDecoration pageDecoration=BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    color: Colors.white,
  );

  static Map<double, double> letSizes={
    5:0.0121,
    8:0.0195,
    10:0.0243,
    12:0.0292,
    14:0.0340,
    16:0.0389,
    17:0.0413,
    18:0.0437,
    20:0.0486,
    22:0.0535,
    24:0.0584,
    40:0.0973,
  };
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
      color: SegerItems.blue,
      home: SplashScreen(),
    ),
  ));
}

class OxideText extends StatelessWidget {
  final String text;
  final TextStyle style;
  OxideText({this.text,this.style});
  @override
  Widget build(BuildContext context) {
    List<String> lets=text.split('');
    List<InlineSpan> letters=[];
    lets.forEach((e) {
      if(isNumeric(e)){
        letters.add(WidgetSpan(
          child: Transform.translate(offset: const Offset(0,2), child: Text(e, textScaleFactor: 0.7,style: style,),)
        ));
      }
      else{
        letters.add(TextSpan(text: e, style: style));
      }
    });
    return RichText(
        text: TextSpan(children: letters));
  }
}
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}


