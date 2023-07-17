import 'package:emotion_diary/emoticon_face.dart';
import 'package:emotion_diary/calendar_page.dart';
import 'package:emotion_diary/writing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
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
    var neutralEmoticon = buildEmoticonButton(context, emoticonText, '🙂', "평온해요", 1);
    var happyEmoticon = buildEmoticonButton(context, emoticonText, '😆', "좋아요", 2);
    var sadEmoticon = buildEmoticonButton(context, emoticonText, '😢', "슬퍼요", 3);
    var angryEmoticon = buildEmoticonButton(context, emoticonText, '😠', "화나요", 4);
    var scaredEmoticon = buildEmoticonButton(context, emoticonText, '😰', "두려워요", 5);
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
                          // Greeting
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              greetingTextMaker("$name님"),
                            ],
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
                                  height: 20,
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
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Container(
                                            height: 100,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 25,),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Container(
                                            height: 100,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 25,),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Container(
                                            height: 100,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 25,),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Container(
                                            height: 100,
                                            color: Colors.white,
                                          ),
                                        ),
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
}

Column greetingTextMaker(String name) {
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
        Text(
          greetingMentList[math.Random().nextInt(greetingMentList.length)]+name,
          style: TextStyle(
            fontFamily: "bookk",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
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
          ),
        ),
      ],
    );
  return nameColumn;
}