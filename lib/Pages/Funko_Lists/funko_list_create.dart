import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FunkoListCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FunkoListCreatePageState();
  }
}

class FunkoListCreatePageState extends State<FunkoListCreatePage> {
  String _name;
  String _description;

  final UserService userService = UserService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Description'),
      maxLength: 140,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _description = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Funkollector'),
          backgroundColor: Colors.deepPurpleAccent
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildName(),
              _buildDescription(),
              SizedBox(height: 15.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Create List',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _saveList();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveList() {
    userService.createFunkoList(_name, _description);
    Fluttertoast.showToast(
        msg: "Tu lista se ha creado exitosamente !!!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(context);
  }
}