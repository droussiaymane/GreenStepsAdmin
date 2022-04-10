import 'package:flutter/material.dart';
import '../screens/screens.dart';


class HistoriqueProvider with ChangeNotifier {
  List<Widget> quee = [const CompetitionHistorque()];
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