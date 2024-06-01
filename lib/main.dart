import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:note/firebase_options.dart';
import 'package:note/pages/auth_stream.dart';
import 'package:note/usecase/user_usecase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserUsecase())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.blue,
        home: AuthStream(),
      ),
    );
  }
}
