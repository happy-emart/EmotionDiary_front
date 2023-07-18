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
  late List<Diary> firstList;
  late Map<DateTime, Diary> firstMap;

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
      print(json);
      for (var diaryJson in json) {
        // print(diaryJson);
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

  Future<void> loadDiaryData() async {
    var now = DateTime.now();
    firstList = await getDateEventMap(now);
    firstMap = convertListToMap(firstList);
    setState(() {}); // Trigger a rebuild after data is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        onCalendarCreated: (controller) async {
          var list = await getDateEventMap(DateTime.now());
          var map = convertListToMap(list);
          events.addAll(map);
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

  // void 데이터를 불러와야 하는데, 
  // events.add(Map)

  //
}

// Map<DateTime, dynamic> eventSource = {
//   DateTime(2023,8,13) : [Diary(emotion: 1, weather: 1, diaryText: '5분 기도하기')],
//   DateTime(2023,8,5) : [Diary(emotion: 2, weather: 1, diaryText: '밥 먹기')],
//   DateTime(2023,8,8) : [Diary(emotion: 2, weather: 1, diaryText: '코딩 그만하기')],
//   DateTime(2023,8,11) : [Diary(emotion: 2, weather: 1, diaryText: '명상하기')],
//   DateTime(2023,8,13) : [Diary(emotion: 2, weather: 1, diaryText: '삶이 언제나 쉬운 것은 아니다')],
//   DateTime(2023,8,15) : [Diary(emotion: 2, weather: 1, diaryText: '안정적인 사람이 되기')],
//   DateTime(2023,8,18) : [Diary(emotion: 2, weather: 1, diaryText: '행복하기')],
//   DateTime(2023,8,20) : [Diary(emotion: 2, weather: 1, diaryText: '그림 그리기')],
//   DateTime(2023,8,21) : [Diary(emotion: 2, weather: 1, diaryText: '노래 듣기')],
//   DateTime(2023,7,13) : [Diary(emotion: 2, weather: 1, diaryText: '이거 로파이 음악 괜찮은걸')],
//   DateTime(2023,7,5) : [Diary(emotion: 2, weather: 1, diaryText: '근데 로파이가 뭐지')],
//   DateTime(2023,7,8) : [Diary(emotion: 2, weather: 1, diaryText: '세상에 내가 모르는 것은 너무도 많아')],
//   DateTime(2023,7,11) : [Diary(emotion: 2, weather: 1, diaryText: '궁금함이 미덕으로 자리잡은 세상')],
//   DateTime(2023,7,13) : [Diary(emotion: 2, weather: 1, diaryText: '언제나 옳은 것은 없기에')],
//   DateTime(2023,7,15) : [Diary(emotion: 2, weather: 1, diaryText: '우리는 늘 너무도 매몰된 생각만을 고집한다')],
//   DateTime(2023,7,18) : [Diary(emotion: 2, weather: 1, diaryText: '서로에게 늘 상처를 주면서')],
//   DateTime(2023,7,20) : [Diary(emotion: 2, weather: 1, diaryText: '그러기를 반복한다')],
//   DateTime(2023,7,21) : [Diary(emotion: 2, weather: 1, diaryText: '렘브란트')],
// };
Map<DateTime, Diary> eventSource = Map();

LinkedHashMap<DateTime, Diary> events = LinkedHashMap(
  equals: isSameDay,
)..addAll(eventSource); 

List<Diary?> getEventsForDay(DateTime day) {
  // print("events: $events");
  // print([events[DateTime.parse(DateFormat('yyyy-MM-dd').format(day))]] ?? []);
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

