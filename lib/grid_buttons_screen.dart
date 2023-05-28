import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridButtonsScreen extends StatefulWidget {
  const GridButtonsScreen({super.key});

  @override
  State<GridButtonsScreen> createState() => _GridButtonsScreenState();
}

class _GridButtonsScreenState extends State<GridButtonsScreen> {
  static const int kMax = 16;
  static const int kMin = 1;

  int rowCount = kMin;
  int colCount = kMin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: rowCount,
        itemBuilder: (_, row) => SizedBox(
          height: _height(),
          child: ListView.builder(
              padding: const EdgeInsets.all(2),
              scrollDirection: Axis.horizontal,
              itemCount: colCount,
              itemBuilder: (context, col) {
                return SizedBox(
                  width: _width(),
                  child: _Button(
                    row: row,
                    col: col,
                    onTap: () => _onTap(row, col),
                    rowCount: rowCount,
                    colCount: colCount,
                  ),
                );
              }),
        ),
      ),
    );
  }

  double _height() => 1.sh / rowCount.toDouble();
  double _width() => 1.sw / colCount.toDouble();

  void _onTap(int row, int col) {
    setState(() {
      if (row % 2 == 0 && rowCount < kMax && col % 2 == 0) {
        if (rowCount == 2 && colCount == 1) colCount++;
        rowCount++;
        _play(mode: 0);
      }
      if (row % 2 != 0 && rowCount > kMin && col % 2 == 0) {
        rowCount--;
        _play(mode: 1);
      }
      if (row % 2 == 0 && col % 2 != 0 && colCount < kMax) {
        colCount++;
        _play(mode: 0);
      }
      if (row % 2 != 0 && col % 2 != 0 && colCount > kMin) {
        colCount--;
        _play(mode: 1);
      }
    });
  }

  _play({int mode = 0}) {
    // if (mode == 0 && colCount > 10) {
    //   FlutterRingtonePlayer.playRingtone(looping: false, asAlarm: true);
    // }
    // if (mode == 1) {
    //   FlutterRingtonePlayer.playAlarm(looping: false);
    // }
  }
}

class _Button extends StatelessWidget {
  final int row;
  final int col;
  final int rowCount;
  final int colCount;
  final Function() onTap;

  const _Button({
    required this.row,
    required this.col,
    required this.rowCount,
    required this.onTap,
    required this.colCount,
  });

  double _height() => 1.sh / rowCount.toDouble();
  double _width() => 1.sw / colCount.toDouble();

  Color _selectColor(int row, int col) {
    return row % 2 == 0
        ? col % 2 == 0
            ? Colors.green
            : Colors.amber
        : col % 2 == 0
            ? Colors.blue
            : Colors.deepOrangeAccent;
  }

  @override
  Widget build(BuildContext context) {
    final size = min(_height() / 3.0, _width() / 3.0);
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_selectColor(row, col)),
          visualDensity: VisualDensity.comfortable,
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        ),
        child: Text(
          '${row + 1}/${col + 1}',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white, fontSize: size),
          softWrap: false,
          overflow: TextOverflow.clip,
        ));
  }
}
