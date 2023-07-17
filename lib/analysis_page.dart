import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnlaysisPage extends StatefulWidget {
  const AnlaysisPage({Key? key}) : super(key: key);

  @override
  State<AnlaysisPage> createState() => _AnlaysisPageState();
}

class _AnlaysisPageState extends State<AnlaysisPage> {

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
