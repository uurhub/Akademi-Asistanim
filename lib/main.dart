import 'package:f_44_oua/feature/auth/authentication_view.dart';
import 'package:f_44_oua/feature/home/home_page.dart';
import 'package:f_44_oua/feature/home/models/note_page_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'feature/home/note_page.dart';
import 'initialize/app_start_init.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthenticationView(),
      );
   
  }
}
