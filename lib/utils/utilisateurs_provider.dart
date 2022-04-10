import 'package:flutter/material.dart';

import '../screens/screens.dart';

class UtilisateursProvider with ChangeNotifier {
  List<Widget> quee = [const Body()];
  String searchKey = '';
  void changeSearchKey(String value){
    searchKey = value;
    notifyListeners();
  }
  void push(Widget widget){
    quee.add(widget);
    notifyListeners();
  }
  void pop(){
    quee.removeLast();
    searchKey = '';
    notifyListeners();
  }

}