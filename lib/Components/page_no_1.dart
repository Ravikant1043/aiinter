import 'dart:async';
import 'dart:math';
import 'package:aiinterview/Components/reading/reading_topic.dart';
import 'package:aiinterview/Components/speaking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';

import 'listen/topic_selector_listen.dart';

class FirstPage1 extends StatefulWidget {
  const FirstPage1({super.key});

  @override
  State<FirstPage1> createState() => _FirstPage1State();
}

class _FirstPage1State extends State<FirstPage1> {
  late Timer time;
  bool ch=false;
  var _progress=0.0;
  @override
  void initState() {
    super.initState();
    _progress=0;
  }
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    var len=size.height;
    var bre=size.width;
    var leftHeight= len - bre*1.15;

    return Scaffold(
      body: Container(
        height: len,
        width: bre,
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

      //   ///////////             child of the container
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: bre/1.8,
                width: bre,
                child: CustomPaint(
                  painter: SectorPainter(),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
             const Text("Speak Savvy",style: TextStyle(
               fontSize: 25,
               decoration: TextDecoration.underline,
             ),),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child:Column(
                  children: [
                    Center(
                      child: Text(
                        "Speak, Listen, Learn: Your Path to Fluent",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Center(
                      child: Text(
                          "Communication!",
                        style: TextStyle(fontSize: 20,color: Colors.red,decoration: TextDecoration.underline,),
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 30,),
              Container(
                height: leftHeight -100,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 60,),
                    Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade300,
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: CupertinoButton(child: Text("Reading...",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => ReadingTopicSelection(),));
                      }),
                    ),
                    // SizedBox(height: 20,),
                    Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade300,
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: CupertinoButton(child: Text("Listening...",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Topic_Selection(),));
                      }),
                    ),
                    // SizedBox(height: 20,),
                    Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade300,
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: CupertinoButton(child: Text("Speaking...",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Speaking(),));
                      }),
                    ),
                    // SizedBox(height: 20,),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class SectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint sectorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    double centerX = size.width /2;
    double centerY = 0;
    double radius = size.width/1.7 ;
    double startAngle = pi;
    double sweepAngle = -pi;

    Path sectorPath = Path()
      ..moveTo(centerX, centerY)
      ..lineTo(centerX + radius * cos(startAngle), centerY + radius * sin(startAngle))
      ..arcTo(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius), startAngle, sweepAngle, true)
      ..lineTo(centerX, centerY); // back to center
    canvas.drawPath(sectorPath, sectorPaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HelloWorld extends StatelessWidget {
  final double l,h,pos,st_angle;
  const HelloWorld({super.key, required this.l, required this.h, required this.pos, required this.st_angle});

  @override
  Widget build(BuildContext context) {
    return CircularSeekBar(
      width: min(l,h)/2,
      height: min(l,h)/2,
      progress: pos,
      barWidth: 1.7,
      startAngle: st_angle,
      sweepAngle: 360,
      progressColor: Colors.transparent,
      innerThumbRadius: 5,
      trackColor: Colors.purple,
      innerThumbStrokeWidth: 3,
      innerThumbColor: Colors.purple,
      outerThumbRadius: 2,
      outerThumbStrokeWidth: 10,
      outerThumbColor: Colors.white12,
      animation: true,
    );
  }
}
