import 'package:flutter/material.dart';

//1


class TableHelper extends StatelessWidget {
  const TableHelper(this.text,
      {Key? key, required this.width, required this.style})
      : super(key: key);
  final double width;
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        child: Text(
          text,
          style: style,
        ));
  }
}