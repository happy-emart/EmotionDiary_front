import 'package:flutter/material.dart';
import 'package:emotion_diary/calendar.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
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
                child: Column(
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
                    DropdownButton(
                      value: yearNowString,
                      items: [
                        DropdownMenuItem(value: yearNowString, child: Text('$yearNowString')),
                        DropdownMenuItem(value: "$yearNowString-1", child: Text('$yearNowString')),
                      ],
                      onChanged: (value) {},
                    ),
                    // Expanded(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Theme.of(context).colorScheme.onPrimary,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        child: TableCalendarScreen(),
                      ),
                    ),
                    SizedBox(height: 100,),
                  ],
                ),
              ),
            ),)
        )
      ]
    );
  }
}
