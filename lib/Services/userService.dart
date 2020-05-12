import 'package:cloud_firestore/cloud_firestore.dart';

abstract class _UserService {
  Future<void> createUser(String key, String email, String name, String role, String image, String phrase);
  
  Future<void> updateUser(String key, String name, String phrase, String image);

  Future<void> createFunkoList(String name, String description);
}

class UserService implements _UserService {

  final Firestore db = Firestore.instance;

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
    return null;
  }
}