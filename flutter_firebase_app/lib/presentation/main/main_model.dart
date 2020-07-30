import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  var kazukiText = 'kazukiのprovider勉強';

  void changeKazukiText() {
    kazukiText = 'kazukiはproviderを身に着けた';
    notifyListeners();
  }
}
