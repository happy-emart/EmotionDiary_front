import 'package:flutter/material.dart';

enum Weather { Sunny, Cloudy, Rainy }

class RadioButtonWidget1 extends StatefulWidget {
  const RadioButtonWidget1({Key? key}) : super(key: key);

  @override
  State<RadioButtonWidget1> createState() => _RadioButtonWidget1State();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RadioButtonWidget1State extends State<RadioButtonWidget1> {
  //처음에는 사과가 선택되어 있도록 Apple로 초기화 -> groupValue에 들어갈 값!
  Weather? _weather = Weather.Sunny;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Flexible(
        //   child: ListTile(
        //     //ListTile - title에는 내용, 
        //     //leading or trailing에 체크박스나 더보기와 같은 아이콘을 넣는다.
        //     title: const Text('맑음'),
        //     leading: Radio<Weather>(
        //       value: Weather.Sunny,
        //       groupValue: _weather,
        //       onChanged: (Weather? value) {
        //         setState(() {
        //           _weather = value;
        //         });
        //       },
        //     ),
        //   ),
        // ),
        Column(
          children: [
            Radio<Weather>(
              value: Weather.Sunny,
              groupValue: _weather,
              onChanged: (Weather? value) {
                setState(() {
                  _weather = value;
                });
              },
            ),
            const Text('맑음'),
          ]
        ),
        Column(
          children: [
            Radio<Weather>(
              value: Weather.Cloudy,
              groupValue: _weather,
              onChanged: (Weather? value) {
                setState(() {
                  _weather = value;
                });
              },
            ),
            const Text('흐림'),
          ]
        ),
        Column(
          children: [
            Radio<Weather>(
              value: Weather.Rainy,
              groupValue: _weather,
              onChanged: (Weather? value) {
                setState(() {
                  _weather = value;
                });
              },
            ),
            const Text('비/눈'),
          ]
        ),
      ],
    );
  }
}

class RadioButtonWidget2 extends StatefulWidget {
  RadioButtonWidget2({Key? key, required this.weather}) : super(key: key);
  int weather;
  @override
  State<RadioButtonWidget2> createState() => _RadioButtonWidget2State();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RadioButtonWidget2State extends State<RadioButtonWidget2> {
  @override
  Widget build(BuildContext context) {
    Weather? _weather;
    var num = widget.weather;
    switch (num) {
      case 0:
        _weather = Weather.Sunny;
      case 1:
        _weather = Weather.Cloudy;
      case 2:
        _weather = Weather.Rainy;
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: [
            Radio<Weather>(
              value: Weather.Sunny,
              groupValue: _weather,
              onChanged: (Weather? value) {
                setState(() {
                  _weather = value;
                });
              },
            ),
            const Text('맑음'),
          ]
        ),
        Column(
          children: [
            Radio<Weather>(
              value: Weather.Cloudy,
              groupValue: _weather,
              onChanged: (Weather? value) {
                setState(() {
                  _weather = value;
                });
              },
            ),
            const Text('흐림'),
          ]
        ),
        Column(
          children: [
            Radio<Weather>(
              value: Weather.Rainy,
              groupValue: _weather,
              onChanged: (Weather? value) {
                setState(() {
                  _weather = value;
                });
              },
            ),
            const Text('비/눈'),
          ]
        ),
      ],
    );
  }
}