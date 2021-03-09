import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/menu_screen.dart';
import 'package:seger/main.dart';

class OxideRoleSettings extends StatefulWidget {
  @override
  _OxideRoleSettingsState createState() => _OxideRoleSettingsState();
}

class _OxideRoleSettingsState extends State<OxideRoleSettings> {
  Stream<List<Oxide>> streamOxide;
  OxideDao oxideDao;
  BuildContext scafContext;

  @override
  void initState() {
    super.initState();
    oxideDao=Provider.of<OxideDao>(context, listen:false);
    streamOxide=oxideDao.watchOxides();
  }
  @override
  Widget build(BuildContext context) {
    List<Oxide> oxideList=[];
    return Scaffold(
      backgroundColor: SegerItems.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: SegerItems.segerTopPic,
        backgroundColor: SegerItems.blue,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: (){
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
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20,  bottom: 20),
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Oxide Role", style: SegerItems.whiteStyle(19),),
                        Text("", style:SegerItems.whiteStyle(15))  //cancelText
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top:10,left:20,right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: SegerItems.pageDecoration,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 50,
                            ),
                            Expanded(child: Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(child: Center(child: Text("A", style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: "PTSans"),))),
                                  Expanded(child: Center(child: Text("AE", style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: "PTSans")))),
                                  Expanded(child: Center(child: Text("St", style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: "PTSans")))),
                                  Expanded(child: Center(child: Text("GF", style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: "PTSans")))),
                                  Expanded(child: Center(child: Text("Oth", style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: "PTSans")))),
                                ],
                              ),
                            ))
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: StreamBuilder(
                              stream: streamOxide,
                              builder: (context, AsyncSnapshot<List<Oxide>> oxides){
                                  return ListView.builder(
                                      itemCount: oxides.data!=null ? oxides.data.length+1 : 1,
                                      itemBuilder:  (_,index){
                                        if(oxides.data==null || index==oxides.data.length){
                                          return Container(
                                            margin: EdgeInsets.only(top:20, bottom: 20),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: (){
                                                  for(Oxide o in oxideList){
                                                    //print("${o.name} ${o.role} ${o.defRole}");
                                                    if(o.defRole!=o.role)
                                                    oxideDao.updateOxide(o.copyWith(role:o.defRole));
                                                  }
                                                  Scaffold.of(scafContext).showSnackBar(SnackBar(content: Text('😎 Welcome back to classic UMF'), backgroundColor: Colors.green,));
                                                },
                                                child: Text("Reset to defaults", style: TextStyle(fontSize: 20, color: SegerItems.blue)),
                                              ),
                                            ),
                                          );
                                        }
                                        Oxide oxide=oxides.data[index];
                                        oxideList.add(oxide);
                                        //print("${oxide.name} ${oxide.role}");
                                        return OxideRoleRow(oxide: oxide);
                                      }
                                  );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class OxideRoleRow extends StatefulWidget {
  final Oxide oxide;
  OxideRoleRow({this.oxide});

  @override
  _OxideRoleRowState createState() => _OxideRoleRowState();
}

class _OxideRoleRowState extends State<OxideRoleRow> {
  String _role="a";
  @override
  Widget build(BuildContext context) {
    OxideDao dao=Provider.of<OxideDao>(context);
    Oxide oxide= widget.oxide;
    _role=oxide.role;
    return Row(
      children: [
        Container(
          width: 80,
          height: 50,
          child: Center(
            child: OxideText(text:oxide.name, style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: "PTSans")),
          ),
        ),
        Expanded(child: Container(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Center(child: new Radio( value: "a", groupValue: _role, onChanged: (String value){
                setState(() {
                  _role=value;
                  Oxide newO=oxide.copyWith(role:value);
                  dao.updateOxide(newO);
                });
              }))),
              Expanded(child: Center(child: new Radio( value: "ae", groupValue: _role, onChanged: (String value){
                setState(() {
                  _role=value;
                  Oxide newO=oxide.copyWith(role:value);
                  dao.updateOxide(newO);
                });
              }))),
              Expanded(child: Center(child: new Radio(value: "s", groupValue: _role, onChanged: (String value){
                setState(() {
                  _role=value;
                  Oxide newO=oxide.copyWith(role:value);
                  dao.updateOxide(newO);
                });
              }))),
              Expanded(child: Center(child: new Radio(value: "gf", groupValue: _role, onChanged: (String value){
                setState(() {
                  _role=value;
                  Oxide newO=oxide.copyWith(role:value);
                  dao.updateOxide(newO);
                });
              }))),
              Expanded(child: Center(child: new Radio(value: "o", groupValue: _role, onChanged: (String value){
                setState(() {
                  _role=value;
                  Oxide newO=oxide.copyWith(role:value);
                  dao.updateOxide(newO);
                });
              }))),

                       ],
          ),
        ))
      ],
    );
  }
}

