import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextScreen extends StatelessWidget {
  const InputTextScreen({super.key, this.onlyNumbers = false});
  final bool onlyNumbers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(height: 0.2.sw),
          Text(onlyNumbers ? 'Ввод чисел' : 'Любой текст'),
          SizedBox(
              width: 0.75.sw,
              child: TextField(
                keyboardType: onlyNumbers ? TextInputType.number : null,
              )),
        ],
      ),
    ));
  }
}
