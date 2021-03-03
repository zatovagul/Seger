import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/calc_screen.dart';

import '../../main.dart';
import '../menu_screen.dart';

class RecipeList extends StatefulWidget {
  Folder folder;
  RecipeList({this.folder});
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  BuildContext scafContext;
  RecipeDao recipeDao;
  RecipeMatDao recipeMatDao;
  FolderDao folderDao;
  Stream<List<Recipe>> recipeStream;
  int size;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipeDao=Provider.of<RecipeDao>(context, listen: false);
    folderDao=Provider.of<FolderDao>(context, listen: false);
    recipeMatDao=Provider.of<RecipeMatDao>(context, listen: false);
    recipeStream=recipeDao.watchRecipesByFolderId(widget.folder.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SegerItems.blue,
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: SegerItems.blue,
        centerTitle: true,
        title: Text(
          "${widget.folder.name}",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
      body: Builder(builder: (context){
        scafContext=context;
        return Column(
          children: [
                Expanded(
                  child: StreamBuilder(
                      stream: recipeStream,
                      builder: (context, AsyncSnapshot<List<Recipe>> snapshot){
                        List<Recipe> recipes=snapshot.data;
                        size=recipes!=null ? recipes.length : 0;
                        return ListView.builder(
                            itemCount: recipes!=null ? recipes.length : 0,
                            itemBuilder: (_, index){
                              Recipe recipe=recipes[index];
                              return Container(
                                child: RecipeRow(recipe: recipe,),
                              );
                            });
                      }),
                ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        bool result=await showDialog(context: context, builder: (context){
                          return RecipeDialog(del:false);
                        });
                        if(result!=null){
                          if(result){
                            deleteRecipes();
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Empty Folder", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        bool result=await showDialog(context: context, builder: (context){
                          return RecipeDialog(del:true,);
                        });
                        if(result!=null){
                          if(result){
                            if(size>0){
                              Scaffold.of(scafContext).showSnackBar(SnackBar(
                                content: Text('Empty Folder at First'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ));
                            }
                            else{
                              folderDao.deleteFolder(widget.folder).then((value){
                                Scaffold.of(scafContext).showSnackBar(SnackBar(
                                  content: Text('Folder deleted'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 1),
                                ));
                                Navigator.pop(context);
                              });
                            }
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(10),
                        child: Text("Delete Folder", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              )
          ],
        );
      }
      ),
    );
  }
  void deleteRecipes(){
    recipeDao.getRecipesByFolderId(widget.folder.id).then((rec){
        rec.forEach((element) {
          Future f=recipeMatDao.deleteAllRecipeMatsByRecipeId(element.id);
          if(rec.indexOf(element)==rec.length-1){
            f.then((value)
            {
              recipeDao.deleteAllRecipesByFolderId(widget.folder.id);

            });
          }
        });
    });
  }
}

class RecipeRow extends StatefulWidget {
  Recipe recipe;
  RecipeRow({this.recipe});
  @override
  _RecipeRowState createState() => _RecipeRowState();
}

class _RecipeRowState extends State<RecipeRow> {
  RecipeMatDao recipeMatDao;
  MatDao matDao;
  List<MatCalcForm> matCalcForms;
  ValueNotifier<List<MatCalcForm>> notifier;
  Stream<List<RecipeMat>> matStream;
  Stream<Mat> materialStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matCalcForms=[];
    notifier=ValueNotifier(matCalcForms);
    recipeMatDao=Provider.of<RecipeMatDao>(context, listen: false);
    matDao=Provider.of<MatDao>(context, listen: false);
    matStream=recipeMatDao.watchRecipeMatsByRecipeId(widget.recipe.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(child: CalculatorScreen(recipeId: widget.recipe.id,edit: true,), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500)));
      },
      child: Container(
          margin: EdgeInsets.only(top: 10, right: 20, left:20),
          decoration: SegerItems.pageDecoration,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        SegerItems.dateFormat.format(widget.recipe.date),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(widget.recipe.name,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black, fontWeight: FontWeight.bold)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:20),
                      child: StreamBuilder<List<RecipeMat>>(
                        stream: matStream,
                        builder: (context,AsyncSnapshot<List<RecipeMat>> snapshot) {
                              List<Widget> list=[];
                              if(snapshot.data!=null)
                              snapshot.data.forEach((element) {
                                list.add(StreamBuilder<Mat>(
                                  stream:matDao.watchMatByMatId(element.matId) ,
                                  builder: (context, AsyncSnapshot<Mat> snapMat){
                                    if(snapMat.data==null){
                                      return Container();
                                    }
                                    MatCalcForm calcForm=MatCalcForm(mat: snapMat.data,count: element.count, tag: element.tag);
                                    matCalcForms.add(calcForm);
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            element.tag ? Center(
                                              child: Icon(
                                                Icons.add,
                                                color: SegerItems.blue,
                                                size: 20,
                                              ),
                                            ) : Container(),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text("${calcForm.mat.name}", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            )
                                          ],
                                        ),
                                        Container(
                                          child:Text("${calcForm.count }", style: TextStyle(fontSize: 16, color: Colors.black),) ,
                                        )
                                      ],
                                    );
                                  },
                                ));
                              });
                              return Column(children: list,);

                        }
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}

class RecipeDialog extends StatefulWidget {
  final bool del;
  RecipeDialog({this.del});
  @override
  _RecipeDialogState createState() => _RecipeDialogState();
}

class _RecipeDialogState extends State<RecipeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure to "+(widget.del ? "Delete folder?" : " Empty folder?"),  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context, true);
        }, child: Text("Yes", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
        TextButton(onPressed: (){
          Navigator.pop(context, false);
        }, child: Text("No", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
      ],
    );
  }
}


