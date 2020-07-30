import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/domain/Book.dart';
import 'package:flutter_firebase_app/util/constant.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください。');
    }
    final imageURL = await _uploadImage();
    Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'createdAt': Timestamp.now(),
        'uid': Constant.uid,
        'imageURL': imageURL,
      },
    );
  }

  Future updateBook(Book book) async {
    final imageURL = await _uploadImage();
    final document =
        Firestore.instance.collection('books').document(book.documentID);
    await document.updateData({
      'title': bookTitle,
      'createdAt': book.createdAt,
      'uid': Constant.uid,
      'imageURL': imageURL,
    });
  }

  Future<String> _uploadImage() async {
    final storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('books/$bookTitle')
        .putFile(imageFile)
        .onComplete;

    final String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
