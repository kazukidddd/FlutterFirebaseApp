import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/presentation/book_list/book_list_page.dart';
import 'package:flutter_firebase_app/presentation/signup/signup_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'サインアップ',
          ),
        ),
        body: Consumer<SignUpModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: mailController,
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                    ),
                    onChanged: (text) {
                      model.mail = text;
                    },
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                    obscureText: true,
                    onChanged: (text) {
                      model.password = text;
                    },
                  ),
                  RaisedButton(
                    child: Text('登録する'),
                    onPressed: () async {
                      // todo サインアップ
                      try {
                        await model.signUp();
                        _showDialog(context, '成功しました');
                      } catch (e) {
                        _showDialog(context, e.toString());
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ignore: missing_return
  Future _showDialog(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
//                        barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
