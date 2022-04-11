import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_app/widgets/widgets.dart';
import 'package:web_app/constants.dart';
import 'package:provider/provider.dart';

class Competition extends StatefulWidget {
  const Competition({Key? key}) : super(key: key);

  @override
  State<Competition> createState() => _CompetitionState();
}

class _CompetitionState extends State<Competition> {
  @override
  Widget build(BuildContext context) {
    final CompetitionProvider competitionProvider =
        Provider.of<CompetitionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: SearchInputWidget(
            provider: competitionProvider,
          ),
        ),
      ),
      body: const CompetitionHome(),
    );
  }
}

class CompetitionHome extends StatefulWidget {
  const CompetitionHome({Key? key}) : super(key: key);

  @override
  State<CompetitionHome> createState() => _CompetitionHomeState();
}

class _CompetitionHomeState extends State<CompetitionHome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DataBase.getCompetitionsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var len = snapshot.data!.docs.length;
          if (len == 0) {
            return const CompetitionSpecification();
          }
          DateTime today = DateTime.now();
          var lastCompetitionEndDay =
              DateTime.parse(snapshot.data!.docs[0].get("date de fin"));
          
          if (today.compareTo(lastCompetitionEndDay) <= 0) {
            DocumentSnapshot activeCompetition = snapshot.data!.docs[0];
          
            return CompetitionDashBoard(activeCompetition.reference);
          }

          return const CompetitionSpecification();
        });
  }
}

class CompetitionDashBoard extends StatefulWidget {
  const CompetitionDashBoard(
    this.competition, {
    Key? key,
  }) : super(key: key);
  final DocumentReference competition;
  @override
  State<CompetitionDashBoard> createState() => _CompetitionDashBoardState();
}

