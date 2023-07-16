import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

typedef OnDaySelected = void Function(
    DateTime selectedDay, DateTime focusedDay);

bool Function(DateTime day)? selectedDayPredicate;


class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();
  // @override
  // void initState() {
  //   initializeDateFormatting('ko_KR').then((_) {
  //     ru
  //   })
  // }

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
        focusedDay: focusedDay,
        onDaySelected: (DateTime selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
        onFormatChanged: (CalendarFormat format) {
        setState(() {
            this.format = format;
          });
        },
      ),
      // ...getEventsForDay(dat)
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
// return Container ( margin: EdgeInsets symmetric (vertical: 5), height: 80, decoration: BoDecoration(
// color: Colors.white,
// borderRadiUs: BorderRadius. circular (20)
// ) , / / BoxDecoration
// alignment: Alignment.center, - child: Row( mainAxisAlignment: MainAxisAlignment. spaceBetween,
// children: [
// Container (
// //명시적으로text가차지할영역정해주기 width: Get.width*0.6, padding: EdgeInsets.onLyCLettinG)
// child: Text (controller .missionList [index])
// ),
// /Container SizedBox (width: Get.width*0.1),
// _buildMissitonCompleteBox (index) ,
// SizedBox(width: Get.width*0.1,)