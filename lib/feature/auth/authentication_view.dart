import 'package:f_44_oua/feature/admin/admin_page.dart';
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
                var check = (state.user?.email.toString())
                    ?.substring(0, state.user?.email.toString().indexOf("@"));
                if (check == "akademi") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataContainer(
                                data: state.user?.email,
                                child: AdminPage(),
                              )),
                      ModalRoute.withName("/admin"));
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataContainerHome(
                                data: state.user?.email,
                                child: HomePage(),
                              )),
                      ModalRoute.withName("/home"));
                }
              }
            }),
          ],
          child: SafeArea(
            child: Center(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/akademi_asistanim_logo.png',
                          height: 200,
                          width: 200,
                        ),
                        Padding(
                            padding: context.paddingLow,
                            child: firebase.LoginView(
                              action: firebase.AuthAction.signIn,
                              showTitle: false,
                              providers: firebase.FirebaseUIAuth.providersFor(
                                  FirebaseAuth.instance.app),
                            )),
                      ],
                    );
                  }),
            ),
          )),
    );
  }
}
