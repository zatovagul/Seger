import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/Templates/folder_lists.dart';
import 'package:seger/Screens/Templates/mat_list.dart';

import '../main.dart';
import 'menu_screen.dart';

class MatCalcForm {
  Mat mat;
  Map<int, MatOxide> matOxides;
  double count = 0;
  bool tag = false;
  MatCalcForm({this.mat, this.matOxides, this.count, this.tag});
}

class SumOxideForm {
  Oxide oxide;
  double sum = 0;
  SumOxideForm({this.oxide, this.sum});
}

class CalculatorScreen extends StatefulWidget {
  int recipeId;
  bool edit;
  CalculatorScreen({this.recipeId, this.edit});
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool updated;

  Recipe recipe;
  OxideDao oxideDao;
  MatOxideDao matOxideDao;
  RecipeDao recipeDao;
  RecipeMatDao recipeMatDao;
  MatDao matDao;
  BuildContext scafContext;
  List<MatCalcForm> matItems;
  Map<int, Oxide> oxideMap;
  Map<int, SumOxideForm> sumMap;
  Map<String, List<SumOxideForm>> resultMap;
  ValueNotifier<List<MatCalcForm>> _notifier;
  TextEditingController nameController;
  DateTime nowTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updated=false;

    oxideDao = Provider.of<OxideDao>(context, listen: false);
    oxideMap = Map();
    oxideDao.getAllOxides().then((value) => value.forEach((e) {
          oxideMap[e.id] = e;
        }));
    matOxideDao = Provider.of<MatOxideDao>(context, listen: false);
    recipeDao = Provider.of<RecipeDao>(context, listen: false);
    recipeMatDao = Provider.of<RecipeMatDao>(context, listen: false);
    matDao = Provider.of<MatDao>(context, listen: false);

    matItems = [];
    _notifier = ValueNotifier<List<MatCalcForm>>(matItems);

    nameController = TextEditingController();
    nowTime = DateTime.now();

    resultMap = Map();
    resultMap['a'] = [];
    resultMap['ae'] = [];
    resultMap['s'] = [];
    resultMap['gf'] = [];
    resultMap['o'] = [];

