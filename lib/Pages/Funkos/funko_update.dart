import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FunkoUpdatePage extends StatefulWidget {
  FunkoUpdatePage(this.funko);
  final Funko funko;

  @override
  State<StatefulWidget> createState() {
    return FunkoUpdatePageState();
  }
}

class FunkoUpdatePageState extends State<FunkoUpdatePage> {
  String _name;
  String _number;
  String _upc;
  String _sticker;
  String _category;
  String _brand;
  String _image = "";

  final FunkoService funkoService = FunkoService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: widget.funko.name,
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

  Widget _buildNumber() {
    return TextFormField(
      initialValue: widget.funko.number,
      decoration: InputDecoration(labelText: 'Number'),
      keyboardType: TextInputType.number,
      maxLength: 3,
      validator: (String value) {
        int number = int.tryParse(value);
        if (number == null || number <= 0) {
          return 'Number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _number = value;
      },
    );
  }

  Widget _buildUpc() {
    return TextFormField(
      initialValue: widget.funko.upc,
      decoration: InputDecoration(labelText: 'UPC'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'UPC is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _upc = value;
      },
    );
  }

  Widget _buildSticker() {
    return TextFormField(
      initialValue: widget.funko.sticker,
      decoration: InputDecoration(labelText: 'Sticker'),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Sticker is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _sticker = value;
      },
    );
  }

  Widget _buildCategory() {
    return TextFormField(
      initialValue: widget.funko.category,
      decoration: InputDecoration(labelText: 'Category'),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Category is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _category = value;
      },
    );
  }

  Widget _buildBrand() {
    return TextFormField(
      initialValue: widget.funko.brand,
      decoration: InputDecoration(labelText: 'Brand'),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Brand is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _brand = value;
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
              _buildNumber(),
              _buildUpc(),
              _buildSticker(),
              _buildCategory(),
              _buildBrand(),
              SizedBox(height: 15.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Update Funko',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _updateFunko();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateFunko() {
    print(widget.funko.id);
    print(_name);
    funkoService.updateFunko(widget.funko.id, _name, _number, _upc, _sticker, _category, _brand, _image);
    Fluttertoast.showToast(
        msg: "You hace updated a Funko!!!!!",
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