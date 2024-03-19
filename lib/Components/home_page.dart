import 'package:flutter/material.dart';
 class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

 class _HomeScreenState extends State<HomeScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [
               Colors.purple.shade50,
               Colors.purple.shade100,
               Colors.purple.shade200,
               Colors.purple.shade400,
             ],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
           ),
         ),
       ),
     );
   }
 }
