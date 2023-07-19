import 'package:emotion_diary/tab_controller.dart';
import 'package:emotion_diary/page_writing.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'tab_controller.dart';

const seedColor1 = Color.fromARGB(49, 118, 118, 118);
const seedColor2 = Color.fromARGB(65, 74, 154, 200);
const seedColor3 = Color.fromARGB(65, 74, 200, 137);
const seedColor4 = Color.fromARGB(65, 200, 74, 74);

void mainSub() {
  initializeDateFormatting('ko_KR', null).then((_) => runApp(MainAppSub()));
}

class MainAppSub extends StatelessWidget {
  const MainAppSub({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ko_KR', null);
    return FutureBuilder(
      future: isDiaryWrittenInit(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or some other loading widget
        } else {
          return MaterialApp(
            theme: ThemeData(
              colorSchemeSeed: seedColor1,
              // colorSchemeSeed: seedColor2,
              // colorSchemeSeed: seedColor3,
              // colorSchemeSeed: seedColor4,
              brightness: Brightness.dark,
              // textTheme: TextTheme
            ),
            home: Controller(),
            // home: WritingPage(),
          );
        }
      }
    );
  }
}
