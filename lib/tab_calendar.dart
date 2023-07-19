import 'package:flutter/material.dart';
import 'package:emotion_diary/widgets/calendar.dart';
import 'package:emotion_diary/widgets/diary.dart';
import 'page_reading.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var yearNowString = new DateTime.now().year.toString();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Diary? eventsForDay = getEventsForDay(DateTime.now()).isNotEmpty ? getEventsForDay(DateTime.now())[0] : Diary(emotion: '100', weather: '100', diaryText: "일기를 쓰지 않은 날입니다.", writtenDate: "2001-01-01");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Theme.of(context).colorScheme.primary),
        Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: LayoutBuilder(
                  builder:(context, constraints) => Column(
                    children: [
                      // Search bar
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.white70,),
                            Text('일기의 내용을 검색해보세요.', style: TextStyle(color: Colors.white70,),),
                          ],
                        ),
                      ),
                      // DropdownButton(
                      //   value: yearNowString,
                      //   items: [
                      //     DropdownMenuItem(value: yearNowString, child: Text('$yearNowString')),
                      //     DropdownMenuItem(value: "$yearNowString-1", child: Text('$yearNowString')),
                      //   ],
                      //   onChanged: (value) {},
                      // ),
                
                      // calendar
                      Expanded(
                        child: Container(
                          child: TableCalendarScreen(
                            selectedDay: selectedDay,
                            focusedDay: focusedDay,
                            onDaySelected: (DateTime selectedDay, focusedDay) {
                              setState(() {
                                this.selectedDay = selectedDay;
                                this.focusedDay = focusedDay;
                                eventsForDay = getEventsForDay(selectedDay).isNotEmpty ? getEventsForDay(selectedDay)[0] : null;
                                }
                              );
                            },
                            ),
                          ),
                        ),

                      // diary written on selected day
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          if (getEventsForDay(selectedDay).isNotEmpty)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadingPage(writtenDate: selectedDay),
                              )
                            );
                        },
                        child: Container(
                          height: constraints.maxHeight*0.3,
                          width: constraints.maxWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(eventsForDay?.toEmotion()??""),
                              Text(eventsForDay?.toWeather()??"일기를 쓰지 않은 날입니다"),
                              Text(eventsForDay?.toString()??""),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),)
        )
      ]
    );
  }
}
