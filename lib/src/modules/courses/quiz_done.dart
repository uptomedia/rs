import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/quiz.dart';
import 'package:rs/src/global/models/courses/quiz_result.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/ans_sheet.dart';
import 'package:rs/src/modules/home/home_screen.dart';

class QuizDoneScreen extends GetView<QuizController> {
  final QuizResult result;

  const QuizDoneScreen({super.key, required this.result});

  @override
  QuizController get controller => Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Stack(
          children: [
            const Background(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(child: SvgPicture.asset("assets/svg/done.svg")),
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Container(
                          color: AppColors.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  "Done".tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "your result is ${result.result}/${result.maxResult}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 160,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff427CFC))),
                                      onPressed: () async {
                                        Get.offAll(HomeScreen());
                                      },
                                      child: Text(
                                        "Back to Home".tr,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 160,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff427CFC))),
                                      onPressed: () async {
                                        Get.to(AnsSeet(
                                          result: result,
                                        ));
                                      },
                                      child: Text(
                                        "Answers Sheet".tr,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
