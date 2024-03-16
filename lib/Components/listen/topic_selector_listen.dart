import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Topic_Selection extends StatefulWidget {
  const Topic_Selection({super.key});

  @override
  State<Topic_Selection> createState() => _Topic_SelectionState();
}

class _Topic_SelectionState extends State<Topic_Selection> {
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    final TextEditingController textEditingController=TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: hi,
          width: wi,
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
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: hi*0.07,),
              Center(
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 12),
                  height: hi*0.43,
                  width: wi*0.80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12),
                    child: TextField(
                      maxLines: 10,
                      maxLength: 30,
                      controller: textEditingController,
                      decoration: InputDecoration(
                          hintText: ('Write a topic name '),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: hi*0.01,),
              CupertinoButton(
                  color: Colors.purple.shade500,
                  child: Text("Generate"), onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder:(context)=> Listening(text:textEditingController.text.trim())));
              }),
            ],
          ),
        ),
      ),
    );
  }
}