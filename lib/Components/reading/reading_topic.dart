import 'package:aiinterview/Components/reading/reading_speak.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadingTopicSelection extends StatefulWidget {
  const ReadingTopicSelection({super.key});

  @override
  State<ReadingTopicSelection> createState() => _ReadingTopicSelectionState();
}

class _ReadingTopicSelectionState extends State<ReadingTopicSelection> {
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    final TextEditingController textEditingController=TextEditingController();
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
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
        child: Column(
          children: [
            SizedBox(height: hi*0.07,),
            Center(
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 12),
                height: hi*0.43,
                width: wi*0.88,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:12),
                  child: TextField(
                    maxLines: 2,
                    maxLength: 20,
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: ('Write a topic name'),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: hi*0.01,),
            CupertinoButton(
                color: Colors.greenAccent,
                child: Text("generate"), onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder:(context)=> Reading_Speaking(text:textEditingController.text.trim())));
            }),
          ],
        ),
      ),
    );
  }
}
