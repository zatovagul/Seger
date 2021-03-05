import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/Templates/mat_info.dart';
import 'package:seger/Screens/Templates/mat_set.dart';
import 'package:seger/main.dart';

import '../menu_screen.dart';

class MatList extends StatefulWidget {
  final bool choose;
  MatList({this.choose});
  @override
  _MatListState createState() => _MatListState();
}

class _MatListState extends State<MatList> {
  Stream<List<Mat>> streamMats;
  ValueNotifier<String> _notifier;
  TextEditingController controller;
  List<Mat> mostUsedList;
  MatDao matDao;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matDao=Provider.of<MatDao>(context, listen: false);
    streamMats=matDao.watchMatsOrdered();
    _notifier=ValueNotifier("");
    controller=TextEditingController();

    mostUsedList=[];
    matDao.getMatsOrderedByCount().then((value){
      print("FUUUUCK");
      int n=value.length;
      int l=0;
      for(int i=0;i<n;i++){
        if(l++==4) break;
        mostUsedList.add(value[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SegerItems.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SegerItems.blue,
        centerTitle: true,
        title: SegerItems.segerTopPic,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(PageTransition(child: MenuScreen(), type: PageTransitionType.fade, duration: Duration(milliseconds: 500)), (route) => false);
              },
              child: SegerItems.menuIcon,
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(widget.choose ? "Add Material" : "Materials", style:TextStyle(fontSize: 24, color:Colors.white, fontWeight: FontWeight.bold) ),
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            if(widget.choose)
                              Navigator.pop(context);
                            else
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: MatSettings(),
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Text(widget.choose ? "Cancel" : "+ Create new", style: SegerItems.whiteStyle(17))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: SegerItems.pageDecoration,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black),
                          decoration:
                          SegerItems.textFieldDecoration,
                          onChanged: (value) {
                            _notifier.value=value;
                          },
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: _notifier,
                          builder: (context, value, child) {
                            return Container(
                              child: StreamBuilder(
                                stream: streamMats,
                                builder: (context, AsyncSnapshot<List<Mat>> snapshot){
                                  String letter="a-";
                                  List<Mat> mats=snapshot.data;
                                  return ListView.builder(
                                    itemCount: mats!=null ? mats.length+1 : 1,
                                      itemBuilder: (_,index){
                                        List<Widget> li=[];
                                        if(index==0){
                                          if(mostUsedList.length>0 && _notifier.value.length==0){
                                            List<Widget> list=[];
                                            list.add(Column(children: [
                                              Container(
                                                padding:
                                                EdgeInsets.symmetric(
                                                    vertical: 6),
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    "Most Used",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                              )
                                            ]));
                                            mostUsedList.forEach((element) {
                                              list.add(MatRow(choose: widget.choose,mat: element,));
                                            });
                                            li.add(Container(
                                              margin: EdgeInsets.only(bottom: 50),
                                              child: Column(children: list,),
                                            ));
                                          }
                                        }
                                        else {
                                          Mat mat=mats[index-1];
                                            if (_notifier.value.length == 0) {
                                              if ((letter[0] ==
                                                          mat.name[0]
                                                              .toLowerCase() &&
                                                      letter[1] == '-') ||
                                                  letter[0] !=
                                                      mat.name[0]
                                                          .toLowerCase()) {
                                                Widget letField =
                                                    Column(children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 6),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        mat.name[0]
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 1,
                                                  )
                                                ]);
                                                li.add(letField);
                                                letter =
                                                    "${mat.name.toLowerCase()[0]}+";
                                              }
                                              li.add(MatRow(
                                                mat: mat,
                                                choose: widget.choose,
                                              ));
                                            } else {
                                              if (mat.name
                                                  .toLowerCase()
                                                  .startsWith(controller.text
                                                      .toLowerCase())) {
                                                li.add(MatRow(
                                                  mat: mat,
                                                  choose: widget.choose,
                                                ));
                                              }
                                            }
                                          }
                                          return Column(children: li,);
                                      }
                                  );
                                },
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MatRow extends StatefulWidget {
  final Mat mat;
  bool choose=false;
  MatRow({this.mat, this.choose});
  @override
  _MatRowState createState() => _MatRowState();
}

class _MatRowState extends State<MatRow> {
  MatDao matDao;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matDao=Provider.of<MatDao>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        if(widget.choose){
          int c=widget.mat.count+1;
          matDao.updateMat(widget.mat.copyWith(count: c));
          Navigator.pop(context, widget.mat);
        }
        else{
          Navigator.push(context,PageTransition(
              type: PageTransitionType.rightToLeft,
              child: MatInfoPage(mat: widget.mat,),
              duration: Duration(milliseconds: 500)
          ));
        }
      },
      child: Container(
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
                    child: Text(widget.mat.name),
                  ),
                ],
              ),
            ),
            Divider(height: 1,)
          ],
        ),
      ),
    );;
  }
}



