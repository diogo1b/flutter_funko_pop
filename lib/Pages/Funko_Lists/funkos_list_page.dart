import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'package:flutterfunkopop/models/UserList.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:flutterfunkopop/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'funko_list_create.dart';
import 'funko_list_show.dart';

class UserListPage extends StatefulWidget {

  final UserService userService = UserService();

  @override
  State<StatefulWidget> createState() => new _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  List<UserList> userLists = [];

  @override
  void initState() {
    super.initState();
    widget.userService.getUserLists().then((_userLists) {
      setState(() {
        userLists = _userLists;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(userLists.length != 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: _addButton(),
          body: _list()
        ),
      );
    }else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: _addButton(),
          body: _noList(),
        ),
      );
    }
  }

  Widget _addButton() {
    return new FloatingActionButton(
      onPressed: (){
        _addListButton();
      },
      tooltip: 'Add_Funko_List',
      backgroundColor: Colors.deepPurpleAccent,
      child: new Icon(Icons.add),
    );
  }

  Widget _list() {
    return new Column(
      children: <Widget>[
        Expanded(
          child: ListView(
              children: userLists
                  .map((UserList userList) => Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        userList.name,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.linear_scale, color: Colors.deepPurpleAccent),
                          Text(userList.description, style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      trailing: (
                          Icon(Icons.keyboard_arrow_right, color: Colors.deepPurpleAccent, size: 30.0)
                      ),
                      onTap: ()=> _Funkos(userList.id),
                      onLongPress: ()=> _RemoveList(userList.id),
                    )
                  ],
                ),
              )).toList()
          ),
        ),
      ],
    );
  }

  Widget _noList() {
    return new Center(
      child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 120.0,
              child: Image.asset(
                'assets/images/not_found.png',
              ),
            ),
          ),
      ),
    );
  }

  _addListButton() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) => FunkoListCreatePage(),
    ));
  }

  _Funkos (String list) {
    print(list);
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) => FunkoListShow(list),
    ));
  }

  _RemoveList(String list_id) {
    widget.userService.deleteList(list_id);
    Fluttertoast.showToast(
        msg: "You have removed your list !!!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    (context as Element).reassemble();
  }
}