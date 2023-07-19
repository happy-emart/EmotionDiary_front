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
import 'widgets/calendar.dart';
import 'widgets/diary.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
// import ''; smartRefresher

bool isDiaryWritten = false;
int _selectedIndex = 0;

void isDiaryWrittenInit() async {
  var now = DateTime.now();
  var yesterday = DateTime.now().subtract(Duration(days: 1));
  var today = now.hour < 7 ? yesterday : now;

  Map<DateTime, Diary> eventSource = Map();
  LinkedHashMap<DateTime, Diary> events = LinkedHashMap(
    equals: isSameDay,
  )..addAll(eventSource); 
  var list = await getDateEventMap(today);
  var map = convertListToMap(list);
  events.addAll(map);
  [events[DateTime.parse(DateFormat('yyyy-MM-dd').format(today))]].whereType<Diary>().toList()
}
class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  final PageController _pageController = PageController();

  // isDiaryWritten;

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