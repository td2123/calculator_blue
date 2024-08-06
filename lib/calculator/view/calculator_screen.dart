import 'package:bounce/bounce.dart';
import 'package:calculator/calculator/controller/calculator_controller.dart';
import 'package:calculator/utils/color.dart';
import 'package:calculator/utils/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({super.key});

  final CalculatorController calculatorController =
      Get.put(CalculatorController());

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<CalculatorController>(builder: (logic) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: Get.height * 0.35,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  logic.output,
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: Font.nunito,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      _buildButton("C", CColor.deleteColor, false),
                      _buildButton("7", Colors.white, false),
                      _buildButton("4", Colors.white, false),
                      _buildButton("1", Colors.white, false),
                      _buildButton("0", Colors.white, false),
                    ],
                  ),
                  Column(
                    children: [
                      _buildButton(
                          "×", CColor.darkThemColor, logic.isSelectMulti),
                      _buildButton("8", Colors.white, false),
                      _buildButton("5", Colors.white, false),
                      _buildButton("2", Colors.white, false),
                      _buildButton("00", Colors.white, false),
                    ],
                  ),
                  Column(
                    children: [
                      _buildButton("÷", CColor.darkThemColor, logic.isSelectDivide),
                      _buildButton("9", Colors.white, false),
                      _buildButton("6", Colors.white, false),
                      _buildButton("3", Colors.white, false),
                      _buildButton(".", Colors.white, false),
                    ],
                  ),
                  Column(
                    children: [
                      _buildButton(
                          "%", CColor.darkThemColor, false),
                      _buildButton(
                          "-", CColor.darkThemColor, logic.isSelectMinus),
                      Bounce(
                        onTap: () {
                          logic.buttonPressed("+");
                        },
                        tilt: true,
                        filterQuality: FilterQuality.high,
                        tiltAngle: BorderSide.strokeAlignCenter,
                        child: Container(
                          height: 192,
                          width: 96.1,
                          margin: const EdgeInsets.all(1),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: CColor.black12,
                            border: Border.all(
                                color: logic.isSelectPlus
                                    ? Colors.white
                                    : CColor.transparent),
                          ),
                          child: Text(
                            "+",
                            style: TextStyle(
                                fontSize: 32,
                                fontFamily: Font.nunito,
                                color: CColor.darkThemColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      _buildButton("=", Colors.white, false),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  _buildButton(String buttonText, Color textColor, bool isSelect) {
    return GetBuilder<CalculatorController>(builder: (logic) {
      return Bounce(
        onTap: () {
          logic.buttonPressed(buttonText);
        },
        duration: Duration.zero,
        child: Container(
          height: 95,
          width: 96.1,
          margin: const EdgeInsets.all(1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color:
                  (buttonText == "=") ? CColor.darkThemColor : CColor.black12,
              border: Border.all(
                  color: isSelect ? Colors.white : CColor.transparent)),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: buttonText == "=" || buttonText == "-" ? 30 : 24,
                fontFamily: Font.nunito,
                color: textColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    });
  }
}
