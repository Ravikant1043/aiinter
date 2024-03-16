import 'package:aiinterview/Components/login_page.dart';
import 'package:aiinterview/Components/page_no_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthChange extends StatelessWidget {
  const AuthChange({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot){
      if(snapshot.hasData){
        return FirstPage1();
      }else{
        return LoginPage();
      }
    });
  }
}
