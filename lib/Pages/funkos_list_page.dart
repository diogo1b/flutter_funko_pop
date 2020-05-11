import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FunkosListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _FunkosListPageState();
}

class _FunkosListPageState extends State<FunkosListPage> {

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
          child: Text('Funkos Lists page'),
        ),
      ),
    );
  }
}