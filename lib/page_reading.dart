import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'widgets/emoticon_face.dart';
import 'widgets/weather_radio.dart';
import 'package:http/http.dart' as http;
import 'widgets/emotion_converter.dart';
import 'package:emotion_diary/widgets/calendar.dart';
import 'package:emotion_diary/widgets/diary.dart';

// String globalUrl = "http://localhost";
String globalUrl = 'http://172.10.5.90:443';
String modelUrl = "http://172.10.9.25:80/";

class ReadingPage extends StatefulWidget {
  DateTime writtenDate;
  ReadingPage({Key? key, required this.writtenDate}) : super(key: key);

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {

  var emoticonText =
  TextStyle(
    fontFamily: "bookk",
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    var selectedDay = widget.writtenDate;
    var selectedDayString = DateFormat("yyyy년 MM월 dd일").format(selectedDay);
    Diary? eventsForDay = getEventsForDay(widget.writtenDate).isNotEmpty ? getEventsForDay(widget.writtenDate)[0] : Diary(emotion: '100', weather: '100', diaryText: "일기를 쓰지 않은 날입니다.", writtenDate: "2001-01-01");

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
                        "▷ $selectedDayString자 일기입니다",
                        style: emoticonText,
                      ),
                      SizedBox(height: 15,),
                      Container(
                        alignment: Alignment.center,
                        // height: 165,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "오늘의 기분",
                                  style: TextStyle(
                                    fontFamily: "bookk",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "오늘의 기분",
                                  style: TextStyle(
                                    fontFamily: "bookk",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "날씨",
                                  style: TextStyle(
                                    fontFamily: "bookk",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                              // 날씨 이미지
                            ),
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // selecting weather
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
                                  "AI는 어떻게 생각했을까?",
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
                            // RadioButtonWidget2(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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

int emotionConverter(int emotion) {
  switch (emotion) {
    case 0: return 4;
    case 1: return 5;
    case 2: return 3;
    case 3: return 2;
    case 4: return 0;
    case 5: return 1;
    case 6: return 6;
  }
  return 0;
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

void sendDiary(Map<String, dynamic> body) async {
  String springUrl = "$globalUrl/sent_letters";
  String flaskUrl = modelUrl;
  
  final request = Uri.parse(springUrl);
  // final jwtToken = await getJwtToken();
  // final headers = <String, String> {
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'Authorization': 'Bearer $jwtToken'
  // };
  final headers = <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try
    {
      final response = await http.post(request, headers: headers, body: json.encode(body));
      print(json.encode(body));
      print(response.body);
    }
    catch(error)
    {
      print('error : $error');
    }
  }

// Future<String?> getJwtToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('jwtToken');
// }