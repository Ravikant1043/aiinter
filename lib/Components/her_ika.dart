import 'package:flutter/material.dart';

 class Her_ika extends StatefulWidget {
   const Her_ika({super.key});

   @override
   State<Her_ika> createState() => _Her_ikaState();
 }

 class _Her_ikaState extends State<Her_ika> {
   @override
   bool t=false;
   Widget build(BuildContext context) {
     void helo(){
       setState(() {
         t=!t;
       });
     }
     var size=MediaQuery.of(context).size;
     var he=size.height;
     var br=size.width;
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         actions: [
           IconButton(onPressed: () => {}, icon: Icon(Icons.read_more)),
           InkWell(
               onTap: helo,
               child: Icon(Icons.height)),
           Icon(Icons.height),
           Icon(Icons.height),
           Icon(Icons.height)
         ],
       ),
       body: Container(
         height: he,
         width: br,
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [
               Colors.blue.shade400,
               Colors.blue.shade200,
             ],
             begin: Alignment(-1,-1),
             end: Alignment(1, 1),
           ),
         ),
         // child: Center(
         //   child:t?Text("Hello",style: TextStyle(
         //     fontSize: 30
         //   ),):Text("Hi",style: TextStyle(
         //     fontSize: 40
         //   ),),
         // ),
         child: Center(
           // child: CircleAvatar(
           //   radius: br/4,
           //   backgroundColor: Colors.red,
           //
           // ),
           child: Container(
             height: br/2,
             width: br/2,
             decoration: BoxDecoration(
               color: Colors.blue.shade700,
               boxShadow: [
                 BoxShadow(
                   color: Colors.black54,
                   blurRadius: 20,
                   spreadRadius: 2
                 )
               ],
               shape: BoxShape.circle
             ),
           ),
         ),
       ),
     );
   }
 }
