import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear/wear.dart';

import 'grid_buttons_screen.dart';
import 'input_text_screen.dart';

/*

*/

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      child: MyHomePage(),
      builder: (BuildContext context, WearMode mode, Widget? child) {
        return ScreenUtilInit(
            designSize: const Size(450, 450),
            builder: (context, child1) {
              return MaterialApp(
                theme: _themeData(mode),
                debugShowCheckedModeBanner: false,
                home: child1,
              );
            },
            child: child);
      },
    );
  }

  // Меняем общую тему в зависимости от режима
  ThemeData _themeData(WearMode mode) {
    return mode == WearMode.active
        ? ThemeData(
            visualDensity: VisualDensity.compact,
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00B5FF),
              onPrimary: Colors.white,
            ),
          )
        : ThemeData(
            visualDensity: VisualDensity.compact,
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              // dark colorscheme
              primary: Colors.white24,
              onBackground: Colors.white10,
              onSurface: Colors.white24,
            ),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(color: Colors.white24),
              bodyMedium: TextStyle(color: Colors.white10),
            ),
          );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(Theme.of(context).secondaryHeaderColor),
      //foregroundColor: MaterialStateProperty.all(Colors.white),
      visualDensity: VisualDensity.comfortable,
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 0.75.sh,
          width: 0.75.sw,
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: context.goButtonTest,
                style: buttonStyle,
                child: const Text('Тест кнопок'),
              ),
              ElevatedButton(
                onPressed: context.goInputText,
                style: buttonStyle,
                child: const Text('Ввод текста'),
              ),
              ElevatedButton(
                onPressed: context.goInputNum,
                style: buttonStyle,
                child: const Text('Ввод чисел'),
              ),
            ],
          ),
        ),
      ), //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

extension BuildContextExt on BuildContext {
  goButtonTest() => Navigator.of(this)
      .push(MaterialPageRoute(builder: (context) => const GridButtonsScreen()));
  goInputText() => Navigator.of(this)
      .push(MaterialPageRoute(builder: (context) => const InputTextScreen()));
  goInputNum() => Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => const InputTextScreen(onlyNumbers: true)));
}
