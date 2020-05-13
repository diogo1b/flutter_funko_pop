import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/Services/imageStorageService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _number;
  String _upc;
  String _sticker;
  String _category;
  String _brand;
  String _image = "";

  final FunkoService funkoService = FunkoService();
  final CloudStorageService cloudStorageService = CloudStorageService();
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

  Widget _buildNumber() {
    return TextFormField(
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

  Widget _buildImage() {
    return new GestureDetector(
      onTap: ()=> _selectImage(),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child:
          _image == ""?
            Text('Tap to add an image',
            style: TextStyle(color: Colors.grey[400]))
          : Image.network(_image)
        ),
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
              _buildImage(),
              SizedBox(height: 15.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Add Funko',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  _saveFunko();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveFunko() {
    funkoService.createFunko(_name, _number, _upc, _sticker, _category, _brand, _image);
    Fluttertoast.showToast(
        msg: "You hace created a new Funko!!!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(context);
  }

  _selectImage() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    var _image_aux = await cloudStorageService.uploadImage(imageUpload: file, title: "funko");
    setState(() {
      _image = _image_aux;
    });
  }
}