import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/splash_screen.dart';

abstract class SegerItems{
  static const blue = Color(0xFF007AFF);

  static const mainTextStyle=TextStyle(color: blue,fontSize: 17.0);

  static TextStyle mainStyle(double x){
    return TextStyle(color: blue,fontSize: x);
  }
}


void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
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
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: 'Order name'),
          keyboardType: TextInputType.text,
          controller: nameController,
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Order price'),
          keyboardType: TextInputType.text,
          controller: priceController,
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              AppDatabase().insertNewOrder(Order(
                  price: priceController.text,
                  productName: nameController.text));
              priceController.clear();
              nameController.clear();
            });
          },
          color: Colors.green,
          child: Text("Place Order"),
        ),
        Container(
          height: 700,
          width: double.infinity,
          child: StreamBuilder(
            stream: AppDatabase().watchAllOrder(),
            builder: (context, AsyncSnapshot<List<Order>> snapshot){
              return ListView.builder(
                itemCount: snapshot.data!=null ? snapshot.data.length : 0,
                itemBuilder: (_,index){
                  return Card(
                    color: Colors.orangeAccent,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index+1}'),
                        radius: 20,
                      ),
                      title: Text(snapshot.data[index].productName),
                      subtitle: Text("Rs. ${snapshot.data[index].price} ${snapshot.data[index].id}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: (){
                          setState(() {
                            AppDatabase().deleteOrder(snapshot.data[index]);
                          });
                        },
                        color: Colors.red,
                      ),
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
