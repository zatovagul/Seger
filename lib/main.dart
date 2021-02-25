import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/splash_screen.dart';

abstract class SegerItems{
  static const blue = Color(0xFF007AFF);

  static const mainTextStyle=TextStyle(color: blue,fontSize: 17.0);

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

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Orders();
  }
}

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DataBase"),
      ),
      body: SingleChildScrollView(child: NewOrder()),
    );
  }
}

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final matDao= Provider.of<MatDao>(context);
    final matOxideDao=Provider.of<MatOxideDao>(context);
    final oxideDao= Provider.of<OxideDao>(context);
    return Column(
      children: [
        Container(
          height: 700,
          width: double.infinity,
          child: StreamBuilder(
            stream:  matDao.watchMaterials(),
            builder: (context, AsyncSnapshot<List<Mat>> snapshot){
              return ListView.builder(
                itemCount: snapshot.data!=null ? snapshot.data.length : 0,
                itemBuilder: (_,index){
                  Mat mat=snapshot.data[index];
                  return Container(
                    child: Column(
                      children: [
                        Text("${mat.name}  ${mat.id}  ${mat.def}"),
                        Container(
                          height: 700,
                          width: double.infinity,
                          child: StreamBuilder(
                            stream: matOxideDao.watchMatOxidesByMatId(mat.id),
                            builder: (context, AsyncSnapshot<List<MatOxide>> snapshot1){
                                return ListView.builder(
                                    itemCount: snapshot1.data!=null ?  snapshot1.data.length : 0,
                                  itemBuilder: (_,index)
                                  {
                                    MatOxide matO=snapshot1.data[index];
                                    return Container(
                                      height:50,
                                      width: double.infinity,
                                      child: StreamBuilder(
                                        stream: oxideDao.watchOxideById(matO.oxideId),
                                        builder: (context,AsyncSnapshot<Oxide> snapshot2){
                                          if(snapshot2.data==null) return Center();
                                          else
                                          return Center(
                                            child: Container(
                                              child: Text("OxideId-${snapshot2.data.id}  ${snapshot2.data.name}  ${snapshot2.data.mass}  ${snapshot2.data.role}"),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}




class MyApp extends StatelessWidget {
  // This widgset is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: "FIRST PAGE");
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SecondScreen()));
          },
          child: Text("FORWARD"),
        ),
      ),
    );
  }
}
