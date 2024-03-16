import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';


class RegisterPage extends StatefulWidget {
  final GlobalKey<FlipCardState> cardKey;
  const RegisterPage({super.key, required this.cardKey});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void help(){
    setState(() {
      widget.cardKey.currentState?.toggleCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 500,
      width: 300,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1,sigmaY: 1),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 0.7,
                color: Colors.white.withOpacity(1),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //              registration page
                  Text("Register Here",style: TextStyle(
                    fontSize: 18,
                  ),),
                  SizedBox(height: 10,),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),hintText: "Name",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),hintText: "Gmail",
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),hintText: "Phone No",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),hintText: "Confirm Password",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  CupertinoButton(child: Text("helo"), onPressed:(){} ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already a User? "),
                      GestureDetector(
                          onTap: help,
                          child: Text("SignUP",style: TextStyle(
                              fontWeight:FontWeight.bold),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class LgoinPage extends StatefulWidget {
  final GlobalKey<FlipCardState> cardKey;
  const LgoinPage({super.key, required this.cardKey});
  @override
  State<LgoinPage> createState() => _LgoinPageState();
}


class _LgoinPageState extends State<LgoinPage> {
  @override
  void help(){
    setState(() {
      widget.cardKey.currentState?.toggleCard();
    });
  }
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1,sigmaY: 1),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 0.6,
                color: Colors.white.withOpacity(1),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //                 logi here
                    Text("Login Here",style: TextStyle(
                      fontSize: 20,
                    ),),
                    SizedBox(height: 10,),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),hintText: "Name",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),hintText: "Password",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                      ),
                    ),
                    CupertinoButton(child: Text("Login"), onPressed: (){}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Not a User? "),
                        GestureDetector(
                            onTap: help,
                            child: Text("REGISTER",style: TextStyle(
                                fontWeight:FontWeight.bold),
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}