import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_to_text.dart';


class Speaking extends StatefulWidget {
  const Speaking({super.key});

  @override
  State<Speaking> createState() => _SpeakingState();
}

class _SpeakingState extends State<Speaking> {
  @override
  bool ch=true;
  bool nch=false;
  var tp=100;
  var _con=0.0;
  String generatedText="";
  bool micAccess=true;
  bool _islistening=false;
  String _text="";
  var result;
  late SpeechToText _speaking;

  ScrollController controller = ScrollController();
  final apiKey = "AIzaSyD4z8TqJJ-8aGwpNJBFZFMQqy2oCImrnxA";
  Future<void> generateText() async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [Content.text('Generate a random simple word on which we can speak')];
    final response = await model.generateContent(content);
    setState(() {
      generatedText = response.text.toString().trim();
    });
    print(generatedText);
  }
  Future<void> compareText(String s1, String s2) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [
      Content.text(
          'Compare how much is the text meaning is correct about the first text and return correctness and accuracy and if the text is not accurate then return 0'
              '(assume the second text is a text spoken by a person) and the first text is the topic given to him 1) $s1 \n 2) $s2 '
              'output format: two decimal values out of 100 with space between them')
    ];
    final response = await model.generateContent(content);
    setState(() {
      result = response.text.toString();
      print(result.toString());
      print(result.toString().length);
    });
  }




  final centerTextStyle = const TextStyle(
    fontSize: 30,
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );
  late ValueNotifier<double> valueNotifier=ValueNotifier(0.0);
  var hei=1000.0;
  @override
  void initState() {
    super.initState();
    ValueNotifier<double>valueNotifier=ValueNotifier(0.0);
    generateText();
    _speaking=SpeechToText();
  }

  void _listen() async{
    if(!_islistening){
      bool avail = await _speaking.initialize();
      if(avail){
        _speaking.listen(
          onResult: (res)=> setState(() {
            _islistening=true;
            _text=res.recognizedWords;
            _con=res.confidence;
          })
        );
      }
    }
  }
  void _stopListening(){
    if(_islistening){
      _speaking.stop();
      setState(() {
        _islistening=false;
      });
    }
  }
  @override
  void dispose() {
    _speaking.stop();
    super.dispose();
  }



  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var h=size.height;
    var w=size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Speaking..."),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: AnimatedContainer(
          height: nch?max(h,hei):min(h,hei),
          width: w,
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
          duration: Duration(seconds: 0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 70,
                  width: w/3 * 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.purple,
                      width: 2
                    ),
                  ),
                  child:
                  generatedText.isNotEmpty?
                  Center(child: Text(generatedText,style: TextStyle(fontSize: 25),
                  )
                  ):SizedBox(
                    width: 10,
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      ch=!ch;
                      print(ch);
                      micAccess=!micAccess;
                      (micAccess)?_listen():_stopListening();
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade500,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple),
                      boxShadow: [
                        ch?BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(2,4)
                        ):BoxShadow(
                            color: Colors.black45,
                            blurRadius: 2,
                            offset: Offset(-2,-4)
                        ),
                      ]
                    ),
                    child: ch?Icon(Icons.mic_none_sharp):Icon(Icons.mic_off),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: h/4.8 * 3 - 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(_text),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      nch=true;
                      hei=1.3*h;
                      valueNotifier.value=69.9;
                      controller.animateTo(200, duration: Duration(seconds: 5),curve: Curves.easeIn);
                      compareText(_text,generatedText);
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.purple.shade500,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.purple.shade900),
                        boxShadow: [
                          !nch?BoxShadow(
                              color: Colors.black45,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(2,4)
                          ):BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2,
                              offset: Offset(-2,-4)
                          ),
                        ]
                    ),
                    child: Center(child: Text("Show Result")),
                  ),
                ),
              ),
              if(nch)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30,bottom: 20),
                    child: SimpleCircularProgressBar(
                      size: 100,
                      startAngle: 90,
                      valueNotifier: valueNotifier,
                      progressStrokeWidth: 18,
                      backStrokeWidth: 24,
                      mergeMode: true,
                      onGetText: (value) {
                        return Text(
                          '${value.toInt()}',
                          style: centerTextStyle,
                        );
                      },
                      progressColors: const [Colors.cyan, Colors.purple],
                      backColor: Colors.transparent,
                    ),
                  ),
                  Text("Acuraccy : "),
                  SizedBox(height: 10,),
                  Text("Confidence : ${_con}")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}