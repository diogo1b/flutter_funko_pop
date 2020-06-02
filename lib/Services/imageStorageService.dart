import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


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

  Future<void> readText(_image) async {

    /*
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(_image);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    */

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
    final BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    final List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);

    /*
    for(TextBlock block in readText.blocks) {
        for(TextLine line in block.lines) {
          for(TextElement word in line.elements) {
            print(word.text);
          }
        }
    }
    */

    for (Barcode barcode in barcodes) {
      print(barcode.rawValue);
    }
  }
}