import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AdminEvents extends StatefulWidget {
  const AdminEvents({super.key});

  @override
  State<AdminEvents> createState() => _AdminEventsState();
}

const List<String> list = <String>['Zorunlu', 'Zorunlu Değil'];

class _AdminEventsState extends State<AdminEvents> {
  final CollectionReference _events =
      FirebaseFirestore.instance.collection('etkinlikler');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  var obligation = true;
  var date;
  Future<void> _update({DocumentSnapshot? documentSnapshot}) async {
    if (documentSnapshot != null) {
      _titleController.text = documentSnapshot['title'];
      _descriptionController.text = documentSnapshot['description'];
      _durationController.text = documentSnapshot['duration'];
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
                          controller: _titleController,
                          decoration:
                              const InputDecoration(labelText: 'Başlık'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Açıklama'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          controller: _durationController,
                          decoration: const InputDecoration(labelText: 'Süre'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: ddValue,
                          elevation: 16,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              ddValue = value!;
                              obligation =
                                  value.toString().toLowerCase() == "zorunlu"
                                      ? true
                                      : false;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2023, 1, 1),
                                  maxTime: DateTime(2023, 12, 31),
                                  onConfirm: (dt) {
                                var ay = dt.month.toString(),
                                    gun = dt.day.toString(),
                                    saat = dt.hour.toString(),
                                    dk = dt.minute.toString();
                                if (int.parse(dt.month.toString()) > 0 &&
                                    int.parse(dt.month.toString()) < 10)
                                  ay = "0" + dt.month.toString();
                                if (int.parse(dt.day.toString()) > 0 &&
                                    int.parse(dt.day.toString()) < 10)
                                  gun = "0" + dt.day.toString();
                                if (int.parse(dt.hour.toString()) >= 0 &&
                                    int.parse(dt.hour.toString()) < 10)
                                  saat = "0" + dt.hour.toString();
                                if (int.parse(dt.minute.toString()) >= 0 &&
                                    int.parse(dt.minute.toString()) < 10)
                                  dk = "0" + dt.minute.toString();
                                time = fullDate.year.toString() +
                                    "-" +
                                    ay +
                                    "-" +
                                    gun +
                                    " " +
                                    saat +
                                    ":" +
                                    dk +
                                    ":00";
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.tr);
                            },
                            child: Text('Tarih')),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final String title = _titleController.text;
                              final String description =
                                  _descriptionController.text;
                              final String duration = _durationController.text;
                              if (title.length > 0 &&
                                  description.length > 0 &&
                                  duration.length > 0 &&
                                  obligation != null &&
                                  time != null) {
                                await _events.doc(documentSnapshot!.id).update({
                                  "title": title,
                                  "description": description,
                                  "duration": duration,
                                  "obligation": obligation,
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
    _titleController.text = "";
    _descriptionController.text = "";
    _durationController.text = "";

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
                          controller: _titleController,
                          decoration:
                              const InputDecoration(labelText: 'Başlık'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Açıklama'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          controller: _durationController,
                          decoration: const InputDecoration(labelText: 'Süre'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: ddValue,
                          elevation: 16,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              ddValue = value!;
                              obligation =
                                  value.toString().toLowerCase() == "zorunlu"
                                      ? true
                                      : false;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2023, 1, 1),
                                  maxTime: DateTime(2023, 12, 31),
                                  onConfirm: (dt) {
                                var ay = dt.month.toString(),
                                    gun = dt.day.toString(),
                                    saat = dt.hour.toString(),
                                    dk = dt.minute.toString();
                                if (int.parse(dt.month.toString()) > 0 &&
                                    int.parse(dt.month.toString()) < 10)
                                  ay = "0" + dt.month.toString();
                                if (int.parse(dt.day.toString()) > 0 &&
                                    int.parse(dt.day.toString()) < 10)
                                  gun = "0" + dt.day.toString();
                                if (int.parse(dt.hour.toString()) >= 0 &&
                                    int.parse(dt.hour.toString()) < 10)
                                  saat = "0" + dt.hour.toString();
                                if (int.parse(dt.minute.toString()) >= 0 &&
                                    int.parse(dt.minute.toString()) < 10)
                                  dk = "0" + dt.minute.toString();
                                time = fullDate.year.toString() +
                                    "-" +
                                    ay +
                                    "-" +
                                    gun +
                                    " " +
                                    saat +
                                    ":" +
                                    dk +
                                    ":00";
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.tr);
                            },
                            child: Text('Tarih')),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final String title = _titleController.text;
                              final String description =
                                  _descriptionController.text;
                              final String duration = _durationController.text;
                              if (title.length > 0 &&
                                  description.length > 0 &&
                                  duration.length > 0 &&
                                  obligation != null &&
                                  time != null) {
                                await _events.add({
                                  "title": title,
                                  "description": description,
                                  "duration": duration,
                                  "obligation": obligation,
                                  "date": time
                                });
                              }
                            },
                            child: const Text('Oluştur'))
                      ]),
                );
              });
            });
      },
    );
  }

  Future<void> _delete(String id) async {
    await _events.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Etkinlik başarıyla silindi.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Etkinlik Ayarları"),),
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
        stream: _events.snapshots(),
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
                    title: Text(documentSnapshot['title']),
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
