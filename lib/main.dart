import 'package:f_44_oua/feature/auth/auth_localization.dart';
import 'package:f_44_oua/feature/auth/authentication_view.dart';
import 'package:f_44_oua/feature/home/home_page.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
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
    return MaterialApp(
      localizationsDelegates: [
        FirebaseUILocalizationDelegate(const LabelOverrides()),
        FirebaseUILocalizations.delegate,
      ],
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff4285F4)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthenticationView(),
    );
  }
}
