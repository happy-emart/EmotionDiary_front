import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'widgets/emoticon_face.dart';
import 'widgets/weather_radio.dart';
import 'package:http/http.dart' as http;
import 'widgets/emotion_converter.dart';

String globalUrl = "http://localhost";
String flaskUrl = "http://172.10.9.25:443/";

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
  // String Url = "$globalUrl/sent_letters";
  String Url = flaskUrl;
  
  final request = Uri.parse(Url);
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