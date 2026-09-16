import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voxwritter/auth/login_or_register.dart';
import 'package:voxwritter/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return HomePage();
          }

              ////user is not logged in
          else{
            return const LoginOrRegister();
          }
        },

      ),
    );
  }
}
