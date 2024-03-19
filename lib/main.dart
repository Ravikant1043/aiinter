import 'package:aiinterview/auth_change.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aiinterview/firebase_options.dart';

import 'Components/her_ika.dart';
import 'Components/login_page.dart';
import 'Components/page_no_1.dart';
import 'Components/speaking.dart';
// import 'Components/firstpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}
class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return AuthChange();
  }
}
