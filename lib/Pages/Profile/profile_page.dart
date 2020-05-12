import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Pages/Profile/update_profile_page.dart';
import 'package:flutterfunkopop/Services/authentification.dart';
import 'package:flutterfunkopop/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {

  final Auth auth = Auth();

  @override
  State<StatefulWidget> createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User _user;
  String _userId = "";
  String _userName = "";
  String _created_at = "";
  String _image = 'empty';
  String _role = "";
  String _phrase = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUserComplete().then((user) {
      setState(() {
          _userId = user?.uid;
          _userName = user?.name;
          _created_at = user?.created_at;
          _image = user?.image;
          _role = user?.role;
          _phrase = user?.phrase;
          _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    Timer.periodic(Duration(seconds: 15), (Timer t) =>
        widget.auth.getCurrentUserComplete().then((user) {
          setState(() {
            _userId = user?.uid;
            _userName = user?.name;
            _created_at = user?.created_at;
            _image = user?.image;
            _role = user?.role;
            _phrase = user?.phrase;
            _user = user;
          });
        })
    );

     */

    return new Scaffold(
        floatingActionButton: _editButton(),
      body: _showBody(),
    );
  }

  Widget _showBody(){
    return new Center(
        child: new Container(
            padding: const EdgeInsets.all(30.0),
              child: new Column(
                children: <Widget>[
                  _showMainData(),
                  _showLogo(),
                  _showPhrase(),
                ],
              ),
        )
    );
  }

  Widget _showMainData() {
    return new Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
              Text(
                'Member Since : ' + _created_at,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15
                ),
              ),
            ],
          ),
        ),
        /*3*/
        IconButton(
          icon : Icon(Icons.share, size: 30.0),
          color: Colors.grey[600],
          onPressed: () {
            share();
          },
        ),
      ],
    );
  }

  Widget _showLogo() {
    return new Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 120.0,
          child: Image.asset(
            'assets/images/'+_image+'.png',
          ),
        ),
      ),
    );
  }

  Widget _showPhrase() {
    return new Container(
      child: Text(
        _phrase,
        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        softWrap: true,
      ),
    );
  }

  Widget _editButton() {
    return new FloatingActionButton(
              onPressed: (){
                print("clicked");
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileUpdate(_user),
                ));
              },
              tooltip: 'Add_Funko',
              backgroundColor: Colors.deepPurpleAccent,
              child: new Icon(Icons.edit),
    );
  }

  share() {
    final String title = "Funkollector";
    //Share.share(title, subject: "Esta aplicación es para ti !!!! Prueba este nuevo sistema para llevar el registro de tus funkos favoritos !!!!!");
  }
}