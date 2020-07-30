import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/domain/Book.dart';
import 'package:flutter_firebase_app/presentation/add_book/add_book_page.dart';
import 'package:flutter_firebase_app/presentation/webview_page/webview_page.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '本一覧',
          ),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map(
                  (book) => Container(
//                    color: Colors.amber,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.network(book.imageURL != null
                          ? book.imageURL
                          : 'https://jp.ubergizmo.com/wp-content/uploads/2020/05/steve-jobs-photo-first-iPhone-15-sized.jpg'),
                      title: Text(book.title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          // todo

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBookPage(
                                book: book,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                          model.fetchBooks();
                        },
                      ),
                      onTap: () async {
                        try {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(),
                            ),
                          );
                        } catch (e) {
                          _showDialog(context, e.toString());
                        }
                      },
                      onLongPress: () async {
                        // todo 削除機能
                        await showDialog<void>(
                          context: context,
//                        barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('${book.title}を削除しますか？'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    // todo 削除機能
                                    await deleteBook(model, book, context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              // todo
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
            },
          );
        }),
      ),
    );
  }

  Future deleteBook(
      BookListModel model, Book book, BuildContext context) async {
    try {
      await model.deleteBook(book);
      await model.fetchBooks();
    } catch (e) {
      await _showDialog(context, e.toString());
    }
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
              },
            ),
          ],
        );
      },
    );
  }
}
