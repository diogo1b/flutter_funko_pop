import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/models/UserList.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:flutterfunkopop/models/user.dart';

import 'funko_create.dart';
import 'funko_show.dart';
import 'funko_update.dart';

class FunkosPage extends StatefulWidget {
  FunkosPage(this.admin);

  final bool admin;
  final FunkoService funkoService = FunkoService();

  @override
  State<StatefulWidget> createState() => new _FunkosPageState();
}

class _FunkosPageState extends State<FunkosPage> {

  List<Funko> funkoList = [];
  String text_filter = "";

  @override
  void initState() {
    super.initState();
    widget.funkoService.getFunkos().then((_funkoList) {
      setState(() {
        funkoList = _funkoList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(funkoList.length != 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
            floatingActionButton: _addButton(),
            body: _list()
        ),
      );
    }else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          floatingActionButton: _addButton(),
          body: _noList(),
        ),
      );
    }
  }

  Widget _addButton() {
    return new FloatingActionButton(
      onPressed: (){
        _createFunkoPage();
      },
      tooltip: 'Add_Funko_List',
      backgroundColor: Colors.deepPurpleAccent,
      child: new Icon(Icons.add),
    );
  }

  Widget _list() {
    return new Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextFormField(
            initialValue: text_filter,
            decoration:
            InputDecoration(
                icon: Icon(Icons.search)
            ),
            onChanged: (text) {
              text_filter = text;
              _filter();
            },
          ),
        ),
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
                          child : funkoList.image == ""? Image.asset('assets/images/not_found.png') : Image.network(funkoList.image),
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
                      onLongPress: (){
                          if(widget.admin) {
                            _updateFunko(funkoList);
                          }
                      }
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
    return new Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              autofocus: true,
              initialValue: text_filter,
              decoration:
              InputDecoration(
                  icon: Icon(Icons.search)
              ),
              onChanged: (text) {
                text_filter = text;
                _filter();
              },
            ),
          ),
          Container(
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
        ],
    );
  }

  _createFunkoPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) => FormScreen(),
    ));
  }

  _showFunko(Funko funko) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (BuildContext context) => FunkoShowPage(funko),
    ));
  }

  _updateFunko(Funko funko) {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (BuildContext context) => FunkoUpdatePage(funko),
      ));
  }

  _filter() {
    print(text_filter);
    widget.funkoService.getFilteredFunkos(text_filter).then((filteredfunkoList) {
      setState(() {
        funkoList = filteredfunkoList;
      });
    });
  }
}