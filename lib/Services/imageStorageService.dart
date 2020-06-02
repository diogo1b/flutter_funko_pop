import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfunkopop/models/funko.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudStorageService {
  Future<String> uploadImage({
    @required File imageUpload,
    @required String title,
  }) async {
    var imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageUpload);
    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if(uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return url.toString();
    }
    return null;
  }

  Future<Funko> readText(_image) async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
    final BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    final List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);

    var upc = barcodes[0].rawValue;

    print(upc);

    String url = "https://api.barcodespider.com/v1/lookup?upc=889698430258" + upc.toString();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
    await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);

    print(responseJson);

    if(responseJson['item_response']["code"] == 200) {

      var item = responseJson['item_attributes'];

      String name = item["title"];
      var index = name.indexOf(': ');
      name = name.substring(1 , index);
      print(name);

      Funko funko = Funko("", name, "", item["upc"], "", item["category"], item["brand"] , "");
      return funko;
      
    } else {
      return null;
    }
  }
}