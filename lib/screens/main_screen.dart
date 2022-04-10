import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/widgets/widgets.dart';
import 'package:web_app/screens/screens.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BorderSide borderSide =
      const BorderSide(color: kPrimaryColor, width: 2);
  String section = "Utilisateurs";
  Widget sectionWidget = const Utilisateurs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: borderSide),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    'assets/um6p.png',
                    scale: 10,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    children: [
                      CustomButtonWidget(
                        value: "Utilisateurs",
                        groupValue: section,
                        onTap: () {
                          setState(() {
                            section = "Utilisateurs";
                            sectionWidget = const Utilisateurs();
                          });
                        },
                        child: const Text(
                          "Utilisateurs",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      CustomButtonWidget(
                        value: "Compétition",
                        onTap: () {
                          setState(() {
                            section = "Compétition";
                            sectionWidget =  const Competition();
                          });
                        },
                        groupValue: section,
                        child: const Text(
                          "Compétition",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      CustomButtonWidget(
                        value: "Historique",
                        onTap: () {
                          setState(() {
                            section = "Historique";
                            sectionWidget = const Historique();
                          });
                        },
                        groupValue: section,
                        child: const Text(
                          "Historique",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          Expanded(
            flex: 5,
            child: sectionWidget,
          )
        ],
      ),
    );
  }
}



