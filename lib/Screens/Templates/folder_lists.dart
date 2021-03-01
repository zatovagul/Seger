import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seger/Database/moor_database.dart';

import '../../main.dart';
import '../menu_screen.dart';

class FolderList extends StatefulWidget {
  @override
  _FolderListState createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  Stream<List<Folder>> streamFolders;
  FolderDao folderDao;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    folderDao=Provider.of<FolderDao>(context, listen: false);
    streamFolders=folderDao.watchFolders();
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
          "Recipes",
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
      body: Container(
        margin: EdgeInsets.only(right:20, left:20, bottom:20),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return NewFolderPopUp(folderDao: folderDao,);
                    });

                  },
                    child: Text("New Folder", style: SegerItems.whiteStyle(17))),
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top:10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: SegerItems.pageDecoration,
                  child: Container(
                    child: StreamBuilder(
                      stream: streamFolders,
                      builder: (context, AsyncSnapshot<List<Folder>> snapshot){
                        List<Folder> folders=snapshot.data;
                        return ListView.builder(
                          itemCount:folders!=null ? folders.length : 0 ,
                            itemBuilder: (_,i){
                              return FolderRow(folder: folders[i],);
                            }
                        );
                      },
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}
class FolderRow extends StatefulWidget {
  final Folder folder;
  FolderRow({this.folder});
  @override
  _FolderRowState createState() => _FolderRowState();
}

class _FolderRowState extends State<FolderRow> {
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
                  child: Text(widget.folder.name),
                ),
                Row(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("20"),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Icon(Icons.arrow_forward_ios_outlined, size:25, color: SegerItems.blue,),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(height: 1,)
        ],
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
    widget.controller=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 50,
        child: Center(
          child: TextField(
            controller: widget.controller,
            style: TextStyle(
                fontSize: 22,
                color: Colors.black),
            decoration:
            SegerItems.textFieldDecoration,
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: (){
              if(widget.controller.text.length>0) {
                widget.folderDao.insertFolder(
                    Folder(name: widget.controller.text, del: true));
                Navigator.pop(context);
              }
            },
            child: Text("Add Folder")
        )
      ],
    );
  }
}
typedef InsertFolder=void Function();

