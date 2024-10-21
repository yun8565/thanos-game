import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thanos_game/like.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(ThanosApp());
}

// StatelessWidget을 상속 받습니다.
class ThanosApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThanosAppState();
}

class _ThanosAppState extends State<ThanosApp> {
  List<String> _names = [

  ];
  bool _showThanos = false;
  bool _showTimer = false;
  // build 메소드를 구현합니다. ThanosApp에서 보여질 위젯들을 return에 넣어줍니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("타노스 게임"),
        ),
        body: Stack(alignment: Alignment.center, children: [
          _buildGridView(),
          if (_showThanos)
            Center(
              child: Image.asset("assets/thanos_snap.gif"),
            ),
          if (_showTimer)
            Countdown(
              seconds: 5,
              build: (context, second) {
                return Text(
                  second.toString(),
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              onFinished: () => setState(() {
                _showTimer = false;
                _showThanos = true;
                Future.delayed(
                    Duration(milliseconds: 3500),
                    () => setState(() {
                          _showThanos = false;
                          _names.shuffle(Random());
                          _names = _names.take(_names.length ~/ 2).toList();
                    }));
              }),
            ),
          Container(
            margin: EdgeInsets.only(top: 300),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.04),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: TextField(
              onSubmitted: (text) => setState(() {
                _names.add(text);
              }),
            ),
          )
        ]),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  GridView _buildGridView() {
    return GridView(
      // GridView의 모양을 설정할 수 있습니다.
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 세로 줄의 갯수를 정해줍니다.
        crossAxisCount: 3,
        childAspectRatio: 1.5, // 가로세로 1.5 : 1 비율
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      // 바둑판에 들어갈 각각의 카드 위젯을 넣는 곳입니다.
      children: [
        for (var name in _names)
          NameCard(
              name: name,
              onDelete: () {
                setState(() {
                  _names.remove(name);
                });
              })
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      child: Image.asset("assets/finger_snap.png"),
      onPressed: _onPressedFloatingActionButton,
    );
  }

  void _onPressedFloatingActionButton() {
    setState(() {
      int len = _names.length;
      if (len > 1) {
        _showTimer = true;
      }
    });
  }
}

class NameCard extends StatelessWidget {
  final String name;
  final Function() onDelete;

  const NameCard({super.key, required this.name, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(name),
      IconButton(
          icon: Icon(Icons.delete), color: Colors.grey, onPressed: onDelete)
    ]));
  }
}
