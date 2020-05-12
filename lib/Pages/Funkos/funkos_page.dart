import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'funko_create.dart';

class FunkosPage extends StatefulWidget {
  FunkosPage(this.admin);

  final bool admin;

  @override
  State<StatefulWidget> createState() => new _FunkosPageState();
}

class _FunkosPageState extends State<FunkosPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child:
            Text('Funko Page'),
        ),
          floatingActionButton: new Visibility(
            visible:widget.admin,
            child : new FloatingActionButton(
              onPressed: (){
                print("clicked");
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (BuildContext context) => FormScreen(),
                ));
              },
              tooltip: 'Add_Funko',
              backgroundColor: Colors.deepPurpleAccent,
              child: new Icon(Icons.add),
            ),
          )
      ),
    );
  }
}