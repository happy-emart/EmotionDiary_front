import 'package:emotion_diary/emoticon_face.dart';
import 'package:emotion_diary/calendar_page.dart';
import 'package:emotion_diary/writing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
// import ''; smartRefresher


class MainPage extends StatefulWidget {
  final String name;
  const MainPage({Key? key, required this.name}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var name = widget.name;
    var emoticonText = TextStyle(
                                fontFamily: "bookk",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              );
    var neutralEmoticon = buildEmoticonButton(context, emoticonText, '🙂', "중립이에요", 0);
    var happyEmoticon = buildEmoticonButton(context, emoticonText, '😆', "행복해요", 1);
    var sadEmoticon = buildEmoticonButton(context, emoticonText, '😢', "슬퍼요", 2);
    var angryEmoticon = buildEmoticonButton(context, emoticonText, '😠', "화나요", 3);
    var scaredEmoticon = buildEmoticonButton(context, emoticonText, '😰', "불안해요", 4);
    var embrassedEmoticon = buildEmoticonButton(context, emoticonText, '😵‍💫', "당황했어요", 5);
    var hateEmoticon = buildEmoticonButton(context, emoticonText, '😒', "싫어요", 6);

    return SafeArea(
            child:
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) => 
                            // Greeting
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                greetingTextMaker("$name님", constraints.maxWidth),
                              ],
                            ), 
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                          "오늘, 기분이 어때요?",
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
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25,),
                          Expanded(
                            child: Container(
                            //   decoration: BoxDecoration(
                            //   color: Colors.amber,
                            // //   borderRadius: BorderRadius.circular(20),
                            //   border: Border(
                            //     top: BorderSide(
                            //       color: Theme.of(context).colorScheme.onPrimary,
                            //       width: 1,
                            //     ),
                            //   )
                            // ),
                              color: Theme.of(context).colorScheme.background,
                              child: Center(
                                child: Flexible(
                                  fit: FlexFit.loose,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        getContentsBox(context, LineIcons.history, "추억 돌아보기", "과거의 일기를 읽으며 시간 여행을 떠나요"),
                                        SizedBox(height: 15,),
                                        // getContentsBox(context, LineIcons.pen, "내가 기록한 감정 통계", "과거의 일기를 읽으며 추억에 젖어 보아요"),
                                        // SizedBox(height: 15,),
                                        // getContentsBox(context, LineIcons.robot, "AI 감정 통계", "AI는 내 일기를 어떻게 분석했을까요?"),
                                        SizedBox(height: 15,),
                                        getContentsBox(context, LineIcons.robot, "AI 감정 통계", "AI는 내 일기를 어떻게 분석했을까요?"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ],
                      ),
                    ),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(25),
                  //   child: Container(
                  //     height: 100,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
          );
  }

  InkWell buildEmoticonButton(BuildContext context, TextStyle emoticonText, String emoticon, String emotionDescription, int emotionToInt) {
    return InkWell(
    onTap:() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WritingPage(emotion: emotionToInt)));
    },
    child: Column(
      children: [
        EmoticonFace(
          emoticonface: emoticon
        ),
        SizedBox(height: 8,),
        Text(
          emotionDescription,
          style: emoticonText
        ),
      ],
    )
  );
  }

  ClipRRect getContentsBox(BuildContext context, IconData icon, String mainText, String description) {
  return
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 120,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    mainText,
                    style: TextStyle(
                      fontFamily: "bookk",
                      fontSize: 20,
                    ),
                  ),
                ]
              ),
              SizedBox(height: 10,),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }  
}

Column greetingTextMaker(String name, double width) {
  DateTime now = new DateTime.now();
  var date = now.year.toString()+"년 "+now.month.toString()+"월 "+now.day.toString()+"일 ";

  var greetingMentList = [
    "오늘도 와 주셨네요. 반가워요, ",
    "오늘 하루도 수고했어요, ",
    "늘 그렇듯 고생 많았어요, ",
    "다시 만나게 돼서 좋네요, ",
  ];

  var nameColumn =
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          child: WrappedKoreanText(
            greetingMentList[math.Random().nextInt(greetingMentList.length)]+name,
            style: TextStyle(
              fontFamily: "bookk",
              fontWeight: FontWeight.w700,
              fontSize: 40,
              color: Colors.white,
              ),
            ),
          ),
        SizedBox(
          height: 8,
        ),
        Text(
          date,
          style: TextStyle(
            fontFamily: "bookk",
            fontWeight: FontWeight.w400,
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  return nameColumn;
}