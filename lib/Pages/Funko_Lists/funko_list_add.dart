import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Pages/Funkos/funko_show.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'package:flutterfunkopop/models/UserList.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:flutterfunkopop/models/user.dart';

class FunkoListAdd extends StatefulWidget {
  FunkoListAdd(this.funko);
  final Funko funko;
  final UserService userService = UserService();

  @override
  State<StatefulWidget> createState() {
    return _FunkoListAddState();
  }
}

class _FunkoListAddState extends State<FunkoListAdd> {

  List<UserList> userList = [];

  @override
  void initState() {
    super.initState();
    widget.userService.getUserLists().then((_funkoList) {
      setState(() {
        userList = _funkoList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(userList.length != 0) {
      return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Funkollector'),
              backgroundColor: Colors.deepPurpleAccent
          ),
          body: _list()
      );
    }else {
      return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Funkollector'),
            backgroundColor: Colors.deepPurpleAccent
        ),
        body: _noList(),
      );
    }
  }

  Widget _list() {
    return new Column(
      children: <Widget>[
        Expanded(
          child: ListView(
              children: userList
                  .map((UserList userList) => Card(
                elevation: 2,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.black))),
                        child: Image.asset(
                          'assets/images/stan.png',
                        ),
                      ),
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
                          Icon(Icons.add, color: Colors.black, size: 30.0)
                      ),
                      onTap: ()=> _addFunko(userList.id),
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

  _addFunko(String list_id) {
    widget.userService.addToList(widget.funko , list_id);
    Navigator.pop(context);
  }

}