    if (widget.recipeId!=null) {
      getRecipeInfo();
    }
  }

  void getRecipeInfo() {
    recipeDao.getRecipeById(widget.recipeId).then((value) {
      recipe = value;
      nameController.text = recipe.name;
      recipeMatDao.getRecipeMatsByRecipeId(recipe.id).then((val) {
        val.forEach((element) {
          Map<int, MatOxide> matO = Map();
          matOxideDao.getMatOxidesByMatId(element.matId).then((value) {
            value.forEach((element) {
              matO[element.oxideId] = element;
            });
          });
          matDao.getMatById(element.matId).then((m) {
            MatCalcForm calcForm = MatCalcForm(
                mat: m,
                matOxides: matO,
                count: element.count,
                tag: element.tag);
            matItems.add(calcForm);
            _notifier.notifyListeners();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Builder(builder: (context) {
        scafContext = context;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder<List<MatCalcForm>>(
                      valueListenable: _notifier,
                      builder: (context, value, child) {
                        _countTable();
                        return Column(
                          children: [
                            CalcTop(
                              resultMap: resultMap,
                              controller: nameController,
                              updated: (){ updated=true;_notifier.notifyListeners(); },
                            ), //TopPart
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: value
                                          .map((e) => MaterialCalcRow(
                                                mat: e,
                                                notifier: _notifier,
                                                updated: (){
                                                  updated=true;
                                                  _notifier.notifyListeners();
                                                },
                                                delete: (){
                                                  matItems.remove(e);
                                                  updated=true;
                                                  _notifier.notifyListeners();
                                                },
                                                tagTrue: () {
                                                  value.remove(e);
                                                  value.add(e);

                                                  updated=true;

                                                  _notifier.notifyListeners();
                                                },
                                                tagFalse: () {
                                                  value.remove(e);
                                                  value.insert(0, e);

                                                  updated=true;

                                                  _notifier.notifyListeners();
                                                },
                                              ))
                                          .toList(),
                                    ),
                                  ), // MaterialsList
                                  GestureDetector(
                                      onTap: () async {
                                        final result = await Navigator.push(
                                            context,
                                            PageTransition(
                                                child: MatList(
                                                  choose: true,
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                duration: Duration(
                                                    milliseconds: 500)));
                                        if (result != null) {
                                          Map<int, MatOxide> matO = Map();
                                          matOxideDao
                                              .getMatOxidesByMatId(
                                                  (result as Mat).id)
                                              .then((value) {
                                            value.forEach((element) {
                                              matO[element.oxideId] = (element);
                                            });
                                            MatCalcForm calcForm = MatCalcForm(
                                                mat: result,
                                                count: 0,
                                                tag: false,
                                                matOxides: matO);
                                            matItems.add(calcForm);

                                            updated=true;

                                            _notifier.notifyListeners();
                                          });
                                        }
                                        print(result);
                                      },
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.all(20),
                                          child: Text(
                                            "+ Add Material",
                                            style: SegerItems.mainTextStyle,
                                          ))), // AddMaterialButton
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                "Total",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Builder(builder: (context) {
                                            double tot = 0;
                                            value.forEach((element) {
                                              tot += element.count;
                                            });
                                            tot = double.parse(
                                                tot.toStringAsFixed(2));
                                            return Text("$tot",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black));
                                          }),
                                          GestureDetector(
                                            onTap: () {
                                              _averageTags();
                                            },
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Icon(
                                                    Icons.radio_button_off,
                                                    color: SegerItems.blue,
                                                    size: 24)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ), // TotalScore and AverageButton
                                  widget.edit
                                      ? Container(
                                    margin: EdgeInsets.only(top: 30, bottom: 30),
                                    child: Column(
                                      children: [
                                          GestureDetector(
                                            onTap:(){
                                                updateRecipe();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 40),
                                              alignment: Alignment.center,
                                              child: Text("Update", style: TextStyle(fontSize: 20, color: updated ? SegerItems.blue : Colors.grey),),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 40),
                                          alignment: Alignment.center,
                                          child: Text("Add Photo", style: TextStyle(fontSize: 20, color: SegerItems.blue),),
                                        ),
                                        GestureDetector(
                                          onTap:(){
                                            copyAndEdit();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 40),
                                            alignment: Alignment.center,
                                            child: Text("Copy and Edit", style: TextStyle(fontSize: 20, color: SegerItems.blue),),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            move();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 40),
                                            alignment: Alignment.center,
                                            child: Text("Move", style: TextStyle(fontSize: 20, color: SegerItems.blue),),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            delete();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 40),
                                            alignment: Alignment.center,
                                            child: Text("Delete", style: TextStyle(fontSize: 20, color: SegerItems.blue),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )  // Edit buttons
                                      : Container(
                                          padding: EdgeInsets.only(
                                              right: 20,
                                              top: 70,
                                              left: 20,
                                              bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _saveRecipe();
                                                },
                                                child: Text(
                                                  "Save",
                                                  style:
                                                      SegerItems.mainTextStyle,
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    matItems.clear();
                                                    _notifier.notifyListeners();
                                                    _countTable();
                                                  },
                                                  child: Text(
                                                    "Clear",
                                                    style: SegerItems
                                                        .mainTextStyle,
                                                  )),
                                            ],
                                          ),
                                        ) // Save and clear Button
                                ],
                              ),
                            ), //BottomPart
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _countTable() {
    sumMap = Map();
    resultMap = Map();
    resultMap['a'] = [];
    resultMap['ae'] = [];
    resultMap['s'] = [];
    resultMap['gf'] = [];
    resultMap['o'] = [];
    for (int i in oxideMap.keys) {
      sumMap[i] = SumOxideForm(oxide: oxideMap[i], sum: 0);
    }
    for (MatCalcForm i in matItems) {
      for (int j in i.matOxides.keys) {
        MatOxide mO = i.matOxides[j];
        double s = mO.count / 100 * i.count;
        sumMap[i.matOxides[j].oxideId].sum += s;
      }
    }
    double s = 0;
    for (SumOxideForm i in sumMap.values) {
      if (i.oxide.role.contains("a")) {
        s += i.sum;
      }
    }
    for (SumOxideForm i in sumMap.values) {
      if (s > 0) i.sum = i.sum * (1 / s);
      //i.sum=double.parse(i.sum.toStringAsFixed(3));
      double nu = double.parse(i.sum.toStringAsFixed(3));
      if (nu >= 0.01) resultMap[i.oxide.role].add(i);
    }
  }

  void _averageTags() {
    double sum = 0;
    matItems.forEach((e) {
      if (!e.tag) {
        sum += e.count;
      }
    });
    if (sum > 0) sum = 100 / sum;
    matItems.forEach((e) {
      if (!e.tag) {
        e.count = e.count * sum;
        e.count = double.parse(e.count.toStringAsFixed(2));
      }
    });
    updated=true;
    _notifier.notifyListeners();
  }

  //Saving recipe. Going to Folder List
  Future<void> _saveRecipe() async {
    if (nameController.text.length == 0) {
      Scaffold.of(scafContext).showSnackBar(SnackBar(
        content: Text('Fill the name'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    } else if (matItems.length == 0) {
      Scaffold.of(scafContext).showSnackBar(SnackBar(
        content: Text('Add material'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    } else {
      recipe = Recipe(name: nameController.text, date: nowTime);
      final result = await Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: FolderList(
                choose: true,
                recipe: recipe,
                matItems: matItems,
              ),
              duration: Duration(milliseconds: 500)));
      recipe = recipe.copyWith(id: result);
      widget.edit = true;
      updated=false;
      _notifier.notifyListeners();
      Scaffold.of(scafContext).showSnackBar(SnackBar(
        content: Text('Recipe Saved'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    }
  }

  void updateRecipe(){
    if(updated){
      recipeDao.updateRecipe(recipe.copyWith(name: nameController.text));
      recipeMatDao.deleteAllRecipeMatsByRecipeId(recipe.id).then((value){
        List<RecipeMat> reMats=[];
        matItems.forEach((element) {
          reMats.add(RecipeMat(matId: element.mat.id, recipeId: recipe.id, count: element.count, tag: element.tag));
        });
        recipeMatDao.insertAllRecipeMats(reMats).then((value){
          updated=false;
          _notifier.notifyListeners();
          Scaffold.of(scafContext).showSnackBar(SnackBar(
            content: Text('Recipe Updated'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ));
        });
      });
    }
    else{

    }
  }
  void copyAndEdit(){
    Navigator.of(context).pushAndRemoveUntil(PageTransition(child:
    CalculatorScreen(recipeId: recipe.id,edit: false,), type: PageTransitionType.fade, duration: Duration(milliseconds: 500)), (route) => false);
  }
  Future<void> move() async {
    final result = await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: FolderList(
              choose: true,
            ),
            duration: Duration(milliseconds: 500)));
    recipeDao.updateRecipe(recipe.copyWith(folderId: result)).then((value) => Scaffold.of(scafContext).showSnackBar(SnackBar(
      content: Text('Recipe Moved'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    )));
  }
  void delete(){
    recipeMatDao.deleteAllRecipeMatsByRecipeId(recipe.id).then((value) => recipeDao.deleteRecipe(recipe).then((value){
      if(widget.recipeId!=null){
        Navigator.pop(context);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(PageTransition(child: CalculatorScreen(edit: false,), type: PageTransitionType.fade, duration: Duration(milliseconds: 500)), (route) => false);
      }
    }));
  }
}

//Top blue part
class CalcTop extends StatefulWidget {
  Map<String, List<SumOxideForm>> resultMap;
  TextEditingController controller;
  final TagSwapping updated;
  CalcTop({this.resultMap, this.controller, this.updated});
  @override
  _CalcTopState createState() => _CalcTopState();
}

class _CalcTopState extends State<CalcTop> {
  static ValueNotifier<int> _pageNotifier;
  PageController _pageController;
  double siAl = 0;
  double al = 0, ae = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageNotifier = ValueNotifier<int>(1);
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    countNum();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: SegerItems.blue,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: ValueListenableBuilder<int>(
                valueListenable: _pageNotifier,
                builder: (context, value, child) {
                  Color white = Color(0xFFFFFFFF);
                  Color trWhite = Color(0x66FFFFFF);
                  List<Widget> li = [];
                  if (value == 0) {
                    li.add(Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.circle,
                          color: white,
                          size: 10,
                        )));
                    li.add(Container(
                        child: Icon(Icons.circle, color: trWhite, size: 10)));
                  } else {
                    li.add(Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Icon(Icons.circle, color: trWhite, size: 10)));
                    li.add(Container(
                        child: Icon(Icons.circle, color: white, size: 10)));
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: li,
                  );
                }),
          ),
          Container(
            height: 260,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              itemBuilder: (_, index) {
                switch (index) {
                  case 0:
                    return Container(
                      color: Colors.pinkAccent,
                    );
                  default:
                    return CalcTable(resultMap: widget.resultMap);
                }
              },
              onPageChanged: (page) {
                _pageNotifier.value = page;
              },
            ),
          ),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "R2O/RO : ",
                      style:
                          TextStyle(fontSize: 14, color: SegerItems.blueGrey),
                    ),
                    Text(
                      "${al}:${ae}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "SiO2/Al2O3 : ",
                      style:
                          TextStyle(fontSize: 14, color: SegerItems.blueGrey),
                    ),
                    Text("${siAl}",
                        style: TextStyle(fontSize: 14, color: Colors.white))
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextField(
              controller: widget.controller,
              style: TextStyle(fontSize: 22, color: Colors.white),
              decoration: SegerItems.whiteTextFieldDecoration,
              onChanged: (value) {
                widget.updated();
              },
            ),
          )
        ],
      ),
    );
  }

  void countNum() {
    al = 0;
    ae = 0;
    siAl = 0;
    double sum = 0, Si = 0, Al = 0;
    widget.resultMap['a'].forEach((e) {
      al += e.sum;
      sum += e.sum;
    });
    widget.resultMap['ae'].forEach((e) {
      ae += e.sum;
      sum += e.sum;
    });
    widget.resultMap.forEach((key, value) {
      value.forEach((e) {
        if (e.oxide.id == 1) Si = e.sum;
        if (e.oxide.id == 2) Al = e.sum;
      });
    });
    if (sum > 0) {
      al = al / sum;
      al = double.parse(al.toStringAsFixed(2));
      ae = ae / sum;
      ae = double.parse(ae.toStringAsFixed(2));
    }
    if (Al > 0) siAl = Si / Al;
    siAl = double.parse(siAl.toStringAsFixed(2));
  }
}

//Table with Oxides counts
class CalcTable extends StatefulWidget {
  Map<String, List<SumOxideForm>> resultMap;
  CalcTable({this.resultMap});
  @override
  _CalcTableState createState() => _CalcTableState();
}

class _CalcTableState extends State<CalcTable> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<SumOxideForm>> rMap = widget.resultMap;
    return Column(
      children: [
        Container(
          height: 230,
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Alcali",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "AEarth",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Stabs",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Gformers",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Color(0x66FFFFFF),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              itemCount: rMap['a'].length,
                              itemBuilder: (_, index) {
                                SumOxideForm form = rMap['a'][index];
                                double sum =
                                    double.parse(form.sum.toStringAsFixed(2));
                                return Text(
                                  "${sum} ${form.oxide.name}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                );
                              }),
                        ),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              itemCount: rMap['ae'].length,
                              itemBuilder: (_, index) {
                                SumOxideForm form = rMap['ae'][index];
                                double sum =
                                    double.parse(form.sum.toStringAsFixed(2));
                                return Text(
                                  "${sum} ${form.oxide.name}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                );
                              }),
                        ),
                      )),
                      Container(
                        height: double.infinity,
                        width: 1,
                        color: Color(0x66FFFFFF),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              itemCount: rMap['s'].length,
                              itemBuilder: (_, index) {
                                SumOxideForm form = rMap['s'][index];
                                double sum =
                                    double.parse(form.sum.toStringAsFixed(2));
                                return Text(
                                  "${sum} ${form.oxide.name}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                );
                              }),
                        ),
                      )),
                      Container(
                        height: double.infinity,
                        width: 1,
                        color: Color(0x66FFFFFF),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ListView.builder(
                              itemCount:
                                  rMap['gf'].length + rMap['o'].length + 1,
                              itemBuilder: (_, index) {
                                SumOxideForm form;
                                //print("$index ${rMap['o'].length}  ${rMap['gf'].length}");
                                if (index == rMap['gf'].length) {
                                  return OthersTe();
                                } else if (index > rMap['gf'].length)
                                  form =
                                      rMap['o'][index - rMap['gf'].length - 1];
                                else
                                  form = rMap['gf'][index];
                                double sum =
                                    double.parse(form.sum.toStringAsFixed(2));
                                return Text(
                                  "${sum} ${form.oxide.name}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                );
                              }),
                        ),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OthersTe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          "Other",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}

