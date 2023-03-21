import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => CalculatorVal()),
            ],
            child: MaterialApp(
              title: 'Calculator App',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme: const TextTheme(
                      headline2: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300))),
              darkTheme: ThemeData(
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(color: Colors.white),
                      headline2: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  scaffoldBackgroundColor: Colors.black,
                  iconTheme: const IconThemeData(
                    color: Colors.orange,
                  )),
              themeMode: currentMode,
              debugShowCheckedModeBanner: false,
              home: const CalculatorApp(),
            ),
          );
        });
  }
}
