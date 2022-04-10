import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/screens/screens.dart';
import 'package:web_app/utils/utils.dart';
import 'package:web_app/widgets/widgets.dart';

class Historique extends StatefulWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    final HistoriqueProvider historiqueProvider =
        Provider.of<HistoriqueProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: historiqueProvider.quee.length == 1
            ? null
            : IconButton(
                onPressed: () {
                  historiqueProvider.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
        title: Align(
          alignment: Alignment.centerRight,
          child: SearchInputWidget(provider: historiqueProvider),
        ),
      ),
      body: historiqueProvider.quee.last,
    );
  }
}

class CompetitionHistorque extends StatefulWidget {
  const CompetitionHistorque({Key? key}) : super(key: key);

  @override
  State<CompetitionHistorque> createState() => _CompetitionHistorqueState();
}

class _CompetitionHistorqueState extends State<CompetitionHistorque> {
  String searchKey = '';
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final HistoriqueProvider historiqueProvider =
        Provider.of<HistoriqueProvider>(context);
    searchKey = historiqueProvider.searchKey;
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.getCompetitionsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return  const Center(child: CircularProgressIndicator());
        }
        var len = snapshot.data!.docs.length;
        if (len == 0) {
          return Column(
            children: const [
              SizedBox(height: 100),
              Center(
                child: Text("Aucune competition trouvée", style: kerror),
              )
            ],
          );
        }
        List<CustomCard> customCards = snapshot.data!.docs.map((data) {
          return buildListItem(context, data);
        }).toList();
        //here where the magic happens
        if (searchKey != '') {
          customCards = customCards
              .where((s) => s.competitionName
                  .toLowerCase()
                  .contains(searchKey.toLowerCase()))
              .toList();
        }
        //end of magic

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  TableHelper(
                    'Nom de la competition',
                    width: 300,
                    style: kcustomCardColumnStyle,
                  ),
                  TableHelper(
                    'Date',
                    width: 100,
                    style: kcustomCardColumnStyle,
                  ),
                  TableHelper(
                    'Total participants',
                    width: 200,
                    style: kcustomCardColumnStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                children: customCards,
              ),
            ),
          ]),
        );
      },
    );
  }

  CustomCard buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    return CustomCard(
        competitionName: snapshot["name"],
        dateDeDepart: snapshot["date de debut"],
        dateDeFin: snapshot["date de fin"],
        totalParticipants: snapshot["participants"].length,
        competition: snapshot.reference);
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.competitionName,
      required this.dateDeDepart,
      required this.dateDeFin,
      required this.totalParticipants,
      required this.competition})
      : super(key: key);
  final String competitionName;
  final String dateDeDepart;
  final String dateDeFin;
  final int totalParticipants;
  final DocumentReference competition;
  @override
  Widget build(BuildContext context) {
    final HistoriqueProvider historiqueProvider =
        Provider.of<HistoriqueProvider>(context);
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        
        color: Colors.transparent,
        child: InkWell(
          hoverColor: kLightSecondaryColor,
          onTap: () {
            historiqueProvider.push(CompetitionDashBoard(competition));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TableHelper(
                competitionName,
                width: 300,
                style: kcustomCardTextStyle,
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      dateDeDepart,
                      style: kcustomCardDateStyle,
                    ),
                    Text(
                      dateDeFin,
                      style: kcustomCardDateStyle,
                    ),
                  ],
                ),
              ),
              TableHelper(
                totalParticipants.toString(),
                width: 200,
                style: kcustomCardTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
