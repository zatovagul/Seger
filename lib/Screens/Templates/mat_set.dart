import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/Templates/mat_list.dart';
import 'package:seger/main.dart';

import '../menu_screen.dart';

class OxideInfo {
  Oxide oxide;
  double num = 0;
  OxideInfo({this.oxide, this.num});
}

class MatSettings extends StatefulWidget {
  final Mat mat;

  MatSettings({this.mat});

  @override
  _MatSettingsState createState() => _MatSettingsState();
}

class _MatSettingsState extends State<MatSettings> {
  bool edit = false;

  bool delete;

  Future<List<Oxide>> _futureBuilder;
  Map<int, MatOxide> matOxideMap;
  static ValueNotifier<double> _notifier;

  OxideDao oxideDao;
  MatDao matDao;
  MatOxideDao matOxideDao;
  BuildContext scafContext;

  TextEditingController nameController;

  TextEditingController infoController;

  List<OxideInfo> oxideInfo;
  String name="";
  String info="";

  double percentage=0;
  DateTime nowTime;


  void _percChange(){
    percentage=0;oxideInfo.forEach((element) {percentage+=element.num; });
    print("THIS IS percentage $percentage");
    _notifier.value=percentage;
  }


  @override
  void initState() {
    super.initState();
    nameController=TextEditingController();
    infoController=TextEditingController();
    matOxideMap=Map();
    edit = widget.mat != null;
    name= edit ? widget.mat.name : "";
    nameController.text =name;
    info = edit ? widget.mat.info : "";
    infoController.text = info;

    oxideInfo = [];

    _notifier=ValueNotifier<double>(0);

    delete=true;
    if(edit) Provider.of<RecipeMatDao>(context, listen:false).getRecipeMatsByMatId(widget.mat.id).then((value)
    {
      if(value.length > 0)
        delete=false;
    }
    );

    oxideDao = Provider.of<OxideDao>(context, listen: false);
    matDao = Provider.of<MatDao>(context, listen: false);
    matOxideDao = Provider.of<MatOxideDao>(context, listen: false);
    if(edit)
      matOxideDao.getMatOxidesByMatId(widget.mat.id).then((value) => value.forEach((element) {
        matOxideMap[element.oxideId]=element;
      }));
    _futureBuilder = oxideDao.getAllOxides();
    _futureBuilder.then((value)
    {
      double s=0;
          value.forEach((element) {
            double su = 0;
            if (edit) {
              if (matOxideMap.containsKey(element.id))
                su = matOxideMap[element.id].count;
            }
            s+=su;
            oxideInfo.add(OxideInfo(oxide: element, num: su));
          });
          _notifier.value=s;
        });

    nowTime=DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: SegerItems.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SegerItems.blue,
        centerTitle: true,
        title: Text(
          edit ? "Edit Material" : "New Material",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "PTSans"),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: MenuScreen(),
                        duration: Duration(milliseconds: 250)));
              },
              child: SegerItems.menuIcon,
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          scafContext=context;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          _makeInsert();
                        },
                        child: Text("Save", style: SegerItems.whiteStyle(17))),
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
                      Expanded(
                          child: Container(
                        child: FutureBuilder(
                          future: _futureBuilder,
                          builder:
                              (context, AsyncSnapshot<List<Oxide>> oxides) {
                            return ListView.builder(
                              itemCount: oxides.data != null
                                  ? oxides.data.length + 2
                                  : 2,
                              itemBuilder: (_, i) {
                                if (i == 0) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: TextField(
                                          controller: nameController,
                                          inputFormatters: [SegerItems.nameFilter],
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black, fontFamily: "PTSans"),
                                          decoration:
                                              SegerItems.textFieldDecoration,
                                          onChanged: (value) {
                                            setState(() {
                                              this.name = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          controller: infoController,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black, fontFamily: "PTSans"),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: SegerItems.greyi,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      color: SegerItems.blue,
                                                      width: 1.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      color: SegerItems.blue,
                                                      width: 1.0))),
                                          onChanged: (value) {
                                            setState(() {
                                              this.info = value;
                                            });
                                          },
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
                                                color: Colors.black,fontFamily: "PTSans", fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (oxides.data == null ||
                                    i == oxides.data.length + 1) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total:",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,fontFamily: "PTSans",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              ValueListenableBuilder<double>(
                                                  valueListenable: _notifier,
                                                  builder: (context, value, child){
                                                    double to=double.parse(value.toStringAsFixed(2));
                                                    if(to==0 && edit) _percChange();
                                                    return Text("$to",
                                                      style: TextStyle(
                                                          fontSize: 17,fontFamily: "PTSans",
                                                          color: SegerItems.blue),
                                                    );
                                                  }
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 20),
                                          child: Text(
                                            SegerItems.dateFormat.format(nowTime),
                                            style: TextStyle(
                                                fontSize: 12,fontFamily: "PTSans",
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                OxideChangeRow changeRow =
                                    OxideChangeRow(
                                        oxide: oxideInfo[i - 1],
                                        percChangeCall: (){
                                          _percChange();
                                        },
                                    );
                                return changeRow;
                              },
                            );
                          },
                        ),
                      ))
                    ],
                  ),
                )),
                !edit ? Container(): GestureDetector(
                  onTap: (){
                    if(delete) {
                            matOxideDao
                                .deleteMaterialOxidesByMatId(widget.mat.id)
                                .then((value) {
                              matDao.deleteMat(widget.mat);
                              Navigator.of(context).pushAndRemoveUntil(
                                  PageTransition(
                                      child: MatList(
                                        choose: false,
                                      ),
                                      type: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 250)),
                                  (route) => false);
                            });
                          }
                    else{
                      Scaffold.of(scafContext).showSnackBar(SnackBar(content: Text('😯 You cannot delete this material. it is used in your recipes.'), backgroundColor: Colors.red,duration: Duration(seconds: 1),));
                    }
                        },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    child:  Text("Delete Material", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      ),
    );
  }

  //Inserting Mat with MatOxides
  _makeInsert(){
    double l=0;
    oxideInfo.forEach((element) { l+=element.num; });
    if(name==""){
      Scaffold.of(scafContext).showSnackBar(SnackBar(content: Text('🙏 Give me the name! Please.'), backgroundColor: Colors.red,));
    }
    else if(l<=0){
      Scaffold.of(scafContext).showSnackBar(SnackBar(content: Text('Set percentage to oxides'), backgroundColor: Colors.red,));
    }
    else {
      if(edit){
        Future updateInfo=matDao.updateMat(widget.mat.copyWith(name:name, lowerName: name.toLowerCase(), info: info, def: false, date: nowTime));
        updateInfo.then((value){
          matOxideDao.deleteMaterialOxidesByMatId(widget.mat.id).then((v){
            List<MatOxide> matOxides = [];
            oxideInfo.forEach((element) {
              if (element.num > 0)
                matOxides.add(MatOxide(
                    oxideId: element.oxide.id, matId: widget.mat.id, count: element.num));
            });
            matOxideDao.insertAllMaterialOxides(matOxides);
          });
        });
      }
      else {
        Future insertInfo = matDao.insertNewMat(
            Mat(name: name,lowerName: name.toLowerCase(), info: info, def: false, date: nowTime));
        insertInfo.then((value) {
          List<MatOxide> matOxides = [];
          oxideInfo.forEach((element) {
            if (element.num > 0)
              matOxides.add(MatOxide(
                  oxideId: element.oxide.id, matId: value, count: element.num));
          });
          matOxideDao.insertAllMaterialOxides(matOxides);
        });
      }
      Navigator.pop(context);
    }
  }
}


