import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Pages/Funkos/funko_show.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'package:flutterfunkopop/models/UserList.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:flutterfunkopop/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FunkoListShow extends StatefulWidget {
  FunkoListShow(this.listId);
  final String listId;
  final UserService userService = UserService();

  @override
  State<StatefulWidget> createState() {
    return _FunkoListShowState();
  }
}

class _FunkoListShowState extends State<FunkoListShow> {

  List<Funko> funkoList = [];

  @override
  void initState() {
    super.initState();
    widget.userService.getFunkosFromList(widget.listId).then((_funkoList) {
      setState(() {
        funkoList = _funkoList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(funkoList.length != 0) {
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
              children: funkoList
                  .map((Funko funkoList) => Card(
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
                          child: funkoList.image == null || funkoList.image == ""? Image.asset('assets/images/not_found.png') : Image.network(funkoList.image)
                        ),
                        title: Text(
                          funkoList.name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(Icons.linear_scale, color: Colors.deepPurpleAccent),
                            Text(funkoList.number, style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        trailing: (
                            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0)
                        ),
                        onTap: ()=> _showFunko(funkoList),
                        onLongPress: ()=> _removeFunko(funkoList.id),
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

  _removeFunko(String funko_id) {
    widget.userService.removeFromList(funko_id , widget.listId);
    Fluttertoast.showToast(
        msg: "You have removed this funko !!!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    (context as Element).reassemble();
  }

  _showFunko(Funko funko) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) => FunkoShowPage(funko),
    ));
  }
}