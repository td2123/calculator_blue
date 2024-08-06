import 'package:get/get.dart';

class CalculatorController extends GetxController {
  String output = "0";
  String _output = "0";
  var num1;
  var num2;
  String operand = "";
  bool save = false;
  bool isSelectMinus = false;
  bool isSelectDivide = false;
  bool isSelectMulti = false;
  bool isSelectPlus = false;

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      isSelectMinus = false;
      isSelectDivide = false;
      isSelectMulti = false;
      isSelectPlus = false;
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
      output = _output;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      save = true;
      if (operand == "+") {
        isSelectMinus = false;
        isSelectDivide = false;
        isSelectMulti = false;
        isSelectPlus = true;
        update();
      } else if (operand == "-") {
        isSelectMinus = true;
        isSelectDivide = false;
        isSelectMulti = false;
        isSelectPlus = false;
        update();
      } else if (operand == "×") {
        isSelectMulti = true;
        isSelectMinus = false;
        isSelectDivide = false;
        isSelectPlus = false;
        update();
      } else if (operand == "÷") {
        isSelectDivide = true;
        isSelectMinus = false;
        isSelectMulti = false;
        isSelectPlus = false;
        update();
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      isSelectMinus = false;
      isSelectDivide = false;
      isSelectMulti = false;
      isSelectPlus = false;
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num1 / num2).toStringAsFixed(10);
      }
      num1 = 0;
      num2 = 0;
      operand = "";
      output = _removeTrailingZeros(_output);
    } else if (buttonText == "%") {
      isSelectMinus = false;
      isSelectDivide = false;
      isSelectMulti = false;
      isSelectPlus = false;
      _output = (double.parse(output) / 100).toString();
      output = _removeTrailingZeros(_output);
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        if (save) {
          save = false;
          _output = "";
        }
        _output += buttonText;
      }
      output = _output;
    }
    update();
  }

  String _removeTrailingZeros(String num) {
    if (num.contains('.')) {
      num = num.replaceAll(RegExp(r'0*$'), '');
      num = num.replaceAll(RegExp(r'\.$'), '');
    }
    return num;
  }
}
