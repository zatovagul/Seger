import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/menu_screen.dart';
import 'package:seger/main.dart';

class OxideRoleSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final oxideDao=Provider.of<OxideDao>(context);
    return Scaffold(
      backgroundColor: SegerItems.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: SvgPicture.asset("assets/images/seger_icon.svg", width: 70.0),
        backgroundColor: SegerItems.blue,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, PageTransition(type:PageTransitionType.fade,child:MenuScreen(), duration: Duration(milliseconds: 500)));
                },
                child: Icon(
                  Icons.menu,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
          )
        ],
      ),
      body: Container(
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
                    Text("Cancel", style:SegerItems.whiteStyle(15))
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
                              Expanded(child: Center(child: Text("A"))),
                              Expanded(child: Center(child: Text("AE"))),
                              Expanded(child: Center(child: Text("St"))),
                              Expanded(child: Center(child: Text("GF"))),
                              Expanded(child: Center(child: Text("Oth"))),
                            ],
                          ),
                        ))
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: StreamBuilder(
                          stream: oxideDao.watchOxides(),
                          builder: (context, AsyncSnapshot<List<Oxide>> oxides){
                              return ListView.builder(
                                  itemCount: oxides.data!=null ? oxides.data.length : 0,
                                  itemBuilder:  (_,index){
                                    Oxide oxide=oxides.data[index];
                                    print("${oxide.name} ${oxide.role}");
                                    return OxideRoleRow(oxide: oxide);
                                  }
                              );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
            child: Text(oxide.name),
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

