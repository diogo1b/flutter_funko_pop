import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfunkopop/Services/userService.dart';
import 'package:flutterfunkopop/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> changeEmail(String email);

  Future<void> changePassword(String password);

  Future<void> deleteUser();

  Future<void> sendPasswordResetMail(String email);

  Future<String> getCurrentRole();

  Future<User> getCurrentUserComplete();
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserService userService = UserService();
  final Firestore db = Firestore.instance;

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password)).user;
    userService.createUser(user.uid, email, "User", "user", "stan", "Im new !!!");
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> changeEmail(String email) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updateEmail(email).then((_) {
      print("Succesfull changed email");
    }).catchError((error) {
      print("email can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> changePassword(String password) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> deleteUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

  Future<String> getCurrentRole() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    var role_aux = await db.collection('Users').document(user.uid.toString()).get();
    String role = role_aux.data['role'].toString();
    return role;
  }

  Future<User> getCurrentUserComplete() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    var item_aux = await db.collection('Users').document(user.uid.toString()).get();
    var date_aux = new DateTime.fromMicrosecondsSinceEpoch(item_aux['created_at'].seconds);
    var date = date_aux.toString().split(" ");
    User item = User(user.uid.toString(), item_aux['name'].toString(), item_aux['image'].toString(), item_aux['phrase'].toString(), item_aux['role'].toString(), date[0]);
    return item;
  }

}