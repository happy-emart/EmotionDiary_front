import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'emoticon_face.dart';
import 'weather_radio.dart';
import 'package:http/http.dart' as http;

String globalUrl = "http://localhost";

class WritingPage extends StatefulWidget {
  int emotion;
  WritingPage({Key? key, required this.emotion}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _diaryController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late int selectedButton = widget.emotion;
  void toggleSelection(int buttonNumber) {
    if (selectedButton == buttonNumber) return;
    setState(() {
      selectedButton = buttonNumber;
    });
  }

  @override
  void dispose() {
    _diaryController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    // var happyEmoticon = ElevatedButton(
    //   onPressed: () {},
    //   child: Column(
    //     children: [
    //       EmoticonFace2(
    //         emoticonface: '😆'
    //       ),
    //       SizedBox(height: 8,),
    //       Text(
    //         "좋아요",
    //         style: emoticonText,
    //       ),
    //     ],
    //   ),
    // );
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
                            RadioButtonWidget(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextField(
                            controller: _diaryController,
                            maxLines: null, // Allows the TextField to expand vertically as needed
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: "mainfont",
                                fontSize: 15,
                              ),
                              hintText: '여기에 일기를 써 주세요',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextField(
                            controller: _diaryController,
                            maxLines: null, // Allows the TextField to expand vertically as needed
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: "mainfont",
                                fontSize: 15,
                              ),
                              hintText: '사건 해시태그(미정)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          var diary = _diaryController.text;
                          print(diary);
                          // send 
                          var body = {
                            // 'id': id,
                            'emotion': selectedButton,
                            'text': diary,
                            'weather': selectedButton,
                          };
                          sendDiary(body);
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
  String Url = "$globalUrl/sent_letters";
  final request = Uri.parse(Url);
  // final jwtToken = await getJwtToken();
  // final headers = <String, String> {
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'Authorization': 'Bearer $jwtToken'
  // };
  try
    {
      // final response = await http.post(request, headers: headers, body: json.encode(body));
      // print(response.body);
    }
    catch(error)
    {
      // print('error : $error');
    }
  }

// Future<String?> getJwtToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('jwtToken');
// }