//Function for swapping Materials
typedef TagSwapping = Function();

// List of Materials
class MaterialCalcRow extends StatefulWidget {
  ValueNotifier notifier;
  MatCalcForm mat;
  final TagSwapping tagTrue;
  final TagSwapping tagFalse;
  final TagSwapping updated;
  final TagSwapping delete;
  MaterialCalcRow({this.mat, this.notifier, this.tagTrue, this.tagFalse, this.updated, this.delete});
  @override
  _MaterialCalcRowState createState() => _MaterialCalcRowState();
}

class _MaterialCalcRowState extends State<MaterialCalcRow> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    if (widget.mat.tag) color = SegerItems.blue;
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
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
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              widget.mat.tag = !widget.mat.tag;
                              if (widget.mat.tag)
                                widget.tagTrue();
                              else
                                widget.tagFalse();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 10, right: 5),
                                child: Icon(
                                  Icons.add,
                                  color: color,
                                  size: 35,
                                ))),
                        Text(
                          "${widget.mat.mat.name}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: NumberPicker(
                        mat: widget.mat,
                        notifier: widget.notifier,
                        updated: widget.updated,
                      ))
                ],
              ),
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          color:Colors.red,
          icon: Icons.delete,
          onTap: (){
            widget.delete();
          },
        )
      ],
    );
  }
}

