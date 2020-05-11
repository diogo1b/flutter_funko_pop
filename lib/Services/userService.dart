import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'authentification.dart';

abstract class _UserService {
  Future<void> createUser(String key, String email, String name, String role, String image);
}

class UserService implements _UserService {

  final Firestore db = Firestore.instance;

  @override
  Future<void> createUser(String key, String email, String name, String role, String image) async {
    await db.collection('Users').document(key).setData({'email' : email, 'name' : name, 'role' : role, 'image' : image});
    return null;
  }

  @override
  Future<void> Hola() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
    return null;
  }
}