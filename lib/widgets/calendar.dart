import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        shouldFillViewport: true,
        calendarStyle: CalendarStyle(
          markerDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        eventLoader: getEventsForDay,
        // eventLoader: (day) {
        //   if (day.day%2 == 0) return ['hi'];
        //   return [];
        // },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        locale: 'ko_KR',
        focusedDay: widget.focusedDay,
        // onDaySelected: (DateTime selectedDay, focusedDay) {
        //   setState(() {
        //     widget.selectedDay = selectedDay;
        //     widget.focusedDay = focusedDay;
        //   });
        // },
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

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}

Map<DateTime,dynamic> eventSource = {
  DateTime(2023,8,13) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime(2023,8,5) : [Event('5분 기도하기',false),Event('치킨 먹기',true),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime(2023,8,8) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime(2023,8,11) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',true)],
  DateTime(2023,8,13) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime(2023,8,15) : [Event('5분 기도하기',false),Event('치킨 먹기',false),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime(2023,8,18) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime(2023,8,20) : [Event('5분 기도하기',true),Event('자기 셀카 올리기',true),Event('QT하기',true),Event('셀 모임하기',true),],
  DateTime(2023,8,21) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',false)],
  DateTime(2023,7,13) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime(2023,7,5) : [Event('5분 기도하기',false),Event('치킨 먹기',true),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime(2023,7,8) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime(2023,7,11) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',true)],
  DateTime(2023,7,13) : [Event('5분 기도하기',false),Event('교회 가서 인증샷 찍기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime(2023,7,15) : [Event('5분 기도하기',false),Event('치킨 먹기',false),Event('QT하기',true),Event('셀 모임하기',false),],
  DateTime(2023,7,18) : [Event('5분 기도하기',false),Event('자기 셀카 올리기',true),Event('QT하기',false),Event('셀 모임하기',false),],
  DateTime(2023,7,20) : [Event('5분 기도하기',true),Event('자기 셀카 올리기',true),Event('QT하기',true),Event('셀 모임하기',true),],
  DateTime(2023,7,21) : [Event('5분 기도하기',false),Event('가족과 저녁식사 하기',true),Event('QT하기',false)]
};

final events = LinkedHashMap(
  equals: isSameDay,
)..addAll(eventSource); 

List<Event> getEventsForDay(DateTime day) {
  return events[DateTime.parse(DateFormat('yyyy-MM-dd').format(day))] ?? [];
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