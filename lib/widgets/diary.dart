import 'package:flutter/material.dart';
import 'enum.dart';

class Diary {
  final int emotion;
  final int weather;
  final String diaryText;

  Diary({required this.emotion, required this.weather, required this.diaryText});

  @override
  String toString() => diaryText;

  String toWeather() {
    switch (weather) {
      case 0:
        return "맑음";
      case 1:
        return "흐림";
      case 2:
        return "눈/비";
    }
    return "데이터 없음";
  }

  String toEmotion() {
    switch (emotion) {
      case 0:
        return "불안해요";
      case 1:
        return "당황했어요";
      case 2:
        return "화나요";
      case 3:
        return "슬퍼요";
      case 4:
        return "중립이에요";
      case 5:
        return "행복해요";
      case 6:
        return "싫어요";
    }
    return "데이터 없음";
  }

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        emotion: json['emotion'],
        weather: json['weather'],
        diaryText: json['diaryText'],
    );
  }
}