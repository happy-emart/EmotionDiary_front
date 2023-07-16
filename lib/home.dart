import 'package:emotion_diary/emoticon_face.dart';
import 'package:emotion_diary/main_page.dart';
import 'package:emotion_diary/calendar_page.dart';
import 'package:emotion_diary/writing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
// import ''; smartRefresher

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainPage(name: "영욱"),
    // m,
    CalendarPage(),
    // Text("ghhh"),
    WritingPage(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Theme.of(context).colorScheme.primary),
        Scaffold(
          appBar:
            AppBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 19,
              leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.white70,),
                onPressed: () {},
              ),
              leadingWidth: 70,
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.white70,)
                  ),
                ),
              ],
            ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: Colors.white70), label: '',),
              BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined, color: Colors.white70,), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined, color: Colors.white70), label: ''),
            ],
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            currentIndex: _selectedIndex,
            onTap: _onItemSelected,
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
        ),
      ]
    );
  }
}