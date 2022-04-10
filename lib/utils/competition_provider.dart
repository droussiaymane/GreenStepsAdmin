import 'package:flutter/material.dart';



class CompetitionProvider with ChangeNotifier {
  
  String searchKey = '';
  void changeSearchKey(String value){
    searchKey = value;
    notifyListeners();
  }
  

}