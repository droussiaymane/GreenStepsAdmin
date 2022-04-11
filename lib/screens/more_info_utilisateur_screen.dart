import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/constants.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:web_app/utils/utils.dart';
import 'package:web_app/widgets/widgets.dart';
import 'package:web_app/screens/screens.dart';

class InfoUserBody extends StatefulWidget {
  final UserModel userModel;
  const InfoUserBody(
    this.userModel, {
    Key? key,
  }) : super(key: key);

  @override
  State<InfoUserBody> createState() => _InfoUserBodyState();
}

class _InfoUserBodyState extends State<InfoUserBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Expanded(
          child: Row(
            children: [
              GeneralInfos(widget.userModel),
              Expanded(child: Graphs(widget.userModel)),
            ],
          ),
        )
      ],
    );
  }
}

class GeneralInfos extends StatelessWidget {
  const GeneralInfos(this.userModel, {Key? key}) : super(key: key);

  final BorderSide borderSide =
      const BorderSide(color: kPrimaryColor, width: 2);
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    final UtilisateursProvider utilisateursProvider =
        Provider.of<UtilisateursProvider>(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(right: borderSide),
            ),
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nom et Prénom",
                      style: kTableCulumn,
                    ),
                  ),
                  Text(
                    (userModel.prenom ?? '__') + ' ' + (userModel.nom ?? '__'),
                    style: kTableRow,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Département",
                      style: kTableCulumn,
                    ),
                  ),
                  Text(
                    userModel.departement ?? "__",
                    style: kTableRow,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Totale",
                      style: kTableCulumn,
                    ),
                  ),
                  Text(
                    userModel.nombrePasTotal.toString(),
                    style: kTableRow,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Taille",
                      style: kTableCulumn,
                    ),
                  ),
                  Text(
                    userModel.taille!.toStringAsFixed(2),
                    style: kTableRow,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Poids",
                      style: kTableCulumn,
                    ),
                  ),
                  Text(
                    userModel.poids!.toStringAsFixed(2),
                    style: kTableRow,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Date de naissance",
                      style: kTableCulumn,
                    ),
                  ),
                  Text(
                    userModel.dateNaissance!,
                    style: kTableRow,
                  ),
                ],
              ),
            ),
          ),
        ),
       
        ElevatedButton(
          onPressed: () {
            utilisateursProvider.push(Contacter([HelperContacter((userModel.prenom ?? '__') + ' ' + (userModel.nom ?? '__'), userModel)],null));
          },
          child: const Text("Contacter"),
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}

class HelperContacter{
  final String fullName;
  final UserModel user;

  HelperContacter(this.fullName, this.user);
}


class Graphs extends StatefulWidget {
  const Graphs(this.userModel, {Key? key}) : super(key: key);
  final UserModel userModel;

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  int size(String timeStamp) {
    switch (timeStamp) {
      case "year":
        return 10;
      default:
        return 5;
    }
  }

  String timeStamp = 'week';

