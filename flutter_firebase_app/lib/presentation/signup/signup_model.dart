import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/util/constant.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUp() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください。');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください。');
    }
    final FirebaseUser user =
        (await _firebaseAuth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
            .user;
    final email = user.email;
    Firestore.instance.collection('users').add(
      {
        'user': email,
        'createdAt': Timestamp.now(),
      },
    );

    final uid = user.uid;
    Constant.uid = uid;
  }
}
