import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/Templates/mat_set.dart';
import 'package:seger/main.dart';

import '../menu_screen.dart';

class MatInfoPage extends StatefulWidget {
  Mat mat;
  MatInfoPage({this.mat});
  @override
  _MatInfoPageState createState() => _MatInfoPageState();
}

class _MatInfoPageState extends State<MatInfoPage> {
  BuildContext scafContext;
  MatDao matDao;MatOxideDao matOxideDao;OxideDao oxideDao;
  Map<int, Oxide> oxideMap;
  Stream<Mat> matStream;
  Stream<List<MatOxide>> matOxideStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oxideDao = Provider.of<OxideDao>(context, listen: false);
    oxideMap = Map();
    oxideDao.getAllOxides().then((value) => value.forEach((e) {
      oxideMap[e.id] = e;
    }));

    matDao=Provider.of<MatDao>(context, listen:false);
    matOxideDao=Provider.of<MatOxideDao>(context, listen:false);
    matStream=matDao.watchMatByMatId(widget.mat.id);
    matOxideStream=matOxideDao.watchMatOxidesByMatId(widget.mat.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SegerItems.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SegerItems.blue,
        centerTitle: true,
        title: Text(
          "Material",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: MenuScreen(),
                        duration: Duration(milliseconds: 500)));
              },
              child: SegerItems.menuIcon,
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context){
          scafContext=context;
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, PageTransition(
                              child: MatSettings(mat: widget.mat,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
                          ));
                        },
                        child: Text("Edit", style: SegerItems.whiteStyle(17))),
                  ),
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: SegerItems.pageDecoration,
                      child: SingleChildScrollView(
                        child: StreamBuilder(
                          stream: matStream,
                          builder: (context, AsyncSnapshot<Mat> matSnapshot){
                            return Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(matSnapshot.data!=null ? matSnapshot.data.name : "",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black, fontWeight: FontWeight.bold)
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top:20),
                                  child: Text(matSnapshot.data!=null ? matSnapshot.data.info : "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black)
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Percentage analysis",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top:10),
                                  child: StreamBuilder(
                                    stream: matOxideStream,
                                      builder: (context, AsyncSnapshot<List<MatOxide>> matOxSnapshot){
                                          List<MatOxide> moForms=matOxSnapshot.data;
                                          List<Widget> list=[];
                                          double tot=0;
                                          if(moForms!=null)
                                          moForms.forEach((element) {
                                            tot+=element.count;
                                            list.add(Container(
                                              height: 51,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Center(
                                                          child: Text(oxideMap[element.oxideId].name),
                                                        ),
                                                        Center(
                                                          child: Text("${element.count}"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(height: 1,)
                                                ],
                                              ),
                                            ));
                                          });
                                          tot=double.parse(tot.toStringAsFixed(2));
                                          list.add(Container(
                                            height: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Total:",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Text("$tot",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: SegerItems.blue),
                                                )
                                              ],
                                            ),
                                          ));
                                          if(matSnapshot.data!=null)
                                            if(matSnapshot.data.date!=null)
                                              list.add(Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 20),
                                                child: Text(
                                                  "${SegerItems.dateFormat.format(matSnapshot.data.date)}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ));
                                          return Column(
                                            children: list,
                                          );
                                      }
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


