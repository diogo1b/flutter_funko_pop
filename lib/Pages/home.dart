import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/authentification.dart';
import 'package:flutterfunkopop/services/userService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut, this.admin})
      : super(key: key);

  final BaseAuth auth;
  final UserService userService = UserService();
  final VoidCallback onSignedOut;
  final String userId;
  final bool admin ;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Lists',
      style: optionStyle,
    ),
    Text(
      'Index 1: Create2',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Funkollector'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          new FlatButton(
            child: new Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: _signOut,
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            title: Text('Funkos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),

      floatingActionButton: new Visibility(
        visible: widget.admin,
        child : new FloatingActionButton(
          onPressed: null,
          tooltip: 'Add_Funko',
          backgroundColor: Colors.deepPurpleAccent,
          child: new Icon(Icons.add),
        ),
      )
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}