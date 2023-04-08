import 'package:f_44_oua/feature/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:kartal/kartal.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
          actions: [
            firebase.AuthStateChangeAction<firebase.SignedIn>((context, state) {
              if (state.user != null) {
                Navigator.pushAndRemoveUntil(context,
                    
                    
                    MaterialPageRoute(builder: (context) => HomePage(username: state.user?.email,)), ModalRoute.withName("/home"));
              }
            }),
          ],
          child: SafeArea(
            child: Padding(
                padding: context.paddingLow,
                child: firebase.LoginView(
                  action: firebase.AuthAction.signIn,
                  showTitle: false,
                  providers: firebase.FirebaseUIAuth.providersFor(
                      FirebaseAuth.instance.app),
                )),
          )),
    );
  }
}
