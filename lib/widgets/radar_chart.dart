import 'package:emotion_diary/widgets/probability.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:emotion_diary/page_writing.dart'; // for emotionConverter(int emotion)

class EmotionRadarChart extends StatefulWidget {
  EmotionRadarChart({super.key, required this.todayProbability, required this.yesterdayProbability, required this.isMini});

  Probability? todayProbability;
  Probability? yesterdayProbability;
  bool isMini = false;
  final gridColor = const Color.fromRGBO(243, 229, 245, 1);
  final titleColor = Colors.white;
  final todayColor = Colors.red;
  final yesterdayColor = Colors.cyan;
  // final boxingColor = Colors.green;
  // final entertainmentColor = Colors.white;
  // final offRoadColor = Colors.yellow;
  // final otherColor = Colors.white;

  @override
  State<EmotionRadarChart> createState() => _EmotionRadarChartState();
}

class _EmotionRadarChartState extends State<EmotionRadarChart> {
  int selectedDataSetIndex = 0;
  double angleValue = 0;
  bool relativeAngleMode = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isMini)
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmotionRadarChart(todayProbability: widget.todayProbability, yesterdayProbability: widget.yesterdayProbability, isMini: false,)
          )
        );
      },
      child: Container(
        child: getMiniRadarChart(),
        width: 200,
        height: 200,
      ),
    );
    else
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'AI가 분석한, 당신의 기분 칠각형',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: widget.titleColor,
                                      fontSize: 25,
                                      fontFamily: "bookk",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: rawDataSets()
                                    .asMap()
                                    .map((index, value) {
                                      final isSelected = index == selectedDataSetIndex;
                                      return MapEntry(
                                        index,
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedDataSetIndex = index;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(vertical: 2),
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? widget.titleColor
                                                  : const Color.fromRGBO(0, 0, 0, 0),
                                              borderRadius: BorderRadius.circular(46),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 6,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AnimatedContainer(
                                                  duration: const Duration(milliseconds: 400),
                                                  curve: Curves.easeInToLinear,
                                                  padding: EdgeInsets.all(isSelected ? 8 : 6),
                                                  decoration: BoxDecoration(
                                                    color: value.color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                AnimatedDefaultTextStyle(
                                                  duration: const Duration(milliseconds: 300),
                                                  curve: Curves.easeInToLinear,
                                                  style: TextStyle(
                                                    color:
                                                        isSelected ? value.color : widget.gridColor,
                                                  ),
                                                  child: Text(value.title),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .values
                                    .toList(),
                              ),
                              getRadarChart(),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AspectRatio getRadarChart() {
    return AspectRatio(
          aspectRatio: 1.33,
          child: RadarChart(
            RadarChartData(
              radarTouchData: RadarTouchData(
                touchCallback: (FlTouchEvent event, response) {
                  if (!event.isInterestedForInteractions) {
                    setState(() {
                      selectedDataSetIndex = -1;
                    });
                    return;
                  }
                  setState(() {
                    selectedDataSetIndex =
                        response?.touchedSpot?.touchedDataSetIndex ?? -1;
                  });
                },
              ),
              dataSets: showingDataSets(),
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(color: Colors.transparent),
              titlePositionPercentageOffset: 0.1,
              titleTextStyle:
                  TextStyle(color: widget.titleColor, fontSize: 15),
              getTitle: (index, angle) {
                final usedAngle =
                    relativeAngleMode ? angle + angleValue : angleValue;
                switch (index) {
                  case 0:
                    return RadarChartTitle(
                      text: '🙂\n중립이에요',
                      angle: usedAngle,
                    );
                  case 1:
                    return RadarChartTitle(
                      text: '😆\n행복해요',
                      angle: usedAngle,
                    );
                  case 2:
                    return RadarChartTitle(
                      text: '😢\n슬퍼요',
                      angle: usedAngle
                    );
                  case 3:
                    return RadarChartTitle(
                      text: '😠\n화나요',
                      angle: usedAngle,
                    );
                  case 4:
                    return RadarChartTitle(
                      text: '😰\n불안해요',
                      angle: usedAngle,
                    );
                  case 5:
                    return RadarChartTitle(
                      text: '😵‍💫\n당황했어요',
                      angle: usedAngle,
                    );
                  case 6:
                    return RadarChartTitle(
                      text: '😒\n싫어요',
                      angle: usedAngle,
                    );
                  default:
                    return const RadarChartTitle(text: '');
                }
              },
              tickCount: 4,
              ticksTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 10),
              tickBorderData: const BorderSide(color: Colors.white),
              gridBorderData: BorderSide(color: widget.gridColor, width: 2),
            ),
            swapAnimationDuration: const Duration(milliseconds: 400),
          ),
        );
  }
  AspectRatio getMiniRadarChart() {
    return AspectRatio(
          aspectRatio: 2,
          child: RadarChart(
            RadarChartData(
              titlePositionPercentageOffset: 0,
              titleTextStyle:
                  TextStyle(color: widget.titleColor, fontSize: 15),
              getTitle: (index, angle) {
                final usedAngle =
                    relativeAngleMode ? angle + angleValue : angleValue;
                switch (index) {
                  case 0:
                    return RadarChartTitle(
                      text: '🙂',
                      angle: usedAngle,
                    );
                  case 1:
                    return RadarChartTitle(
                      text: '😆',
                      angle: usedAngle,
                    );
                  case 2:
                    return RadarChartTitle(
                      text: '😢',
                      angle: usedAngle
                    );
                  case 3:
                    return RadarChartTitle(
                      text: '😠',
                      angle: usedAngle,
                    );
                  case 4:
                    return RadarChartTitle(
                      text: '😰',
                      angle: usedAngle,
                    );
                  case 5:
                    return RadarChartTitle(
                      text: '😵‍💫',
                      angle: usedAngle,
                    );
                  case 6:
                    return RadarChartTitle(
                      text: '😒',
                      angle: usedAngle,
                    );
                  default:
                    return const RadarChartTitle(text: '');
                }
              },
              dataSets: showingDataSets(),
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(color: Colors.transparent),
              tickCount: 4,
              ticksTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 10),
              tickBorderData: const BorderSide(color: Colors.white),
              gridBorderData: BorderSide(color: widget.gridColor, width: 2),
            ),
            swapAnimationDuration: const Duration(milliseconds: 400),
          ),
        );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: '오늘',
        color: widget.todayColor,
        values: [
          widget.todayProbability!.neutral,
          widget.todayProbability!.happy,
          widget.todayProbability!.sad,
          widget.todayProbability!.angry,
          widget.todayProbability!.scared,
          widget.todayProbability!.embrassed,
          widget.todayProbability!.hate,
        ],
      ),
      if (widget.yesterdayProbability != null)
      RawDataSet(
        title: '어제',
        color: widget.yesterdayColor,
        values: [
          widget.yesterdayProbability!.neutral,
          widget.yesterdayProbability!.happy,
          widget.yesterdayProbability!.sad,
          widget.yesterdayProbability!.angry,
          widget.yesterdayProbability!.scared,
          widget.yesterdayProbability!.embrassed,
          widget.yesterdayProbability!.hate,
        ],
      ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}