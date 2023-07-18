import 'package:emotion_diary/tab_analysis.dart';
import 'package:emotion_diary/widgets/emoticon_face.dart';
import 'package:emotion_diary/tab_main.dart';
import 'package:emotion_diary/tab_calendar.dart';
import 'package:emotion_diary/widgets/probability.dart';
import 'package:emotion_diary/page_writing.dart';
import 'widgets/radar_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'main_sub.dart';
// import ''; smartRefresher

class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static List<Widget> _widgetOptions = <Widget>[
    MainPage(name: "영욱"),
    CalendarPage(),
    AnlaysisPage(),
  ];

  // void _onItemSelected(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  void _onItemSelected(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Theme.of(context).colorScheme.primary),
        Scaffold(
          drawer: const NavigationDrawer(),
          appBar:
            AppBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 19,
              // leading: IconButton(
              //   icon: Icon(Icons.menu, color: Colors.white70,),
              //   onPressed: () {},
              // ),
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
          // body: _widgetOptions.elementAt(_selectedIndex),
          body: PageView(
            controller: _pageController,
            children: _widgetOptions,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ]
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildHeader(context),
        buildMenuItems(context),
      ],
    ),
  );

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );
  Widget buildMenuItems(BuildContext context) => Column(
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text("Home"),
        onTap: () {},
      ),
      // ListTile(
      //   leading: Icon(
      //     MainApp.themeNotifier.value == ThemeMode.light
      //       ? Icons.dark_mode
      //       : Icons.light_mode
      //   ),
      //   onTap: () {
      //     MainApp.themeNotifier.value =
      //       MainApp.themeNotifier.value == ThemeMode.light
      //         ? ThemeMode.dark
      //         : ThemeMode.light;
      //   },
      //   title:
      //     MainApp.themeNotifier.value == ThemeMode.light
      //       ? Text("다크 모드로 전환")
      //       : Text("라이트 모드로 전환"),
        
      // ),
    ],
  );
}