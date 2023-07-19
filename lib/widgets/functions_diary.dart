import 'diary.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:emotion_diary/login_functions.dart';
import 'get_jwt_token.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
String modelUrl = "http://172.10.9.25:80/";

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

Future<http.Response?> getProbabilityFromServer(Map<String, dynamic> body) async {
  String flaskUrl = modelUrl;
  final requestFlask = Uri.parse(flaskUrl);
  final headersFlask = <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  try
    {
      final responseFlask = await http.post(requestFlask, headers: headersFlask, body: json.encode(body));
      return responseFlask;
    }
  catch(error)
  {
    print('error : $error');
  }
  return null;
}
