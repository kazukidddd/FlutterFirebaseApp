import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(DocumentSnapshot doc) {
    documentID = doc.documentID;
    title = doc['title'];
    createdAt = doc['createdAt'];
    uid = doc['uid'];
    imageURL = doc['imageURL'];
  }

  String documentID;
  String title;
  String uid;
  Timestamp createdAt;
  String imageURL;
}
