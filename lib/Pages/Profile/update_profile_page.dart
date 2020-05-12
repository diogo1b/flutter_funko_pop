import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Pages/Profile/profile_page.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'package:flutterfunkopop/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileUpdate extends StatefulWidget {
  ProfileUpdate(this.user);
  var user;

  @override
  State<StatefulWidget> createState() {
    return ProfileUpdateScreenState();
  }
}

class ProfileUpdateScreenState extends State<ProfileUpdate> {

  final UserService userService = UserService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _phrase;
  String _image = 'stan';

  Widget _buildName() {
    return TextFormField(
      initialValue: widget.user.name,
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

  Widget _buildImage() {
    return DropdownButton<String>(
      value: _image,
      isExpanded: true,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 0,
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          _image = newValue;
        });
      },
      items: <String>['stan', 'yoda', 'deadpool'].map<DropdownMenuItem<String>>((String value) {
        return new DropdownMenuItem<String>(
            value: value,
            child: new Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          height: 100.0,
          child: new Row(
            children: <Widget>[
              Image.asset(
                'assets/images/'+ value +'.png',
              ),
              new Text(value)
            ],
          ),
        ));
      }).toList(),
    );
  }

  Widget _buildPhrase() {
    return TextFormField(
      initialValue: widget.user.phrase,
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Description'),
      maxLength: 140,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Desciprion is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _phrase = value;
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
              _buildPhrase(),
              _buildImage(),
              SizedBox(height: 15.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _updateUser();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateUser() {
    userService.updateUser(widget.user.uid, _name, _phrase, _image);
    Navigator.pop(context);
  }
}