class NumberPicker extends StatefulWidget {
  MatCalcForm mat;
  ValueNotifier<List<MatCalcForm>> notifier;
  final TagSwapping updated;
  NumberPicker({this.mat, this.notifier, this.updated});
  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    controller.text = "${widget.mat.count}";
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (double.parse(controller.text.replaceAll(',', '.')) !=
          widget.mat.count) {
        controller.text = "${widget.mat.count}";
      }
    } catch (e) {
      print(e);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            widget.mat.count -= 1;
            controller.text = "${widget.mat.count}";
            widget.updated();
          },
          child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.remove,
                size: 22,
                color: SegerItems.blue,
              )),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: 50, maxHeight: 30, maxWidth: 100),
            child: IntrinsicWidth(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [SegerItems.doubleFilter],
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0))),
                onChanged: (value) {
                  if (value.length > 0)
                    widget.mat.count = double.parse(value.replaceAll(',', '.'));
                  else
                    widget.mat.count = 0;
                  widget.updated();
                  print("THIS VALUE $value");
                },
              ),
            ),
          ),
        ),
        GestureDetector(
            onTap: () {
              widget.mat.count += 1;
              controller.text = "${widget.mat.count}";
              widget.updated();
            },
            child: Container(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.add,
                  size: 22,
                  color: SegerItems.blue,
                ))),
      ],
    );
  }
}
