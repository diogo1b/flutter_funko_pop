import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfunkopop/models/UserList.dart';
import 'package:flutterfunkopop/models/funko.dart';

abstract class _UserService {
  Future<void> createUser(String key, String email, String name, String role, String image, String phrase);
  
  Future<void> updateUser(String key, String name, String phrase, String image);

  Future<void> createFunkoList(String name, String description);

  Future<List>getUserLists();

  Future<List>getFunkosFromList(String id);

  Future<void>addToList(Funko funko, String list_id);

  Future<void>deleteList(String list_id);

  Future<void>removeFromList(String funko_id, String list_id);
}

class UserService implements _UserService {

  final Firestore db = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Future<void> createUser(String key, String email, String name, String role, String image, String phrase) async {
    await db.collection('Users').document(key).setData({'email' : email, 'name' : name, 'role' : role, 'image' : image, 'phrase' : phrase, 'created_at' : Timestamp.now()});
    return null;
  }
  
  @override
  Future<void> updateUser(String key, String name, String phrase, String image) async {
    await db.collection('Users').document(key).updateData({'name' : name , 'phrase' : phrase, 'image' : image});
    return null;
  }

  @override
  Future<void> createFunkoList(String name, String description) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    db.collection('Users').document(user.uid.toString()).collection('Lists').add({'name' : name, 'description' : description});
    return null;
  }

  Future<List>getUserLists() async {

    FirebaseUser user = await _firebaseAuth.currentUser();
    QuerySnapshot querySnapshot = await db.collection('Users').document(user.uid.toString()).collection('Lists').getDocuments();

    List<UserList> userLists = [];

    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      var list = UserList(a.documentID, a['name'], a['description']);
      userLists.add(list);
    }
    return userLists;
  }

  Future<List>getFunkosFromList(String id) async {

    List<Funko> funkoList = [];

    FirebaseUser user = await _firebaseAuth.currentUser();
    QuerySnapshot querySnapshot = await db.collection('Users').document(user.uid.toString()).collection('Lists').document(id).collection('Funkos').getDocuments();

    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      var funko = Funko(a.documentID, a['name'], a['number'], a['upc'], a['sticker'], a['category'], a['brand'], a['image']);
      funkoList.add(funko);
    }
    return funkoList;
  }

  @override
  Future<void>addToList(Funko funko, String list_id) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    db.collection('Users').document(user.uid.toString()).collection('Lists').document(list_id).collection('Funkos').add({'name' : funko.name, 'number' : funko.number, 'upc' : funko.upc, 'sticker' : funko.sticker, 'category' : funko.category, 'brand' : funko.brand, 'image' : funko.image});
  }

  @override
  Future<void>deleteList(String list_id) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    db.collection('Users').document(user.uid.toString()).collection('Lists').document(list_id).delete();
  }

  @override
  Future<void>removeFromList(String funko_id, String list_id) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    db.collection('Users').document(user.uid.toString()).collection('Lists').document(list_id).collection('Funkos').document(funko_id).delete();
  }
}