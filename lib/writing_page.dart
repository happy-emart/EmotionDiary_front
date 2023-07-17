import 'package:flutter/material.dart';
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
    var neutralEmoticon = buildButton(1, '🙂', "평온해요");
    var happyEmoticon = buildButton(2, '😆', "좋아요");
    var sadEmoticon = buildButton(3, '😢', "슬퍼요");
    var angryEmoticon = buildButton(4, '😠', "화나요");
    var scaredEmoticon = buildButton(5, '😰', "두려워요");
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
                      // 오늘의 기분 -> 메인 페이지에서 선택한 것을 활성으로 띄워주고, 변경하려면 변경 버튼을 눌러 감정 변경이 가능한 Alert Dialog를 띄울 예정
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
                            SingleChildScrollView(
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
                                ]
                              ),
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