import 'package:flutter/cupertino.dart';

class ColorChanger extends ChangeNotifier {
  bool showColor = false;
  void changeIt(newValue) {
    showColor = newValue;
    notifyListeners();
  }
}
