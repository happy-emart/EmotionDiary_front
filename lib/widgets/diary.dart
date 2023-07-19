import 'package:flutter/material.dart';
import 'enum.dart';

class Diary {
  final String emotion;
  final String weather;
  final String diaryText;
  final String writtenDate;

  Diary({required this.emotion, required this.weather, required this.diaryText, required this.writtenDate});
  int characterLimit = 200;
  @override
  String toString() => 
    diaryText.length <= characterLimit
      ? diaryText
      : diaryText.substring(0, characterLimit) + '...';

  String toWeather() {
    switch (weather) {
      case "0":
        return "맑음";
      case "1":
        return "흐림";
      case "2":
        return "눈/비";
    }
    return "데이터 없음";
  }

  String toWeatherEmoji() {
    switch (weather) {
      case "0":
        return "☀️";
      case "1":
        return "☁️";
      case "2":
        return "🌧️";
    }
    return "데이터 없음";
  }

  String toEmotionEmoji() {
    switch (emotion) {
      case "0":
        return "😰";
      case "1":
        return "😵‍💫";
      case "2":
        return "😠";
      case "3":
        return "😢";
      case "4":
        return "🙂";
      case "5":
        return "😆";
      case "6":
        return "😒";
    }
    return "데이터 없음";
  }

  String toEmotion() {
    switch (emotion) {
      case "0":
        return "불안해요";
      case "1":
        return "당황했어요";
      case "2":
        return "화나요";
      case "3":
        return "슬퍼요";
      case "4":
        return "중립이에요";
      case "5":
        return "행복해요";
      case "6":
        return "싫어요";
    }
    return "데이터 없음";
  }

  String toDate() {
    return writtenDate;
  }

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        writtenDate: json['writtenDate'],
        emotion: json['emotion'],
        weather: json['weather'],
        diaryText: json['text'],
    );
  }
}