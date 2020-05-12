import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/authentification.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'Funko_Lists/funkos_list_page.dart';
import 'Funkos/funkos_page.dart';
import 'Profile/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.onSignedOut, this.admin})
      : super(key: key);

  final BaseAuth auth;
  final UserService userService = UserService();
  final VoidCallback onSignedOut;
  final bool admin ;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _pageOptions = [
    UserListPage(),
    FunkosPage(false),
    ProfilePage(),
  ];

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Error al cargar la página principal',
      style: optionStyle,
    ),
    Text(
      'Erro al cargar la página de funkos',
      style: optionStyle,
    ),
    Text(
      'Error al cargar el perfil',
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
    _pageOptions[1] = FunkosPage(widget.admin);
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
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('My Lists'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            title: Text('Funkos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),


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