import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'diary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'get_jwt_token.dart';
import 'functions_diary.dart';

String baseUrl = 'http://10.0.2.2:8080';
// String baseUrl = 'http://172.10.5.90:443';

class TableCalendarScreen extends StatefulWidget {
  TableCalendarScreen(
      {Key? key,
      required this.selectedDay,
      required this.onDaySelected,
      required this.focusedDay})
      : super(key: key);

  DateTime selectedDay;
  DateTime focusedDay;
  Function(DateTime, DateTime) onDaySelected;
  @override
  State<StatefulWidget> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  CalendarFormat format = CalendarFormat.month;
  // late List<Diary> firstList;
  // late Map<DateTime, Diary> firstMap;
  // Future<void> loadDiaryData() async {
  //   var now = DateTime.now();
  //   firstList = await getDateEventMap(now);
  //   firstMap = convertListToMap(firstList);
  //   setState(() {}); // Trigger a rebuild after data is loaded
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        onCalendarCreated: (controller) async {
          var list = await getDateEventMap(DateTime.now());
          var map = convertListToMap(list);
          events.addAll(map);
          if (mounted)
            setState(() {}); // Trigger a rebuild after data is loaded
        },
        onPageChanged: (date) async {
          var list = await getDateEventMap(date);
          var map = convertListToMap(list);
          events.addAll(map);
          print(events);
          // setState(() {}); // Trigger a rebuild after data is loaded
        },
        shouldFillViewport: true,
        calendarStyle: CalendarStyle(
          markerDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            shape: BoxShape.circle,
          ),
          weekendTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        eventLoader: getEventsForDay,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        locale: 'ko_KR',
        focusedDay: widget.focusedDay,
        onDaySelected: widget.onDaySelected,
        selectedDayPredicate: (DateTime day) {
          return isSameDay(widget.selectedDay, day);
        },
        onFormatChanged: (CalendarFormat format) {
          setState(() {
            this.format = format;
          });
        },
      ),
    );
  }
}

// Widget _buildMissionContainer (int index) {
//   return Container(
//     margin: EdgeInsets.symmetric(vertical: 5),
//     height: 80,
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         ),
//     alignment: Alignment.center,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           // width: Get.width*0.6,
//           padding: EdgeInsets.only(bottom: 1),
//           child: Text(events[index]),
//         ),
//       ]
//     )
//   );
// }

