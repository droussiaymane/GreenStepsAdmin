import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/utils/database.dart';


class Contacter extends StatefulWidget {
  const Contacter(this.to, this.filters, {Key? key}) : super(key: key);
  final List<dynamic>? filters;
  final List<dynamic> to;
  @override
  State<Contacter> createState() => _ContacterState();
}

class _ContacterState extends State<Contacter> {
  final _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<ChipData> _allChips = [];
  void _deleteChip(String id) {
    setState(() {
      _allChips.removeWhere((element) => element.id == id);
    });
  }

  @override
  void initState() {
    int i = 0;
    if (widget.filters == null) {
      _allChips = widget.to.map((e) {
        i++;
        return ChipData(
          id: "$i",
          name: e.fullName,//(e.user.prenom ?? '__') + ' ' + (e.user.nom ?? '__'),
        );
      }).toList();
    } else {
      widget.filters!.forEach((element) {
        if (element != null) {
          _allChips.add(ChipData(id: "$i", name: element));
        }
        i++;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    "Message à : ",
                    style: kTableCulumn,
                  ),
                  Wrap(
                    spacing: 10,
                    children: _allChips
                        .map((chip) => Chip(
                              key: ValueKey(chip.id),
                              label: Text(chip.name),
                              // backgroundColor: Colors.amber.shade200,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              onDeleted: widget.filters == null
                                  ? () => _deleteChip(chip.id)
                                  : null,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                ),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintStyle: kbody,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  hintText: "le corps du message",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                autocorrect: true,
                controller: _messageController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'le contenu du message ne doit pas être nulle';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: const Text("Envoyer"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    for (var item in widget.to) {
                      DataBase.sendMessage(item.user, _messageController.text).then((value){_messageController.text = "";});
                      
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('le message est envoyé'),
                      ),
                    );
                  }
                  
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChipData {
  final String id;
  final String name;
  ChipData({required this.id, required this.name});
}
