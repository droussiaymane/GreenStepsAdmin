import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';

//1

class TitleHelper extends StatelessWidget {
  const TitleHelper(
    this.text, {
    Key? key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Text(text, style: kutilisateur),
    );
  }
}