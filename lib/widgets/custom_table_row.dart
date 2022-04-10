import 'package:provider/provider.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/utils/utils.dart';
import 'package:web_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';

//2


class CustomTableRow extends StatefulWidget {
  CustomTableRow(
    this.rang,
    this.fullName,
    this.departement,
    this.total, 
    this.sexe,
    this.user,{
    Key? key, 
  }) : super(key: key);
  final String sexe;
  String rang;
  final String fullName;
  final String? departement;
  final String total;
  final UserModel user;

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> {
  
  @override
  Widget build(BuildContext context) {
    final UtilisateursProvider utilisateursProvider = Provider.of<UtilisateursProvider>(context);
    return InkWell(
      onTap: () {
        utilisateursProvider.push(InfoUserBody(widget.user));
      },
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          border: Border(bottom: borderSide),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TableHelper(
              widget.rang,
              width: 50,
              style: kTableRow,
            ),
            TableHelper(
              widget.fullName,
              width: 150,
              style: kTableRow,
            ),
            TableHelper(
              widget.departement ?? '__',
              width: 300,
              style: kTableRow,
            ),
            TableHelper(
              widget.total,
              width: 50,
              style: kTableRow,
            ),
          ],
        ),
      ),
    );
  }
}

class CcustomTableRow extends StatefulWidget {
  CcustomTableRow(
    this.rang,
    this.fullName,
    this.departement,
    this.total, 
    this.sexe,
    this.user,{
    Key? key, 
  }) : super(key: key);
  final String sexe;
  String rang;
  final String fullName;
  final String? departement;
  final String total;
  final UserModel user;

  @override
  State<CcustomTableRow> createState() => _CcustomTableRowState();
}

class _CcustomTableRowState extends State<CcustomTableRow> {
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("clicked");
      },
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          border: Border(bottom: borderSide),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TableHelper(
              widget.rang,
              width: 50,
              style: kTableRow,
            ),
            TableHelper(
              widget.fullName,
              width: 150,
              style: kTableRow,
            ),
            TableHelper(
              widget.departement ?? '__',
              width: 300,
              style: kTableRow,
            ),
            TableHelper(
              widget.total,
              width: 50,
              style: kTableRow,
            ),
          ],
        ),
      ),
    );
  }
}