  num factor = 1;
  bool allData = false;
  List<String> months = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];

  @override
  Widget build(BuildContext context) {
    double stepsToDistanceFactor = 0.414 * widget.userModel.taille!;
    double stepsToCaloriesFactor = 0.04 *
        (widget.userModel.poids! /
            (pow(widget.userModel.taille!, 2) * pow(10, -4)));

    return Column(
      children: [
        //the complete data
        if (allData)
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  List<dynamic> pasHistorique =
                      widget.userModel.pasHistorique ?? [];
                  String jour;
                  int pas;
                  List<DataRow> rows = pasHistorique.map((e) {
                    jour = e.keys.first;
                    pas = e.values.first;
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          TableHelper(
                            jour,
                            width: 100,
                            style: kTableRow,
                          ),
                        ),
                        DataCell(TableHelper(
                          pas.toString(),
                          width: 100,
                          style: kTableRow,
                        )),
                        DataCell(
                          TableHelper(
                            (pas * stepsToDistanceFactor).toStringAsFixed(2) +
                                "km",
                            width: 120,
                            style: kTableRow,
                          ),
                        ),
                        DataCell(
                          TableHelper(
                            (pas * stepsToCaloriesFactor).toStringAsFixed(2),
                            width: 100,
                            style: kTableRow,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: TableHelper(
                          'Jour',
                          width: 100,
                          style: kTableCulumn,
                        ),
                      ),
                      DataColumn(
                        label: TableHelper(
                          'Pas',
                          width: 100,
                          style: kTableCulumn,
                        ),
                      ),
                      DataColumn(
                        label: TableHelper(
                          'Distance',
                          width: 120,
                          style: kTableCulumn,
                        ),
                      ),
                      DataColumn(
                        label: TableHelper(
                          'Calories',
                          width: 100,
                          style: kTableCulumn,
                        ),
                      ),
                    ],
                    rows: rows,
                  );
                },
              ),
            ),
          ),
        //the week/year/month choser
        if (!allData)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  value: "week",
                  groupValue: timeStamp,
                  onTap: () {
                    timeStamp = "week";
                    setState(() {});
                  },
                  child: const Text(
                    "7 jours",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                CustomButton(
                  value: "month",
                  onTap: () {
                    timeStamp = "month";
                    setState(() {});
                  },
                  groupValue: timeStamp,
                  child: const Text(
                    "1 Mois",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                CustomButton(
                  value: "year",
                  onTap: () {
                    timeStamp = "year";
                    setState(() {});
                  },
                  groupValue: timeStamp,
                  child: const Text(
                    "1 An",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        //the graph
        if (!allData)
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Builder(
                builder: (context) {
                  Map<DateTime, int> saver(Map<String, dynamic> map) {
                    return map.map(
                        (key, value) => MapEntry(DateTime.parse(key), value));
                  }

                  int getDayiPas(Map<DateTime, int> dayi) {
                    return dayi.values.first;
                  }

                  int getDayk(Map<DateTime, int> dayi) {
                    return dayi.keys.first.day;
                  }

                  List measure = [];
                  List<String> domain = [];

                  List<dynamic> pasHistorique =
                      widget.userModel.pasHistorique ?? [];
                  if (pasHistorique.isEmpty) {
                    print("there is a big big probleme with the code");
                  } else {
                    switch (timeStamp) {
                      case "week":
                        {
                          Map<DateTime, int> aujourdui =
                              saver(pasHistorique[0]);
                          DateTime aujourduiDate = aujourdui.keys.first;
                          int aujourduiDay = aujourduiDate.day;

                          DateTime currentDate = aujourduiDate;
                          String month;
                          int currentDay;

                          measure = List.filled(
                            7,
                            0,
                          );
                          measure[6] = getDayiPas(aujourdui) * factor;
                          domain = ["Aujourd'hui"];

                          int k = 1;
                          int dayk;

                          for (var i = 1; i < 7; i++) {
                            currentDate =
                                currentDate.add(const Duration(days: -1));
                            currentDay = currentDate.day;
                            month = months[currentDate.month - 1];
                            domain = [
                                  "${month.substring(0, min(3, month.length))}/$currentDay"
                                ] +
                                domain;

                            try {
                              dayk = getDayk(saver(pasHistorique[k]));
                              if (dayk == aujourduiDay - i) {
                                measure[6 - i] =
                                    getDayiPas(saver(pasHistorique[k])) *
                                        factor;
                                k++;
                              } else {
                                measure[6 - i] = 0;
                              }
                            } on RangeError {
                              measure[6 - i] = 0;
                            }
                          }
                        }
                        break;

                      case "month":
                        {
                          Map<DateTime, int> aujourdui =
                              saver(pasHistorique[0]);
                          DateTime aujourduiDate = aujourdui.keys.first;
                          int aujourduiDay = aujourduiDate.day;
                          String month = months[aujourduiDate.month - 1];

                          measure = List.filled(
                            aujourduiDay,
                            0,
                          );
                          measure[aujourduiDay - 1] =
                              getDayiPas(aujourdui) * factor;
                          domain = ["Aujourd'hui"];

                          int k = 1;
                          int dayk;

                          for (var i = 1; i < aujourduiDay; i++) {
                            domain = [
                                  "${month.substring(0, min(3, month.length))}/${aujourduiDay - i}"
                                ] +
                                domain;

                            try {
                              dayk = getDayk(saver(pasHistorique[k]));
                              if (dayk == aujourduiDay - i) {
                                measure[aujourduiDay - 1 - i] =
                                    getDayiPas(saver(pasHistorique[k])) *
                                        factor;
                                k++;
                              } else {
                                measure[aujourduiDay - 1 - i] = 0;
                              }
                            } on RangeError {
                              measure[aujourduiDay - 1 - i] = 0;
                            }
                          }
                        }
                        break;
                      case "year":
                        {
                          int getMonth(Map<DateTime, int> dayi) {
                            return dayi.keys.first.month;
                          }

                          Map<DateTime, int> aujourdui =
                              saver(pasHistorique[0]);
                          int activeMonth = getMonth(aujourdui);
                          for (var i = 0; i < 12; i++) {
                            domain =
                                [months[(activeMonth - 1 - i) % 12]] + domain;
                          }

                          measure = List.filled(
                            12,
                            0,
                          );

                          int j = 0;
                          for (var i = 0; i < 12; i++) {
                            try {
                              while (getMonth(saver(pasHistorique[j])) ==
                                  activeMonth) {
                                measure[11 - i] +=
                                    getDayiPas(saver(pasHistorique[j])) *
                                        factor;
                                j++;
                              }
                              activeMonth = getMonth(saver(pasHistorique[j]));
                            } on RangeError {
                              break;
                            }
                          }
                        }
                        break;
                    }
                  }
                  return charts.BarChart(
                    [
                      charts.Series(
                        id: 'graph',
                        domainFn: (value, _) => domain[_!],
                        measureFn: (value, _) => measure[_!], //mesure(value),
                        data: measure,
                        fillColorFn: (value, _) {
                          return charts.ColorUtil.fromDartColor(kPrimaryColor);
                        },
                      )
                    ],
                    animate: true,
                    vertical: true,
                    behaviors: [
                      charts.SlidingViewport(),
                      charts.PanAndZoomBehavior(),
                    ],
                    domainAxis: charts.OrdinalAxisSpec(
                      viewport: charts.OrdinalViewport(
                          "Aujourd'hui", size(timeStamp)),
                    ),
                  );
                },
              ),
            ),
          ),
        const SizedBox(height: 16,),
        ElevatedButton(
            onPressed: () {
              setState(() {
                allData = !allData;
              });
            },
            child: Text(
                allData ? "historique d'utilisation" : "toutes les données")),
        const Spacer(
          flex: 2,
        ),
        if (!allData)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  const Text(
                    "Calories",
                    style: kRadioButtonStyle,
                  ),
                  Radio<num>(
                    activeColor: kPrimaryColor,
                    groupValue: factor,
                    value: stepsToCaloriesFactor,
                    onChanged: (value) {
                      setState(
                        () {
                          factor = value!;
                        },
                      );
                    },
                  ),
                ]),
                Row(
                  children: [
                    const Text(
                      "Pas",
                      style: kRadioButtonStyle,
                    ),
                    Radio<num>(
                      activeColor: kPrimaryColor,
                      groupValue: factor,
                      value: 1,
                      onChanged: (value) {
                        setState(
                          () {
                            factor = value!;
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(children: [
                  const Text(
                    "Distance",
                    style: kRadioButtonStyle,
                  ),
                  Radio<num>(
                    activeColor: kPrimaryColor,
                    groupValue: factor,
                    value: stepsToDistanceFactor,
                    onChanged: (value) {
                      setState(
                        () {
                          factor = value!;
                        },
                      );
                    },
                  ),
                ]),
              ],
            ),
          ),
      ],
    );
  }
}

class CustomButton extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final String value;
  final String groupValue;
  const CustomButton(
      {Key? key,
      required this.child,
      this.onTap,
      required this.value,
      required this.groupValue})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: (widget.value == widget.groupValue)
              ? const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                ]
              : null,
          color: (widget.value == widget.groupValue)
              ? kPrimaryColor
              : kLightPrimaryColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: widget.child,
      ),
    );
  }
}
