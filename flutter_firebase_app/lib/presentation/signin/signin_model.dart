import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/util/constant.dart';

class SignInModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください。');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください。');
    }

    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );

    final uid = result.user.uid;
    Constant.uid = uid;
  }
}
