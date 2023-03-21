import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  padding: const EdgeInsets.all(16),
                  icon: const Icon(Icons.dark_mode),
                  onPressed: () {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  }),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(height: 150, child: getVal(context)),
                )),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              customButton(context, 'AC', Colors.grey.shade500, 1.55,
                  textColor: Colors.black, fontWeight: FontWeight.w500),
              customButton(context, '+/-', Colors.grey.shade500, 1.55,
                  textColor: Colors.black, fontWeight: FontWeight.w500),
              customButton(context, '%', Colors.grey.shade500, 1.55,
                  textColor: Colors.black, fontWeight: FontWeight.w500),
              customButton(context, '÷', Colors.orange, 2.0),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              customButton(context, '7', Colors.grey.shade800, 1.55),
              customButton(context, '8', Colors.grey.shade800, 1.55),
              customButton(context, '9', Colors.grey.shade800, 1.55),
              customButton(context, 'x', Colors.orange, 1.8),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              customButton(context, '4', Colors.grey.shade800, 1.55),
              customButton(context, '5', Colors.grey.shade800, 1.55),
              customButton(context, '6', Colors.grey.shade800, 1.55),
              customButton(context, '-', Colors.orange, 3.0),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              customButton(context, '1', Colors.grey.shade800, 1.55),
              customButton(context, '2', Colors.grey.shade800, 1.55),
              customButton(context, '3', Colors.grey.shade800, 1.55),
              customButton(context, '+', Colors.orange, 2.0),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              customButton(context, '0', Colors.grey.shade800, 1.55,
                  width: 150,
                  align: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              customButton(context, '.', Colors.grey.shade800, 1.55),
              customButton(
                context,
                '=',
                Colors.orange,
                2.0,
              ),
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  Text getVal(BuildContext context) {
    var val = context.watch<CalculatorVal>().display;
    var decimal = context.watch<CalculatorVal>().decimalPlaces;
    String display = val.toString();
    if (val.toString().endsWith('.0') && decimal == 0) {
      display = display.substring(0, display.length - 2);
    }
    return Text(
      display,
      style: Theme.of(context).textTheme.headline2,
      softWrap: true,
      maxLines: 2,
    );
  }

  SizedBox customButton(
      BuildContext context, String text, Color bgcolor, double fontSize,
      {Color? textColor,
      FontWeight? fontWeight,
      double? height,
      double? width,
      Alignment? align,
      OutlinedBorder? shape}) {
    return SizedBox(
      height: height ?? 65,
      width: width ?? 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: shape ?? const CircleBorder(),
              elevation: 0,
              shadowColor: null,
              backgroundColor: bgcolor),
          onPressed: () => context.read<CalculatorVal>().change(text),
          child: Align(
            widthFactor: 8.5,
            alignment: align ?? Alignment.center,
            child: Text(text,
                textScaleFactor: fontSize,
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: fontWeight ?? FontWeight.w400,
                    color: textColor ?? Colors.white)),
          )),
    );
  }
}

class CalculatorVal with ChangeNotifier {
  String _lastOp = '';
  double _display = 0;
  double _prevVal = 0;
  int _decimalPlaces = 0;

  double get display => _display;
  int get decimalPlaces => _decimalPlaces;

  void change(String val) {
    switch (val) {
      case "AC":
        _decimalPlaces = 0;
        _display = 0;
        _lastOp = '';
        _prevVal = 0;
        break;
      case "%":
        _display /= 100;
        break;
      case "+/-":
        if (_display == 0) {
          break;
        }
        _display = -_display;
        break;
      case "+":
        _performOps();
        _prevVal = _display;
        _display = 0;
        _lastOp = "+";
        break;
      case "-":
        _performOps();
        _prevVal = _display;
        _display = 0;
        _lastOp = "-";
        break;
      case "x":
        _performOps();
        _prevVal = _display;
        _display = 0;
        _lastOp = "x";
        break;
      case "÷":
        _performOps();
        _prevVal = _display;
        _display = 0;
        _lastOp = "÷";
        break;
      case "=":
        _performOps();
        break;
      case ".":
        _decimalPlaces = 1;
        break;
      default:
        if (_decimalPlaces > 0) {
          _display = _display + (double.parse(val)/pow(10, _decimalPlaces));
          _decimalPlaces += 1;
          break;
        }
        _display = _display * 10 + double.parse(val);
        break;
    }
    notifyListeners();
  }

  void _performOps() {
    switch (_lastOp) {
      case '+':
        _display = _prevVal + _display;
        break;
      case '-':
        _display = _prevVal - _display;
        break;
      case 'x':
        _display = _prevVal * _display;
        break;
      case '÷':
        _display = _prevVal / _display;
        break;
    }
    _decimalPlaces = 0;
    _lastOp = '';
  }
}
