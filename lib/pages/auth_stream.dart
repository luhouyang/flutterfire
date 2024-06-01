import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:note/pages/home_page.dart';
import 'package:note/pages/login_page.dart';
import 'package:note/widgets/loading_text.dart';

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingText();
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
