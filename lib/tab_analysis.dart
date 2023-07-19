import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'widgets/probability.dart';
import 'widgets/radar_chart.dart';
import 'package:line_icons/line_icons.dart';
import 'tab_controller.dart';
import 'widgets/functions_diary.dart';
import 'widgets/diary.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AnlaysisPage extends StatefulWidget {
  const AnlaysisPage({Key? key}) : super(key: key);

  @override
  State<AnlaysisPage> createState() => _AnlaysisPageState();
}

class _AnlaysisPageState extends State<AnlaysisPage> {
  late Diary todayDiary, yesterdayDiary;
  var today =
    DateTime.now().hour < 7
      ? DateTime.now().subtract(Duration(days: 1))
      : DateTime.now();
  
  late http.Response? responseToday, responseYesterday;
  late Probability probabilityToday, probabilityYesterday;
  LinkedHashMap<DateTime, Diary> events = LinkedHashMap<DateTime, Diary>();

  Future<void> getProbability(DateTime todayForProbability) async {
    var diaryList = await getDateEventMap(todayForProbability);
    var incompleteMap = convertListToMap(diaryList);
    events = LinkedHashMap(
      equals: isSameDay,
    )..addAll(incompleteMap);
    var dateKey1 = DateTime.parse(DateFormat('yyyy-MM-dd').format(todayForProbability));
    var dateKey2 = DateTime.parse(DateFormat('yyyy-MM-dd').format(todayForProbability.subtract(Duration(days: 1))));
    if (events.containsKey(dateKey1)) {
      todayDiary = events[dateKey1]!;
      var body1 = {
        'emotion': todayDiary.emotion,
        'text': todayDiary.diaryText,
        'weather': todayDiary.weather,
        'writtenDate': todayDiary.writtenDate,
      };
      responseToday = await getProbabilityFromServer(body1);
      var json = jsonDecode(responseToday!.body);
      print(json['probability']);
      probabilityToday = Probability.fromJson(json);
    } else {
      probabilityToday = Probability(scared: 0, embrassed: 0, angry: 0, sad: 0, neutral: 0, happy: 0, hate: 0);
    }
    if (events.containsKey(dateKey2)) {
      yesterdayDiary = events[dateKey2]!;
      var body2 = {
        'emotion': yesterdayDiary.emotion,
        'text': yesterdayDiary.diaryText,
        'weather': yesterdayDiary.weather,
        'writtenDate': yesterdayDiary.writtenDate,
      };
      responseYesterday = await getProbabilityFromServer(body2);
      var json = jsonDecode(responseYesterday!.body);
      print(json['probability']);
      probabilityYesterday = Probability.fromJson(json);
    } else {
      probabilityYesterday = Probability(scared: 0, embrassed: 0, angry: 0, sad: 0, neutral: 0, happy: 0, hate: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
      future: getProbability(today),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or some other loading widget
        } else {
          return SafeArea(
          child:
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: LayoutBuilder(
                      builder:(context, constraints) => Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Greeting
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              todayTextMaker(),
                            ],
                          ),
                          isDiaryWritten
                            ? Container(
                                width: constraints.maxWidth,
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  )
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // EmotionRadarChart(
                                      //   todayProbability: Probability(
                                      //     scared: 0.7,
                                      //     embrassed: 0.05,
                                      //     angry: 0.2,
                                      //     sad: 0.2,
                                      //     neutral: 0.2,
                                      //     happy: 0.2,
                                      //     hate: 0.2,
                                      //   ),
                                      //   yesterdayProbability: Probability(
                                      //     scared: 0.009,
                                      //     embrassed: 0.2,  
                                      //     angry: 0.1,      
                                      //     sad: 0.6,     
                                      //     neutral: 0.05,
                                      //     happy: 0.02,
                                      //     hate: 0.08,
                                      //   ),
                                      //   isMini: true,
                                      // ),
                                      EmotionRadarChart(todayProbability: probabilityToday, yesterdayProbability: probabilityYesterday, isMini: true),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: constraints.maxHeight*0.3,
                                width: constraints.maxWidth,
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  )
                                ),
                                child:emptyScroll
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
                                        // getContentsBox(context, LineIcons.history, "추억 돌아보기", "과거의 일기를 읽으며 시간 여행을 떠나요"),
                                        // SizedBox(height: 15,),
                                        // isDiaryWritten
                                        //   ? 
                                        //   : emptyScroll,
                                        getContentsBox(context, LineIcons.pen, "내가 기록한 감정 통계", "과거의 일기를 읽으며 추억에 젖어 보아요"),
                                        SizedBox(height: 15,),
                                        getContentsBox(context, LineIcons.robot, "AI 감정 통계", "AI는 내 일기를 어떻게 분석했을까요?"),
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
      }
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

var emptyScroll = Column(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "아직 오늘의 일기를 쓰지 않았어요.\n첫 번째 탭으로 가볼까요?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "bookk",
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
      ]
    ),
  ],
);

Column todayTextMaker() {
  DateTime now = new DateTime.now();
  var date = now.month.toString()+"월 "+now.day.toString()+"일";

  var nameColumn =
    Column(
      children: [
        Text(
          date+"의 감정 통계",
          style: TextStyle(
            fontFamily: "bookk",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  return nameColumn;
}

// makeTodayNonagon(??userid)
// request to server and get the probability data of model
// make radar chart
// make a block that contains that radar chart
// 

// getData function
