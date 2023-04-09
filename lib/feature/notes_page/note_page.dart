import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import 'editing_note_page.dart';
import 'models/note_page.dart';
import 'models/note_page_data.dart';

class DataContainerNote extends InheritedWidget {
  final String? data;

  const DataContainerNote(
      {super.key, required this.data, required Widget child})
      : super(child: child);

  static DataContainerNote? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataContainerNote>();
  }

  @override
  bool updateShouldNotify(DataContainerNote old) {
    return data != old.data;
  }
}

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: pagesNotes(data: DataContainerNote.of(context)?.data),
      ),
    );
  }
}

class pagesNotes extends StatefulWidget {
  const pagesNotes({super.key, required this.data});
  final data;
  @override
  State<pagesNotes> createState() => _pagesNotesState();
}

class _pagesNotesState extends State<pagesNotes> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Color(0xff0F9D58),
          child: Icon(
            Icons.add,
            color: Color(0xffF4B400),
          ),
        ),
        appBar: AppBar(
          title: const Text("Notlarım"),
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataContainerHome(
                              data: widget.data,
                              child: HomePage(),
                            )),
                    ModalRoute.withName("/home"));
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Color(0xff0F9D58),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 35),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Notlarım",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ),
            value.getAllNotes().length == 0
                ? const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                        child: Text(
                      "Kayıtlı bir not yok",
                      style: TextStyle(color: Colors.grey),
                    )),
                  )
                : CupertinoListSection.insetGrouped(
                    children: List.generate(
                    value.getAllNotes().length,
                    (index) => CupertinoListTile(
                      title: Text(value.getAllNotes()[index].text),
                      onTap: () =>
                          goToNotePage(value.getAllNotes()[index], false),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteNote(value.getAllNotes()[index]),
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  void createNewNote() {
    int id = Provider.of<NoteData>(context as BuildContext, listen: false)
        .getAllNotes()
        .length;

    Note newNote = Note(
      id: id,
      text: '',
    );

    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context as BuildContext, listen: false)
        .deleteNote(note);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }
}
