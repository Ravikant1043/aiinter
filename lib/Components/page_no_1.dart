import 'dart:async';
import 'dart:math';
import 'package:aiinterview/Components/speaking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';

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
        child: Column(
          children: [
            Container(
              height: bre/1.7,
              width: bre,
              child: CustomPaint(
                painter: SectorPainter(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
           const Text("Hlw guys"),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:Text(
                "hlw guys we are building this very very very "
                    "very very very very very very very very very very"
                    " very very very very very very very very very very"
                    " very very very very very very very very very very"
                    "very very very very very very very very very very very "
                    "very very very very very very very very very very very "
                    "very very very very very very very very very very very "
                    "gooood app "
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: leftHeight,
              // color: Colors.red,
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  // Center(
                  //   child: Container(
                  //     height: bre/2-10,
                  //     width: bre/2-10,
                  //     decoration: BoxDecoration(
                  //       color: Colors.purple.shade500,
                  //       shape: BoxShape.circle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black38,
                  //           blurRadius: 4,
                  //           spreadRadius: 3,
                  //           offset: Offset(2,2),
                  //         )
                  //       ]
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: HelloWorld(
                  //     pos: 0,
                  //     st_angle: 0,
                  //     h: bre +40,
                  //     l: bre+40,
                  //   ),
                  // )

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

                    }),
                  ),
                  SizedBox(height: 20,),
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

                    }),
                  ),
                  SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
                ],
              )
            )
          ],
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
