import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/calculator/controllers/calculator_controller.dart';
import 'package:scidart/numdart.dart';

import 'widgets/buttons.dart';

class AppColor {
  static const Color grey = Color(0xff262B38);
  static const Color red = Color(0xffFB2558);
}

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});
  CalcuratorController controller = Get.put(CalcuratorController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(),
            body: SizedBox(
              width: Get.size.width,
              child: Column(
                children: [
                  GetBuilder(
                    init: controller,
                    builder: (controller) {
                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: SizedBox(
                          height: Get.size.height * 0.32,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              controller.mode == CalcMode.Integral
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: TextFormField(
                                                  focusNode: controller.maxNode,
                                                  controller: controller.max,
                                                  showCursor: true,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  1)),
                                                ),
                                              ),
                                              const Text(
                                                "∫",
                                                style: TextStyle(fontSize: 35),
                                              ),
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: TextFormField(
                                                  controller: controller.min,
                                                  focusNode: controller.minNode,
                                                  showCursor: true,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  1)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 120,
                                            height: 50,
                                            child: TextFormField(
                                              controller: controller.func,
                                              focusNode: controller.funcNode,
                                              showCursor: true,
                                              readOnly: true,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(1)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : (controller.mode == CalcMode.Fraction
                                      ? Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 50,
                                                    child: TextFormField(
                                                      focusNode:
                                                          controller.topNode,
                                                      controller:
                                                          controller.top,
                                                      showCursor: true,
                                                      readOnly: true,
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(1)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      color: Colors.white,
                                                      height: 3,
                                                      width: 100,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 50,
                                                    child: TextFormField(
                                                      controller:
                                                          controller.bottom,
                                                      focusNode:
                                                          controller.bottomNode,
                                                      showCursor: true,
                                                      readOnly: true,
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(1)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Align(
                                          alignment: const Alignment(-0.9, 1),
                                          child: Text(controller.userInput,
                                              style: const TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w400)),
                                        )),
                              // const SizedBox(height: 10),
                              Align(
                                alignment: const Alignment(0.9, 1),
                                child: Text(controller.answer,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(thickness: 3, color: AppColor.grey.withOpacity(0.2)),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: SizedBox(
                      height: Get.size.height * 0.6,
                      child: Column(
                        children: [
                          Table(children: [
                            TableRow(
                              children: [
                                MyButton(
                                    color: AppColor.grey, buttonText: '(-)'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'hyp'),
                                MyButton(color: AppColor.grey, buttonText: '←'),
                                MyButton(color: AppColor.grey, buttonText: '→'),
                                MyButton(color: AppColor.grey, buttonText: 'π'),
                                MyButton(color: AppColor.grey, buttonText: 'e'),
                              ],
                            ),
                            TableRow(
                              children: [
                                MyButton(
                                    color: AppColor.grey, buttonText: '×!'),
                                MyButton(color: AppColor.grey, buttonText: '∫'),
                                MyButton(color: AppColor.grey, buttonText: '▲'),
                                MyButton(color: AppColor.grey, buttonText: '▼'),
                                MyButton(
                                    color: AppColor.grey, buttonText: '×ˉ¹'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'log a'),
                              ],
                            ),
                            TableRow(
                              children: [
                                MyButton(
                                    color: AppColor.grey, buttonText: 'b/c'),
                                MyButton(color: AppColor.grey, buttonText: 'x'),
                                MyButton(
                                    color: AppColor.grey, buttonText: '×²'),
                                MyButton(
                                    color: AppColor.grey, buttonText: '×^'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'log'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'ln'),
                              ],
                            ),
                            TableRow(
                              children: [
                                // MyButton(color: AppColor.grey, buttonText: 'deg'),
                                // MyButton(color: AppColor.grey, buttonText: '2nd'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'sin'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'cos'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'tan'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'sinˉ¹'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'cosˉ¹'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'tanˉ¹'),
                              ],
                            ),
                            TableRow(
                              children: [
                                MyButton(
                                    color: AppColor.grey, buttonText: 'nCr'),
                                MyButton(
                                    color: AppColor.grey, buttonText: 'nPr'),
                                MyButton(color: AppColor.grey, buttonText: '('),
                                MyButton(color: AppColor.grey, buttonText: ')'),
                                MyButton(color: AppColor.grey, buttonText: '∛'),
                                MyButton(color: AppColor.grey, buttonText: '√'),
                              ],
                            ),
                          ]),
                          Table(
                            children: [
                              // TableRow(
                              //   children: [

                              //     MyButton(color: AppColor.grey, buttonText: '%'),

                              //   ],
                              // ),
                              TableRow(
                                children: [
                                  MyButton(
                                      color: AppColor.grey, buttonText: '7'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '8'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '9'),
                                  MyButton(
                                      color: AppColor.red, buttonText: 'AC'),
                                  MyButton(
                                      color: AppColor.red, buttonText: '⌫'),
                                ],
                              ),
                              TableRow(
                                children: [
                                  MyButton(
                                      color: AppColor.grey, buttonText: '4'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '5'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '6'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '×'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '÷'),
                                ],
                              ),
                              TableRow(
                                children: [
                                  MyButton(
                                      color: AppColor.grey, buttonText: '1'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '2'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '3'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '+'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '-'),
                                ],
                              ),
                              TableRow(
                                children: [
                                  MyButton(
                                      color: AppColor.grey, buttonText: '0'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '.'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: 'e^'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '×√'),
                                  MyButton(
                                      color: AppColor.grey, buttonText: '='),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
