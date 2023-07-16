import 'package:flutter/material.dart';
import 'dart:convert';
import 'emoticon_face.dart';
import 'weather_radio.dart';


class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _diaryController = TextEditingController();

  @override
  void dispose() {
    _diaryController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var emoticonText = TextStyle(
                                fontFamily: "bookk",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              );
    var happyEmoticon = Column(
                          children: [
                            EmoticonFace(
                              emoticonface: '😆'
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "좋아요",
                              style: emoticonText,
                            ),
                          ],
                        );
    var sadEmoticon = Column(
                          children: [
                            EmoticonFace(
                              emoticonface: '😢'
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "슬퍼요",
                              style: emoticonText,
                            ),
                          ],
                        );
    var angryEmoticon = Column(
                          children: [
                            EmoticonFace(
                              emoticonface: '😠'
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "화나요",
                              style: emoticonText,
                            ),
                          ],
                        );
    var scaredEmoticon = Column(
                          children: [
                            EmoticonFace(
                              emoticonface: '😰'
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "두려워요",
                              style: emoticonText,
                            ),
                          ],
                        );
    var neutralEmoticon = Column(
                          children: [
                            EmoticonFace(
                              emoticonface: '🙂'
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "평온해요",
                              style: emoticonText
                            ),
                          ],
                        );
    return SafeArea(
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
                      onPressed: () {},
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
    );
  }
}