import 'package:emotion_diary/home.dart';
import 'package:emotion_diary/writing_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

const seedColor = Color.fromARGB(49, 118, 118, 118);
void main() {
  initializeDateFormatting('ko_KR', null).then((_) => runApp(MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: seedColor,
        brightness: Brightness.dark,
        // textTheme: TextTheme
      ),
      home: Home(),
      // home: WritingPage(),
    );
  }
}
