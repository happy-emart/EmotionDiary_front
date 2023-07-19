import 'package:emotion_diary/page_reading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'widgets/emoticon_face.dart';
import 'widgets/weather_radio.dart';
import 'package:http/http.dart' as http;
import 'widgets/get_jwt_token.dart';
import 'tab_controller.dart';
import 'main_sub.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

String globalUrl = "http://localhost:8080";
// String globalUrl= 'http://172.10.5.90:443';
String modelUrl = "http://172.10.9.25:80/";
int selectedRadioIndex = 0;

class RecordingPage extends StatefulWidget {
  RecordingPage({Key? key}) : super(key: key);

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final recorder = FlutterSoundRecorder();
  final ScrollController _scrollController = ScrollController();
  late int selectedButton = -1;
  bool isRecorderReady = false;
  void toggleSelection(int buttonNumber) {
    if (selectedButton == buttonNumber) return;
    setState(() {
      selectedButton = buttonNumber;
    });
  }

  var emoticonText =
    TextStyle(
      fontFamily: "bookk",
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.white,
    );

  Widget buildButton(int buttonNumber, String emotionText, String emotionDescription) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: ElevatedButton(
            onPressed: () {
              toggleSelection(buttonNumber);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  // sid,
                )
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (selectedButton == buttonNumber) {
                  return Theme.of(context).colorScheme.onPrimary; // 선택된 버튼의 배경색
                } else {
                  return Theme.of(context).colorScheme.background; // 선택되지 않은 버튼의 배경색
                }
              }),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmoticonFace2(
                  emoticonface: emotionText
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8,),
        Text(
          emotionDescription,
          style: emoticonText,
        ),
      ],
    );
  }

  Future record() async {
    if (!isRecorderReady) return;
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/audio.aac'; // change the extension based on the codec you're using
      // print("------------");
      // print(dir);
      // print("------------");
      await recorder.startRecorder(toFile: path);
    } catch (e) {
      print('Error starting recorder: $e');
    }
  }

  Future stop() async {
    if (!isRecorderReady) return;
    try {
      final path = await recorder.stopRecorder();
      final audioFile = File(path!); // audioFile == refernce to audio file
      
      // print('Recorded audio: $audioFile');
    } catch (e) {
      print('Error stopping recorder: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw '필요한 권한을 얻지 못했습니다.';
    }
    
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    var neutralEmoticon = buildButton(0, '🙂', "중립이에요");
    var happyEmoticon = buildButton(1, '😆', "행복해요");
    var sadEmoticon = buildButton(2, '😢', "슬퍼요");
    var angryEmoticon = buildButton(3, '😠', "화나요");
    var scaredEmoticon = buildButton(4, '😰', "불안해요");
    var embrassedEmoticon = buildButton(5, '😵‍💫', "당황했어요");
    var hateEmoticon = buildButton(6, '😒', "싫어요");

    var emoticonButtonScroll = EmotionButtonScroll(scrollController: _scrollController, neutralEmoticon: neutralEmoticon, happyEmoticon: happyEmoticon, sadEmoticon: sadEmoticon, angryEmoticon: angryEmoticon, scaredEmoticon: scaredEmoticon, embrassedEmoticon: embrassedEmoticon, hateEmoticon: hateEmoticon);
  
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        if (selectedButton > 3)
        _scrollController.animateTo(200.0, duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
    var now = DateTime.now();
    var yesterday = DateTime.now().subtract(Duration(days: 1));
    var today = now.hour < 7 ? yesterday : now;
    var todayString = DateFormat("yyyy년 MM월 dd일").format(today);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "▷ $todayString자 일기를 작성합니다"
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                      "오늘의 기분",
                                      style: TextStyle(
                                        fontFamily: "bookk",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                // ,
                              ]
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            emoticonButtonScroll
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // selecting weather
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                      "날씨",
                                      style: TextStyle(
                                        fontFamily: "bookk",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                // ,
                              ]
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            RadioButtonWidget1(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                      "녹음하기",
                                      style: TextStyle(
                                        fontFamily: "bookk",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                // ,
                              ]
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder<RecordingDisposition>(
                                  stream: recorder.onProgress,
                                  builder: (context, snapshot) {
                                    final duration = snapshot.hasData
                                      ? snapshot.data!.duration
                                      : Duration.zero;
                                    String twoDigits(int n) => n.toString().padLeft(2, '0');
                                    final twoDigitMinutes =
                                      twoDigits(duration.inMinutes.remainder(60));
                                    final twoDigitSeconds =
                                      twoDigits(duration.inSeconds.remainder(60));

                                    return Text(
                                      '$twoDigitMinutes:$twoDigitSeconds',
                                      style: const TextStyle(
                                        fontSize: 60,
                                        fontFamily: 'bookk',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (recorder.isRecording) {
                                      await stop();
                                    } else {
                                      await record();
                                    }

                                    setState(() {});
                                  },
                                  child: Icon(
                                    recorder.isRecording ? Icons.stop : Icons.mic,
                                    size: 80,
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                            // var diary = API에서 받아온 text data;

                            // send 
                            var body = {
                              // 'id': id,
                              'emotion': emotionConverter(selectedButton),
                              'text': "시험 중입니다.",
                              'weather': selectedRadioIndex,
                              'writtenDate': DateFormat("yyyy-MM-dd").format(today),
                            };
                            // await sendDiary(body); -> 완성되면 주석 풀기
                            isDiaryWritten = true;
                            Navigator.pop(context);
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Controller()
                            //   ),
                            // ); -> 완성되면 위의 .pop과 주석 교체
                        },
                        child: Text(
                          "작성 완료",
                          style: emoticonText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionButtonScroll extends StatelessWidget {
  const EmotionButtonScroll({
    super.key,
    required ScrollController scrollController,
    required this.neutralEmoticon,
    required this.happyEmoticon,
    required this.sadEmoticon,
    required this.angryEmoticon,
    required this.scaredEmoticon,
    required this.embrassedEmoticon,
    required this.hateEmoticon,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final Widget neutralEmoticon;
  final Widget happyEmoticon;
  final Widget sadEmoticon;
  final Widget angryEmoticon;
  final Widget scaredEmoticon;
  final Widget embrassedEmoticon;
  final Widget hateEmoticon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: neutralEmoticon,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: happyEmoticon,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: sadEmoticon,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: angryEmoticon,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: scaredEmoticon,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: embrassedEmoticon,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: hateEmoticon,
          ),

        ]
      ),
    );
  }
}

Future<void> sendDiary(Map<String, dynamic> body) async {
  String springUrl = "$globalUrl/sent_letters";
  String flaskUrl = modelUrl;
  
  final requestSpring = Uri.parse(springUrl);
  final requestFlask = Uri.parse(flaskUrl);
  final jwtToken = await getJwtToken();
  final headersSpring = <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $jwtToken'
  };
  final headersFlask = <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try
    {
      final responseSpring = await http.post(requestSpring, headers: headersSpring, body: json.encode(body));
      final responseFlask = await http.post(requestFlask, headers: headersFlask, body: json.encode(body));
      // print(json.encode(body));
      print(responseFlask.body);
      
    }
  catch(error)
  {
    print('error : $error');
  }
}