import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';
import 'package:seger/Screens/Templates/recipe_list.dart';
import 'package:seger/Screens/calc_screen.dart';

import '../../main.dart';
import '../menu_screen.dart';

class FolderList extends StatefulWidget {
  final bool choose;
  final Recipe recipe;
  final List<MatCalcForm> matItems;
  FolderList({this.choose, this.recipe, this.matItems});
  @override
  _FolderListState createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  Stream<List<Folder>> streamFolders;
  FolderDao folderDao;
  RecipeDao recipeDao;
  RecipeMatDao recipeMatDao;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    folderDao = Provider.of<FolderDao>(context, listen: false);
    recipeDao = Provider.of<RecipeDao>(context, listen: false);
    recipeMatDao = Provider.of<RecipeMatDao>(context, listen: false);
    streamFolders = folderDao.watchFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SegerItems.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SegerItems.blue,
        centerTitle: true,
        title: widget.choose
            ? Text(
                "Save Recipe",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            : Text(
                "Recipes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
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
      body: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Align(
                alignment: Alignment.centerRight,
                child: widget.choose
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return NewFolderPopUp(
                                  folderDao: folderDao,
                                );
                              });
                        },
                        child: Text("New Folder",
                            style: SegerItems.whiteStyle(17))),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: SegerItems.pageDecoration,
              child: Container(
                child: StreamBuilder(
                  stream: streamFolders,
                  builder: (context, AsyncSnapshot<List<Folder>> snapshot) {
                    List<Folder> folders = snapshot.data;
                    return ListView.builder(
                        itemCount: folders != null ? folders.length : 0,
                        itemBuilder: (_, i) {
                          return FolderRow(
                            key: UniqueKey(),
                            folder: folders[i],
                            saveRec: () {
                              if (widget.choose) {
                                saveRecipe(folders[i].id);
                              }
                              else{
                                Navigator.push(context, PageTransition(
                                    child: RecipeList(folder: folders[i]),
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 500)
                                )
                                );
                              }
                            },
                          );
                        });
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void saveRecipe(int folderId) {
    if(widget.recipe==null){
        Navigator.pop(context, folderId);
    }
    else {
      recipeDao
          .insertRecipe(widget.recipe.copyWith(folderId: folderId))
          .then((value) {
        List<RecipeMat> rList = [];
        print("$value this is value");
        widget.matItems.forEach((e) {
          rList.add(RecipeMat(
              matId: e.mat.id, recipeId: value, count: e.count, tag: e.tag));
        });
        recipeMatDao.insertAllRecipeMats(rList).then((v) {
          print("$value THIS VALUE");
          Navigator.pop(context, {"recipeId":value, "folderId":folderId});
        });
      });
    }
  }
}

typedef saveRec = Function();
class FolderRow extends StatefulWidget {
  final Folder folder;
  final saveRec;
  FolderRow({this.folder, this.saveRec, Key key}): super(key: key);
  @override
  _FolderRowState createState() => _FolderRowState();
}

class _FolderRowState extends State<FolderRow> {
  RecipeDao recipeDao;
  Stream<List<Recipe>> lenStream;
  int len;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipeDao = Provider.of<RecipeDao>(context, listen: false);
    lenStream=recipeDao.watchRecipesByFolderId(widget.folder.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.saveRec();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(widget.folder.name),
                  ),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<List<Recipe>>(
                              stream: lenStream,
                              builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
                                len=0;
                                if(snapshot.data!=null)len=snapshot.data.length;
                                return Text("$len");
                              }),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 25,
                            color: SegerItems.blue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}

class NewFolderPopUp extends StatefulWidget {
  TextEditingController controller;
  final FolderDao folderDao;

  NewFolderPopUp({this.folderDao});
  @override
  _NewFolderPopUpState createState() => _NewFolderPopUpState();
}

class _NewFolderPopUpState extends State<NewFolderPopUp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 50,
        child: Center(
          child: TextField(
            controller: widget.controller,
            style: TextStyle(fontSize: 22, color: Colors.black),
            decoration: SegerItems.textFieldDecoration,
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (widget.controller.text.length > 0) {
                widget.folderDao.insertFolder(
                    Folder(name: widget.controller.text, del: true));
                Navigator.pop(context);
              }
            },
            child: Text("Add Folder"))
      ],
    );
  }
}

typedef InsertFolder = void Function();