class _CompetitionDashBoardState extends State<CompetitionDashBoard> {
  filterTES? filterTESactive = filterTES.tous;
  sex? sexActive;
  String? departement;
  String searchKey = '';
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final CompetitionProvider competitionProvider =
        Provider.of<CompetitionProvider>(context);
    searchKey = competitionProvider.searchKey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: widget.competition.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  CompetitionModel competitionModel =
                      CompetitionModel.fromSnapshot(snapshot.data!);
                  print("2");
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          competitionModel.name,
                          style: khead,
                        ),
                        Text(
                          "Nombre total de participants " +
                              competitionModel.nombreDeParticipants.toString(),
                          style: kbody,
                        )
                      ],
                    ),
                  );
                },
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const TitleHelper("Tous"),
                            Radio<filterTES>(
                              autofocus: true,
                              value: filterTES.tous,
                              groupValue: filterTESactive,
                              onChanged: (filterTES? value) {
                                setState(() {
                                  filterTESactive = value;
                                  departement = null;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              // width: 200,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: kPrimaryColor,
                                hint: const Text(
                                  "Etudiant",
                                  style: kutilisateur,
                                ),
                                value: departement,
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                style: kutilisateur,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                                elevation: 0,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    departement = newValue;
                                  });
                                },
                                items: departements
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Radio<filterTES>(
                              value: filterTES.etudiant,
                              groupValue: filterTESactive,
                              onChanged: (filterTES? value) {
                                setState(() {
                                  filterTESactive = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            TitleHelper("Staff"),
                            Radio<filterTES>(
                              value: filterTES.staff,
                              groupValue: filterTESactive,
                              onChanged: (filterTES? value) {
                                setState(() {
                                  filterTESactive = value;
                                  departement = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Male",
                              style: kTableCulumn,
                            ),
                            Radio<sex>(
                              toggleable: true,
                              value: sex.male,
                              groupValue: sexActive,
                              onChanged: (sex? value) {
                                setState(() {
                                  sexActive = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Female",
                              style: kTableCulumn,
                            ),
                            Radio<sex>(
                              toggleable: true,
                              value: sex.female,
                              groupValue: sexActive,
                              onChanged: (sex? value) {
                                setState(() {
                                  sexActive = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              border: Border(bottom: borderSide, top: borderSide),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                TableHelper(
                  'Range',
                  width: 50,
                  style: kTableCulumn,
                ),
                TableHelper(
                  'Nom et Prénom',
                  width: 150,
                  style: kTableCulumn,
                ),
                TableHelper(
                  'Département',
                  width: 300,
                  style: kTableCulumn,
                ),
                TableHelper(
                  'Total',
                  width: 50,
                  style: kTableCulumn,
                ),
              ],
            ),
          ),
          getUserList(),
        ],
      ),
    );
  }

  Widget getUserList() {
    return Expanded(
      child: StreamBuilder<DocumentSnapshot>(
        stream: widget.competition.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var len = snapshot.data!["nombre de participants"];
          if (len == 0) {
            return Column(
              children: const [
                SizedBox(height: 100),
                Center(
                  child: Text("Aucun utilisateur trouvé", style: kerror),
                )
              ],
            );
          }
          DateTime dateDeDebut =
              DateTime.parse(snapshot.data!.get("date de debut"));
          DateTime dateDeFin =
              DateTime.parse(snapshot.data!.get("date de fin"));
          bool isBetween(DateTime date) {
            return date.isAfter(dateDeDebut) && date.isBefore(dateDeFin) ||
                date == dateDeDebut ||
                date == dateDeFin;
          }

          Future<List<CcustomTableRow>> helperFuture() async {
            List<DocumentSnapshot> participants = (await snapshot
                    .data!.reference
                    .collection("participants")
                    .get())
                .docs;
            List<CcustomTableRow> customTableRow = [];
            for (var participant in participants) {
              DocumentSnapshot user = await participant["user"].get();

              var newPasHistorique = participant["pasHistorique"];
              int total = 0;
              for (var item in user["pasHistorique"]) {
                DateTime day = DateTime.parse(item.keys.first);
                int value = item.values.first;
                if (isBetween(day)) {
                  newPasHistorique[item.keys.first] = value;
                } else {
                  break;
                }
              }

              participant.reference.update({"pasHistorique": newPasHistorique});

              for (int item in participant["pasHistorique"].values) {
                total += item;
              }

              customTableRow.add(buildListItem(context, participant, total));
            }
            return customTableRow;
          }

          return FutureBuilder<List<CcustomTableRow>>(
            future: helperFuture(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<CcustomTableRow> customTableRow = snapshot.data!;
              customTableRow.sort((a, b) => b.total.compareTo(a.total));
              var map = customTableRow.asMap();
              map.forEach((key, value) {
                value.rang = (key+1).toString();
                value.participant.reference!.update({'rang': key+1});
              });
              customTableRow = map.values.toList();

              //here start the magic
              if (true) {
                if (searchKey != '') {
                  customTableRow = customTableRow
                      .where((s) => s.fullName
                          .toLowerCase()
                          .contains(searchKey.toLowerCase()))
                      .toList();
                } else if (filterTESactive == filterTES.staff) {
                  customTableRow = customTableRow
                      .where((s) => s.departement == null)
                      .toList();
                } else if (filterTESactive == filterTES.etudiant) {
                  customTableRow = customTableRow.where((s) {
                    if (departement == null) {
                      return s.departement != null;
                    }
                    return s.departement != null &&
                        s.departement == departement;
                  }).toList();
                }
                if (searchKey != '') {
                } else if (sexActive == sex.male) {
                  customTableRow =
                      customTableRow.where((s) => s.sexe == "male").toList();
                } else if (sexActive == sex.female) {
                  customTableRow =
                      customTableRow.where((s) => s.sexe == "femelle").toList();
                }
              }

              //the end of magic
              return ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  children: customTableRow);
            },
          );
        },
      ),
    );
  }

  CcustomTableRow buildListItem(
      BuildContext context, DocumentSnapshot snapshot, int total) {
    final participant = Participant.fromSnapshot(snapshot);
    return CcustomTableRow(
      "0",
      (participant.prenom ?? '__') + ' ' + (participant.nom ?? '__'),
      participant.departement,
      total.toString(),
      participant.sexe,
      participant,
    );
  }
}





class CompetitionSpecification extends StatefulWidget {
  const CompetitionSpecification({Key? key}) : super(key: key);

  @override
  State<CompetitionSpecification> createState() =>
      _CompetitionSpecificationState();
}

class _CompetitionSpecificationState extends State<CompetitionSpecification> {
  String? name;

  String? discreption;

  DateTime dateDeDebut = DateTime.now();

  DateTime dateDeFin = DateTime.now().add(const Duration(days: 7));

  bool editing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _discreptionController = TextEditingController();

  final FCMNotificationService _fcmNotificationService =
      FCMNotificationService();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: editing,
            replacement: const Text(
              "il n'y a pas de compétition active",
              style: kerror,
            ),
            child: Column(
              children: [
                TextInputWidget(
                  textController: _nameController,
                  hint: "le nom de la competition",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(),
                  ),
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              dateDeDebut.toString().substring(0, 10),
                              style: kbody,
                            ),
                          ),
                        ),
                        IconButton(
                          splashRadius: 25,
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000));
                            if (picked != null) {
                              setState(() {
                                dateDeDebut = picked;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(),
                  ),
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(
                                    dateDeFin.toString().substring(0, 10)))),
                        IconButton(
                          splashRadius: 25,
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000));
                            if (picked != null) {
                              setState(() {
                                dateDeFin = picked;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInputWidget(
                  textController: _discreptionController,
                  hint: "la description de la competition",
                  isArea: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (editing) {
                  if (_formKey.currentState!.validate()) {
                    name = _nameController.text;
                    discreption = _discreptionController.text;
                    CompetitionModel competitionModel = CompetitionModel(
                        name!,
                        discreption!,
                        dateDeDebut.toString().substring(0, 10),
                        dateDeFin.toString().substring(0, 10),
                        0);
                    DataBase.createCompetition(competitionModel);
                    try {
                      await _fcmNotificationService.sendNotificationToAll(
                        title: 'une nouvelle competition a été créée!',
                        body: discreption!,
                      );
                    } catch (e) {
                      print(e);
                    }
                  }
                } else {
                  editing = true;
                }
                setState(() {});
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "créer une nouvelle compétition",
                  style: kcustomCardTextStyle,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
