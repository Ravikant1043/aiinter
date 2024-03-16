import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'firstpage1.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}
GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var length = size.height;
    var breadth = size.width;
    return Scaffold(
      body: SizedBox(
        height: length,
        width: breadth,
        child: Stack(
            children:[
              Image(image:AssetImage("assets/1.png"),
                  // NetworkImage("https://image/s.unsplash.com/photo-1710372165237-2a2ada353c15?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D"),
                  height: length,width: breadth,fit: BoxFit.fill),
              Column(children:[Expanded(
                flex: 1,
                child: SizedBox(),
              ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: length,
                    width: breadth,
                    color: Colors.transparent,
                    child: Center(
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        speed: 800,
                        flipOnTouch: false,
                        key: cardKey,
                        front: LgoinPage(
                          cardKey:cardKey,
                        ),
                        back: RegisterPage(
                          cardKey: cardKey,
                        ),
                        // flipOnTouch: false,
                      ),
                    ),
                  ),
                ),],
              ),
            ]
        ),
      ),
    );
  }
}