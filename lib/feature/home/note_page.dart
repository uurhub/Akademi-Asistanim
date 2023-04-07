import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (
        context,value,child) => Scaffold(
      body: Column(children:[ 
          const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text("Notlarım",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        ),

        CupertinoListSection(
          children: [
            CupertinoListTile(title: Text("data")),
            CupertinoListTile(title: Text("data")),
            CupertinoListTile(title: Text("data")),
          ],
          )
      ],),
    ),
  );
  }
}