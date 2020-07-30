import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/presentation/book_list/book_list_page.dart';
import 'package:flutter_firebase_app/presentation/signin/signin_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'サインイン',
          ),
        ),
        body: Consumer<SignInModel>(
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
                    child: Text('ログイン'),
                    onPressed: () async {
                      // todo ログイン
                      try {
                        await model.signIn();
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
              onPressed: () async {
                Navigator.of(context).pop(true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListPage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
