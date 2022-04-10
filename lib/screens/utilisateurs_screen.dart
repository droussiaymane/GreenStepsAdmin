import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/screens/screens.dart';
import 'package:web_app/utils/utils.dart';
import 'package:web_app/widgets/widgets.dart';

class Utilisateurs extends StatefulWidget {
  const Utilisateurs({Key? key}) : super(key: key);

  @override
  State<Utilisateurs> createState() => _UtilisateursState();
}

class _UtilisateursState extends State<Utilisateurs> {
  @override
  Widget build(BuildContext context) {
    final UtilisateursProvider utilisateursProvider =
        Provider.of<UtilisateursProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: utilisateursProvider.quee.length == 1
            ? null
            : IconButton(
                onPressed: () {
                  utilisateursProvider.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
        title: Align(
          alignment: Alignment.centerRight,
          child: SearchInputWidget(provider: utilisateursProvider),
        ),
      ),
      body: utilisateursProvider.quee.last,
    );
  }
}



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  filterTES? filterTESactive = filterTES.tous;
  sex? sexActive;
  String? departement;
  String searchKey = '';
  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final UtilisateursProvider utilisateursProvider =
        Provider.of<UtilisateursProvider>(context);
    searchKey = utilisateursProvider.searchKey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      padding: const EdgeInsets.symmetric(
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
                            .map<DropdownMenuItem<String>>((String value) {
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
                    const TitleHelper("Staff"),
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
            height: 70,
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
      child: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection("users")
            .orderBy("nombrePasTotal", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var len = snapshot.data!.docs.length;
          if (len == 0) {
            return Column(
              children: const [
                SizedBox(height: 100),
                Center(
                  child: Text("Aucun utilisateur trouvé",
                      style: TextStyle(fontSize: 20, color: kOtherColor)),
                )
              ],
            );
          }
          
          final UtilisateursProvider utilisateursProvider =
        Provider.of<UtilisateursProvider>(context);

          int i = 0;
          List<CustomTableRow> customTableRow = snapshot.data!.docs.map((data) {
            i++;
            return buildListItem(context, data, i);
          }).toList();
          
          //here start the magic

          if (searchKey != '') {
            customTableRow = customTableRow
                .where((s) =>
                    s.fullName.toLowerCase().contains(searchKey.toLowerCase()))
                .toList();
          } else if (filterTESactive == filterTES.staff) {
            customTableRow =
                customTableRow.where((s) => s.departement == null).toList();
          } else if (filterTESactive == filterTES.etudiant) {
            customTableRow = customTableRow.where((s) {
              if (departement == null) {
                return s.departement != null;
              }
              return s.departement != null && s.departement == departement;
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

          //the end of magic
          return Column(
            children: [
              Expanded(
                child: ListView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    children: customTableRow),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                utilisateursProvider.push(Contacter(customTableRow, searchKey != "" ? null : [filterTESactive.toString().split('.').last,departement,sexActive?.toString().split('.').last]));
              }, child: const Text("Contacter"),),
              const SizedBox(height: 20,),
            ],
          );
        },
      ),
    );
  }

  CustomTableRow buildListItem(
      BuildContext context, DocumentSnapshot snapshot, int rang) {
    final userModel = UserModel.fromSnapshot(snapshot);
    return CustomTableRow(
      rang.toString(),
      (userModel.prenom ?? '__') + ' ' + (userModel.nom ?? '__'),
      userModel.departement,
      userModel.nombrePasTotal.toString(),
      userModel.sexe!,
      userModel,
    );
  }
}













