import 'package:flutter/material.dart';
import 'package:emotion_diary/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var yearNowString = new DateTime.now().year.toString();
  
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
                          child: TableCalendarScreen(),
                        ),
                      ),

                      // diary written on selected day
                      SizedBox(height: 15),
                      Container(
                        height: constraints.maxHeight*0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(12),
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
