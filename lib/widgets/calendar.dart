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

String baseUrl = 'http://localhost:8080';
// String baseUrl = 'http://172.10.5.90:443';

class TableCalendarScreen extends StatefulWidget {
  TableCalendarScreen({Key? key, required this.selectedDay, required this.onDaySelected, required this.focusedDay}) : super(key: key);
  
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
          if(mounted)
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
          weekendTextStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
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

Future<List<Diary>> getDateEventMap(DateTime date) async {
  // 서버와 통신해 데이터를 받아온다 -> 일기 데이터와 감정 데이터 부분으로 분리하기
  var writtenDate = DateFormat("yyyy-MM-dd").format(date);
  final String Url = "$baseUrl/received_letters?writtenDate=$writtenDate";
  final jwtToken = await getJwtToken();
  final request = Uri.parse(Url);
  final headers = <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $jwtToken'
  };
  try
  {
    List<Diary> diaryList = [];
    final response = await http.get(request, headers: headers);
    var json = jsonDecode(response.body);
    for (var diaryJson in json) {
      diaryList.add(Diary.fromJson(diaryJson));
    }
    return diaryList;
  }
  catch(error)
  {
    print('error : $error');
  }
  return [];
}

Map<DateTime, Diary> convertListToMap(List<Diary> diaryList) {
  var returnMap = Map<DateTime, Diary>();
  for (var diary in diaryList) {
    var stringToDateTime = DateTime.parse(diary.toDate());
    returnMap[stringToDateTime] = diary;
    // print("------------");
    // print(returnMap[stringToDateTime]);
    // print("------------");
  }
  return returnMap;
}

Map<DateTime, Diary> eventSource = Map();

LinkedHashMap<DateTime, Diary> events = LinkedHashMap(
  equals: isSameDay,
)..addAll(eventSource); 

List<Diary?> getEventsForDay(DateTime day) {
  return [events[DateTime.parse(DateFormat('yyyy-MM-dd').format(day))]].whereType<Diary>().toList();
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

