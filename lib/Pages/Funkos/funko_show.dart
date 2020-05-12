import 'package:flutter/material.dart';
import 'package:flutterfunkopop/Pages/Funko_Lists/funko_list_add.dart';
import 'package:flutterfunkopop/Services/funkoService.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FunkoShowPage extends StatefulWidget {
  FunkoShowPage(this.funko);
  final Funko funko;

  @override
  State<StatefulWidget> createState() {
    return FunkoShowPageState();
  }
}

class FunkoShowPageState extends State<FunkoShowPage> {

  final FunkoService funkoService = FunkoService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Funko funko = Funko("id","name", "999", "upc", "sticker", "this.category", "this.brand");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _AddToListButton(widget.funko.id),
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Funkollector'),
          backgroundColor: Colors.deepPurpleAccent
      ),
      body: new Container(
        margin: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurpleAccent, width: 2.0)
        ),
        padding: const EdgeInsets.all(18.0),
        child: new Column(
          children: <Widget>[
            _showMainData(),
            _showLogo(),
            _showNumber(),
            _showPhrase(),
          ],
        ),
      )
    );
  }

  Widget _showNumber() {
    return new Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        shape: BoxShape.circle,
        // You can use like this way or like the below line
        //borderRadius: new BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              widget.funko.number ,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          )
        ],
      ),
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
                  widget.funko.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
              Text(
                'UPC : ' + widget.funko.upc,
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16
                ),
              ),
            ],
          ),
        ),
        /*3*/
        Text(
          widget.funko.sticker,
          style: TextStyle(
              fontSize: 13
          ),
        ),
      ],
    );
  }

  Widget _showLogo() {
    return new Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 120.0,
          child: Image.asset(
            'assets/images/'+'stan'+'.png',
          ),
        ),
      ),
    );
  }

  Widget _showPhrase() {
    return new Container(
      // Brand
      // Category
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.funko.brand,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.linear_scale, color: Colors.deepPurpleAccent),
                Text(widget.funko.category, style: TextStyle(color: Colors.black)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _AddToListButton(String id) {
    return new FloatingActionButton(
      onPressed: (){
        Navigator.of(context)
            .push(MaterialPageRoute(
          builder: (BuildContext context) => FunkoListAdd(id),
        ));
      },
      tooltip: 'Add_Funko_To_List',
      backgroundColor: Colors.deepPurpleAccent,
      child: new Icon(Icons.playlist_add),
    );
  }
}