import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridButtonsWidget extends StatefulWidget {
  const GridButtonsWidget({super.key});

  @override
  State<GridButtonsWidget> createState() => _GridButtonsWidgetState();
}

class _GridButtonsWidgetState extends State<GridButtonsWidget> {
  static const int kMax = 10;
  static const int kMin = 1;

  int rowCount = kMin;
  int colCount = kMin;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }

  double _height() => 1.sh / rowCount.toDouble();
  double _width() => 1.sw / colCount.toDouble();

  void _onTap(int row, int col) {
    setState(() {
      if (row % 2 == 0 && rowCount < kMax && col % 2 == 0) {
        if (rowCount == 2 && colCount == 1) colCount++;
        rowCount++;
        FlutterRingtonePlayer.playRingtone(looping: false, asAlarm: true);
      }
      ;
      if (row % 2 != 0 && rowCount > kMin && col % 2 == 0) {
        rowCount--;
        FlutterRingtonePlayer.playAlarm(looping: false);
      }
      ;
      if (row % 2 == 0 && col % 2 != 0 && colCount < kMax) {
        colCount++;
        FlutterRingtonePlayer.playRingtone(looping: false, asAlarm: true);
      }
      ;
      if (row % 2 != 0 && col % 2 != 0 && colCount > kMin) {
        colCount--;
        FlutterRingtonePlayer.playAlarm(looping: false);
      }
      ;
    });
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
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_selectColor(row, col)),
          visualDensity: VisualDensity.comfortable,
        ),
        child: Text(
          '${row + 1}/${col + 1}',
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Colors.white,
              fontSize: min(_height() / 3.0, _width() / 3.0)),
          softWrap: false,
          overflow: TextOverflow.clip,
        ));
  }
}
