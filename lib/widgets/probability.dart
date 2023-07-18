import 'package:flutter/material.dart';
import 'enum.dart';

class Probability {
  final double scared;
  final double embrassed;
  final double angry;
  final double sad;
  final double neutral;
  final double happy;
  final double hate;

  Probability({
    required this.scared,
    required this.embrassed,
    required this.angry,
    required this.sad,
    required this.neutral,
    required this.happy,
    required this.hate,
    });

  factory Probability.fromJson(Map<String, dynamic> json) {
    return Probability(
        scared: json['scared'],
        embrassed: json['embrassed'],
        angry: json['angry'],
        sad: json['sad'],
        neutral: json['neutral'],
        happy: json['happy'],
        hate: json['hate'],
    );
  }
}