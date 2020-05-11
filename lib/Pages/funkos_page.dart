import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FunkosPage extends StatefulWidget {

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
          child: Text('Funko Page'),
        ),
      ),
    );
  }
}