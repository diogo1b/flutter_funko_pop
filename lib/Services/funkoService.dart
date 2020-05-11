import 'package:cloud_firestore/cloud_firestore.dart';

abstract class _FunkoService {
  Future<void>  createFunko(String name, String number, String upc, String sticker, String category, String brand);
}

class FunkoService implements _FunkoService {

  final Firestore db = Firestore.instance;

  @override
  Future<void> createFunko(String name, String number, String upc, String sticker, String category, String brand) async {
    await db.collection('Funkos').add({'name' : name, 'number' : number, 'upc' : upc, 'sticker' : sticker, 'category' : category, 'brand' : brand});
    return null;
  }
}