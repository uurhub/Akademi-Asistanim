import 'package:f_44_oua/feature/home/home_page.dart';
import 'package:f_44_oua/feature/home/models/note_page_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/home/note_page.dart';
import 'initialize/app_start_init.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> NoteData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
      );
  }
}
