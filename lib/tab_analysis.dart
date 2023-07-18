import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'widgets/probability.dart';
import 'widgets/radar_chart.dart';
import 'package:line_icons/line_icons.dart';

class AnlaysisPage extends StatefulWidget {
  const AnlaysisPage({Key? key}) : super(key: key);

  @override
  State<AnlaysisPage> createState() => _AnlaysisPageState();
}

class _AnlaysisPageState extends State<AnlaysisPage> {
    // Future<Map<DateTime, dynamic>> getDateEventMap(DateTime date) async {
    //   서버와 통신해 데이터를 받아온다 -> 일기 데이터와 감정 데이터 부분으로 분리하기
    //   final String Url = "$baseUrl/written_diary";
    //   final jwtToken = await getJwtToken();
    //   final request = Uri.parse(Url);
    //   final headers = <String, String> {
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Authorization': 'Bearer $jwtToken'
    //   };

    //   try
    //   {
    //     final response = await http.get(request, headers: headers);
    //     var json = jsonDecode(response.body);
    //     List<Letter> letters = [];
    //     List<Container> containers = [];
    //     for (var LetterJson in json) {
    //       print(LetterJson);
    //       letters.add(Letter.fromJson(LetterJson));
    //     }

    //     for(var fruit in letters) {
    //       containers.add(createFruit(context, fruit.posX, fruit.posY, fruit.id, fruit.fruitType));
    //     }
    //     return containers;
    //   }
    //   catch(error)
    //   {
    //     print('error : $error');
    //   }
    //   return [];

    //   // return ;
    // }

  @override
  Widget build(BuildContext context) {
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
                      Container(
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
                              EmotionRadarChart(
                                todayProbability: Probability(
                                  scared: 0.7,
                                  embrassed: 0.05,
                                  angry: 0.2,
                                  sad: 0.2,
                                  neutral: 0.2,
                                  happy: 0.2,
                                  hate: 0.2,
                                ),
                                yesterdayProbability: Probability(
                                  scared: 0.009,
                                  embrassed: 0.2,  
                                  angry: 0.1,      
                                  sad: 0.6,     
                                  neutral: 0.05,
                                  happy: 0.02,
                                  hate: 0.08,
                                ),
                                isMini: true,
                              ),
                              Text(
                                    "오늘, 기분이 어때요?",
                                    style: TextStyle(
                                      fontFamily: "bookk",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                              Text(
                                    "오늘, 기분이 어때요?",
                                    style: TextStyle(
                                      fontFamily: "bookk",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                            ],
                          ),
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
                                    // getContentsBox(context, LineIcons.history, "추억 돌아보기", "과거의 일기를 읽으며 시간 여행을 떠나요"),
                                    // SizedBox(height: 15,),
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
