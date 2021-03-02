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
  MatDao matDao;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matDao=Provider.of<MatDao>(context, listen: false);
    streamMats=matDao.watchMatsOrdered();
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
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black),
                          decoration:
                          SegerItems.textFieldDecoration,
                          onChanged: (value) {
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: StreamBuilder(
                            stream: streamMats,
                            builder: (context, AsyncSnapshot<List<Mat>> snapshot){
                              String letter="a-";
                              List<Mat> mats=snapshot.data;
                              return ListView.builder(
                                itemCount: mats!=null ? mats.length : 0,
                                  itemBuilder: (_,index){
                                    List<Widget> li=[];
                                    Mat mat=mats[index];
                                    if((letter[0]==mat.name[0].toLowerCase() && letter[1]=='-') || letter[0]!=mat.name[0].toLowerCase()){
                                      Widget letField= Column(
                                          children:[Container(
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        child: Align(alignment: Alignment.centerLeft,child: Text(mat.name[0].toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
                                      ), Divider(height: 1,)
                                          ]
                                    );
                                      li.add(letField);
                                      letter="${mat.name.toLowerCase()[0]}+";
                                    }
                                    li.add( MatRow(mat:mat, choose: widget.choose,));
                                    return Column(children: li,);
                                  }
                              );
                            },
                          ),
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        if(widget.choose){
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



