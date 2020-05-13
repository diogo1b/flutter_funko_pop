import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class _FunkoService {
  Future<void> createFunko(String name, String number, String upc, String sticker, String category, String brand, String image);

  Future<void>updateFunko(String id, String name, String number, String upc, String sticker, String category, String brand, String image);
}

class FunkoService implements _FunkoService {

  final Firestore db = Firestore.instance;

  @override
  Future<void> createFunko(String name, String number, String upc, String sticker, String category, String brand, String image) async {
    await db.collection('Funkos').add({'name' : name, 'number' : number, 'upc' : upc, 'sticker' : sticker, 'category' : category, 'brand' : brand, 'image' : image});
    return null;
  }

  Future<List>getFunkos() async {
    List<Funko> funkoList = [];

    QuerySnapshot querySnapshot = await db.collection('Funkos').getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      var funko = Funko(a.documentID, a['name'], a['number'], a['upc'], a['sticker'], a['category'], a['brand'], a['image']);
      funkoList.add(funko);
    }
    return funkoList;
  }

  @override
  Future<void>updateFunko(String id, String name, String number, String upc, String sticker, String category, String brand, String image) async {
    await db.collection('Funkos').document(id).updateData({'name' : name, 'number' : number, 'upc' : upc, 'sticker' : sticker, 'category' : category, 'brand' : brand, 'image' : image});
  }
}