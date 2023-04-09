import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AdminAnnouncement extends StatefulWidget {
  const AdminAnnouncement({super.key});

  @override
  State<AdminAnnouncement> createState() => _AdminAnnouncementState();
}

const List<String> list = <String>['Zorunlu', 'Zorunlu Değil'];

class _AdminAnnouncementState extends State<AdminAnnouncement> {
  final CollectionReference _ann =
      FirebaseFirestore.instance.collection('duyurular');

  final TextEditingController _descriptionController = TextEditingController();
  var date;
  Future<void> _update({DocumentSnapshot? documentSnapshot}) async {
    if (documentSnapshot != null) {
      _descriptionController.text = documentSnapshot['description'];
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        String ddValue = list.first;
        DateTime fullDate = DateTime.now();
        var a = fullDate.month.toString(),
            g = fullDate.day.toString(),
            s = fullDate.hour.toString(),
            d = fullDate.minute.toString();
        if (int.parse(a) > 0 && int.parse(a) < 10) {
          a = "0" + fullDate.month.toString();
        }
        if (int.parse(g) > 0 && int.parse(g) < 10) {
          g = "0" + fullDate.day.toString();
        }
        if (int.parse(s) >= 0 && int.parse(s) < 10) {
          s = "0" + fullDate.hour.toString();
        }
        if (int.parse(d) >= 0 && int.parse(d) < 10) {
          d = "0" + fullDate.minute.toString();
        }

        String time = fullDate.year.toString() +
            "-" +
            a +
            "-" +
            g +
            " " +
            s +
            ":" +
            d +
            ":00";
        return BottomSheet(
            onClosing: () {},
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (BuildContext context, setState) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Açıklama'),
                        ),
                            
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final String description =
                                  _descriptionController.text;
                              if (
                                  description.length > 0 &&
                                  time != null) {
                                await _ann.doc(documentSnapshot!.id).update({
                                  "description": description,
                                  "date": time
                                });
                              }
                            },
                            child: const Text('Güncelle'))
                      ]),
                );
              });
            });
      },
    );
  }

  Future<void> _create({DocumentSnapshot? documentSnapshot}) async {
     _descriptionController.text = "";
    if (documentSnapshot != null) {
      _descriptionController.text = documentSnapshot['description'];
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        String ddValue = list.first;
        DateTime fullDate = DateTime.now();
        var a = fullDate.month.toString(),
            g = fullDate.day.toString(),
            s = fullDate.hour.toString(),
            d = fullDate.minute.toString();
        if (int.parse(a) > 0 && int.parse(a) < 10) {
          a = "0" + fullDate.month.toString();
        }
        if (int.parse(g) > 0 && int.parse(g) < 10) {
          g = "0" + fullDate.day.toString();
        }
        if (int.parse(s) >= 0 && int.parse(s) < 10) {
          s = "0" + fullDate.hour.toString();
        }
        if (int.parse(d) >= 0 && int.parse(d) < 10) {
          d = "0" + fullDate.minute.toString();
        }

        String time = fullDate.year.toString() +
            "-" +
            a +
            "-" +
            g +
            " " +
            s +
            ":" +
            d +
            ":00";
        return BottomSheet(
            onClosing: () {},
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (BuildContext context, setState) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Açıklama'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final String description =
                                  _descriptionController.text;
                              if (description.length > 0 && time != null) {
                                await _ann.add(
                                    {"description": description, "date": time});
                              }
                            },
                            child: const Text('Ekle'))
                      ]),
                );
              });
            });
      },
    );
  }

  Future<void> _delete(String id) async {
    await _ann.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Duyuru başarıyla silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Duyuru Ayarları"),backgroundColor: Color(0xffDB4437),),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: FloatingActionButton(
              
              onPressed: () => _create(),
              backgroundColor: Color(0xff0F9D58),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _ann.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  color: (index+1) % 4 == 0 ? Color(0xff0F9D58) : (index+1) % 3 == 0 ? Color(0xffF4B400) : (index+1) %2 == 0 ? Color(0xffDB4437) : Color(0xff4285F4),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['description']),
                    subtitle: Text(documentSnapshot['date'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              _update(documentSnapshot: documentSnapshot);
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              _delete(documentSnapshot.id);
                            },
                            icon: Icon(Icons.delete)),
                      ]),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