typedef PercChangeCall=void Function();

class OxideChangeRow extends StatefulWidget {
  final OxideInfo oxide;
  final PercChangeCall percChangeCall;
  TextEditingController controller;
  double num = 0;
  OxideChangeRow({this.oxide, this.percChangeCall});
  @override
  _OxideChangeRowState createState() => _OxideChangeRowState();
}

class _OxideChangeRowState extends State<OxideChangeRow> {
  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    widget.controller = TextEditingController();
    widget.controller.text = widget.oxide.num != 0 ? "${widget.oxide.num}" : "";

    _focusNode=FocusNode();
    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        if(widget.controller.text.length>0)
        widget.controller.selection= TextSelection(baseOffset: 0, extentOffset: widget.controller.text.length);
        else
          widget.controller.selection=null;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: OxideText(text:widget.oxide.oxide.name, style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: "PTSans"),),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 70, maxHeight: 30, maxWidth: 150),
                    child: IntrinsicWidth(
                      child: TextField(
                        focusNode: _focusNode,
                        controller: widget.controller,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          SegerItems.doubleFilter,
                        ],
                        style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "PTSans"),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 0, bottom: 0, left: 5, right: 5),
                            filled: true,
                            fillColor: SegerItems.greyi,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: SegerItems.greyi, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: SegerItems.greyi, width: 1.0))),
                        onChanged: (value) {
                          setState(() {
                            if(value.length>0)
                              widget.oxide.num = double.parse(value.replaceAll(',', '.'));
                            else
                              widget.oxide.num=0;
                          });
                          widget.percChangeCall();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
