import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/calculator/calculator_screen.dart';
import 'package:rs/src/modules/calculator/controllers/calculator_controller.dart';

// creating Stateless Widget for buttons
class MyButton extends GetView<CalcuratorController> {
// declaring variables
  final color;
  final String buttonText;
  @override
  CalcuratorController controller = Get.find<CalcuratorController>();
//Constructor
  MyButton({
    this.color,
    required this.buttonText,
  });
  void buttonPressed(String buttonText) {
    if (buttonText == 'sin') {
      controller.addText('sin(');
    } else if (buttonText == "b/c") {
      // controller.calculate();
      // controller.answer =
      //     Fraction.fromDouble(double.parse(controller.answer)).toString();
      controller.mode = CalcMode.Fraction;
      controller.update();
    } else if (buttonText == 'cos') {
      controller.addText('cos(');
    } else if (buttonText == '×√') {
      controller.addText('×√(');
    } else if (buttonText == 'tan') {
      controller.addText('tan(');
    } else if (buttonText == 'nPr') {
      controller.mode = CalcMode.NpR;
      controller.addText('P');
      controller.update();
    } else if (buttonText == 'nCr') {
      controller.mode = CalcMode.NcR;
      controller.addText('C');
      controller.update();
    } else if (buttonText == 'sinˉ¹') {
      controller.addText('sinˉ¹(');
    } else if (buttonText == 'cosˉ¹') {
      controller.addText('cosˉ¹(');
    } else if (buttonText == 'tanˉ¹') {
      controller.addText('tanˉ¹(');
    } else if (buttonText == '√') {
      controller.addText('√(');
    } else if (buttonText == '∛') {
      controller.addText('∛(');
    } else if (buttonText == '×ˉ¹') {
      controller.addText('1/');
    } else if (buttonText == '?') {
      controller.addText('rand()');
    } else if (buttonText == 'ln') {
      controller.addText('ln(');
    } else if (buttonText == 'log a') {
      controller.addText('log');
    } else if (buttonText == 'log') {
      controller.addText('log10(');
    } else if (buttonText == '×^') {
      controller.addText('^');
    } else if (buttonText == '×²') {
      controller.addText('^2');
    } else if (buttonText == '×!') {
      controller.addText('!');
    } else if (buttonText == 'AC') {
      controller.clear();
    } else if (buttonText == '⌫') {
      controller.backspace();
    } else if (buttonText == '=') {
      controller.calculate();
    } else if (buttonText == 'EXP') {
      controller.addText('e^');
    } else if (buttonText == 'hyp') {
      controller.mode = CalcMode.Hyp;
      Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
              width: Get.size.width,
              child: Stack(
                children: [
                  const Background(),
                  Table(
                    children: [
                      TableRow(children: [
                        MyButton(color: AppColor.grey, buttonText: 'sinh'),
                        MyButton(color: AppColor.grey, buttonText: 'cosh'),
                        MyButton(color: AppColor.grey, buttonText: 'tanh'),
                      ])
                    ],
                  ),
                ],
              ));
        },
      ));
    } else if (buttonText == '▲') {
      // controller.userInput = (int.parse(controller.userInput) + 1).toString();
      controller.topNode.requestFocus();
      controller.update();
    } else if (buttonText == '▼') {
      // controller.userInput = (int.parse(controller.userInput) - 1).toString();
      controller.bottomNode.requestFocus();
      controller.update();
    } else if (buttonText == '→') {
      controller.offsetRight();
    } else if (buttonText == '←') {
      controller.offsetLeft();
    } else if (buttonText == '∫') {
      controller.mode = CalcMode.Integral;
      controller.update();
    } else if (buttonText == '(-)') {
      controller.addText('-');
    } else {
      controller.addText(buttonText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalcuratorController>(
      init: controller,
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 40,
          child: GestureDetector(
            onTap: () => buttonPressed(buttonText),
            child: Padding(
              padding: const EdgeInsets.all(0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: color,
                  child: Center(
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
