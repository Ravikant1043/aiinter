import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:flutter_tts'
import 'package:flutter_tts/flutter_tts.dart';



class Listening extends StatefulWidget {
  String text;

  Listening({super.key,required this.text});

  @override
  State<Listening> createState() => _ListeningState();
}
enum TtsState { playing, stopped, paused, continued }

class _ListeningState extends State<Listening> {
  String generatedText = '';
  FlutterTts flutterTts = FlutterTts();
  bool ch1 = true;
  bool ch2 = true;
  bool nch = false;
  var tp = 100;
  ScrollController controller = ScrollController();

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  final centerTextStyle = const TextStyle(
    fontSize: 30,
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );

  late ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  var hei = 1000.0;

  //init state for text Generation
  void initState() {
    super.initState();
    generateText();
    initTts();
  }

  void Mic_help() {
    setState(() {
      ch2 = !ch2;
    });
  }

  void Volume_help() {
    setState(() {
      ch1 = !ch1;
    });
  }



  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ch1=!ch1;
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  //Using API KEY generating text and speaking
  Future<void> generateText() async {
    final apiKey = "AIzaSyD4z8TqJJ-8aGwpNJBFZFMQqy2oCImrnxA";
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      return;
    }
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [Content.text('write a paragraph about ${widget.text}  for 30 Seconds only or in 50 words')];
    final response = await model.generateContent(content);
    setState(() {
      generatedText = response.text.toString();
      //speak(generatedText);
    });
  }
  //Language,pitch and speech rate
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.7);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.speak(text);
  }
  void micAndVoice(){
    if(ch1){
      Volume_help();
      speak(generatedText);
    }
    else{
      Volume_help();
      _stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }


  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: hi * 0.07,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "LISTENING",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.white30,
                    ),
                  ),
                  SizedBox(
                    height: hi * 0.02,
                  ),
                  Container(
                    height: hi * 0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Color(0xFFE083EF)),
                      // color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('${widget.text}',style:TextStyle(fontSize:22,color: Colors.black),),),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          micAndVoice();
                        },
                        child: Container(
                          height: 45,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade500,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.purple),
                            boxShadow: [
                              ch1
                                  ? BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(2, 4),
                              )
                                  : BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2,
                                offset: Offset(-2, -4),
                              ),
                            ],
                          ),
                          child: ch1
                              ? Icon(Icons.volume_off)
                              : Icon(Icons.volume_up),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Mic_help();
                        },
                        child: Container(
                          height: 45,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade500,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.purple),
                            boxShadow: [
                              ch2
                                  ? BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(2, 4),
                              )
                                  : BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2,
                                offset: Offset(-2, -4),
                              ),
                            ],
                          ),
                          child: ch2
                              ? Icon(Icons.mic_none_sharp)
                              : Icon(Icons.mic_off),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: hi * 0.02,
                  ),
                  Container(
                    height: hi * 0.62,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFE083EF)),

                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(
                    height: hi * 0.02,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          nch = true;
                          hei = 1.25 * hi;
                          valueNotifier.value = 69.9;
                          controller.animateTo(400,
                              duration: Duration(seconds: 2),
                              curve: Curves.easeIn);
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade500,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.purple),
                          boxShadow: [
                            !nch
                                ? BoxShadow(
                              color: Colors.black45,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(2, 4),
                            )
                                : BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2,
                              offset: Offset(-2, -4),
                            ),
                          ],
                        ),
                        child: Center(child: Text("Show Result",style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                  if (nch)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 20),
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
                            progressColors: const [Colors.white, Colors.purple],
                            backColor: Colors.transparent,
                          ),
                        ),
                        Text("Acuraccy : "),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Confidence : ")
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
