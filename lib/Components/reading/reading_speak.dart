import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class Reading_Speaking extends StatefulWidget {
  final String text;

  const Reading_Speaking({Key? key, required this.text}) : super(key: key);

  @override
  State<Reading_Speaking> createState() => _Reading_SpeakingState();
}

class _Reading_SpeakingState extends State<Reading_Speaking> {

  final centerTextStyle = const TextStyle(
    fontSize: 20,
    // color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );
  String result = '0.00 0.00';
  String generatedText = '';
  bool micAccess = false;
  String _text='';
  double graph=0.00;
  FlutterTts flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool checking=false;
  bool show=true;
  double hight=0;
  late List<String> resultstring;
  ScrollController controller = ScrollController();
  late ValueNotifier<double> valueNotifier=ValueNotifier(0.0);

  Future<void> compareText(String s1, String s2) async {
    final apiKey = "AIzaSyD4z8TqJJ-8aGwpNJBFZFMQqy2oCImrnxA";

    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [
      Content.text(
          'compare the given two texts and return the accuracy between them '
              '(assume the second text is a text spoken by a person) 1) $s1 \n 2) $s2 '
              'output format: one decimal value out of 100 in double form ')
    ];

    final response = await model.generateContent(content);

    final String responseText = response.text.toString().trim();
    final String accuracyString = responseText.split(' ')[0];
    final double accuracy = double.tryParse(accuracyString) ?? 0.0;

    setState(() {
      result = responseText;
      this.graph = accuracy;
      print(accuracy);
      print(graph);
    });
  }


  @override
  void initState() {
    super.initState();
    show=false;
    micAccess=true;
    generateText();
    _speech = stt.SpeechToText();
    // valueNotifier = ValueNotifier(0.0);
  }

  Future<void> generateText() async {

    final apiKey = "AIzaSyD4z8TqJJ-8aGwpNJBFZFMQqy2oCImrnxA";
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      return;
    }
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [Content.text('write a simple story on ${widget.text} of 100 words')];
    final response = await model.generateContent(content);

    setState(() {
      generatedText = response.text.toString();
    });
  }
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.7);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Reading"), centerTitle: true,),
        body: SingleChildScrollView(
          controller: controller,
          child: Container(
            height: show ? hi*1.27: hi*0.98,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(padding: const EdgeInsets.only(top: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            widget.text,
                            style: TextStyle(fontSize: 18,),
                          ),
                        ),
                      ),
                    ),
                  ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: hi*.35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            generatedText.isEmpty ? SpinKitWave(
                              size: 50,
                              color: Colors.black,
                            ): Text(generatedText, style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CupertinoButton(
                    color: Colors.green,
                    child: Icon(micAccess ? Icons.mic_off : Icons.mic),
                    onPressed: () {
                      setState(() {
                        micAccess = !micAccess;
                        if (micAccess) {
                          _listen();
                        } else {
                          // flutterTts.stop();
                          _stopListening();
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: hi*.32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_text, style: TextStyle(fontSize: 16),),
                    ),
                  ),
                ),
                Center(
                  child: CupertinoButton(
                    color: Colors.greenAccent,
                    child: show ? const Text("hide accuracy", style: TextStyle(color: Colors.black),) :Text("show accuracy", style: TextStyle(color: Colors.black),),
                    onPressed: ()  {
                      compareText(generatedText, _text);
                      setState(()  {
                        show=!show;
                        controller.animateTo(400, duration: Duration(seconds: 2),curve: Curves.easeIn);
                        valueNotifier.value=graph;//accuracy variable dena hi yaha ;

                      });
                    },
                  ),
                ),


                show ? SizedBox(
                    height: hi*.35,
                    width: double.infinity,
                    child: SimpleCircularProgressBar(
                      size: 160,
                      valueNotifier: valueNotifier,
                      progressStrokeWidth: 18,
                      startAngle: 90,
                      backStrokeWidth: 0,
                      mergeMode: true,
                      onGetText: (value) {
                        return Text(
                          '${value.toInt()}',
                          style: centerTextStyle,
                        );
                      },
                      progressColors: const [Colors.cyan, Colors.purple],
                      backColor: Colors.black.withOpacity(0.4),
                    )
                ) : SizedBox(child: SizedBox(),),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('onStatus: $status'),
        onError: (error) => print('onError: $error'),
      );

      if (available) {
        _speech.listen(
          onResult: (result) => setState(() {
            _isListening = true;
            _text = result.recognizedWords;
          }),
        );
      }
    }
  }
  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }
}