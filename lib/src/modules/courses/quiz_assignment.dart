import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rs/src/global/controllers/quiz.dart';
import 'package:rs/src/global/models/courses/submit_ans.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/widgets/timer_button.dart';

class QuizAssignmentScreen extends GetView<QuizController> {
  const QuizAssignmentScreen({super.key});
  @override
  QuizController get controller => Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    controller.startTimer();
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          const Background(),
          GetBuilder(
              init: controller,
              builder: (controller) {
                return Padding(
                  padding: AppPading.defaultPadding,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 325,
                            height: 45,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 319 *
                                      (double.parse(controller.progress) / 100),
                                  child: Container(
                                    height: 41,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Center(
                                        child: Text("${controller.progress}%")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text((controller.assignDuration.inSeconds -
                                  controller.time.inSeconds)
                              .toString()),
                          Text(
                            "السؤال ${controller.lessonQuizDetails!.assign.length}/${controller.assignmentIndex + 1}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Text(
                            controller
                                .lessonQuizDetails!
                                .assign[controller.assignmentIndex]
                                .question_bank
                                .question,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          ...controller
                              .lessonQuizDetails!
                              .assign[controller.assignmentIndex]
                              .question_bank
                              .question_mu
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: Get.size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: AppColors.textFormFill),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(e.title)),
                                          Checkbox(
                                            value: e.selected,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize.padded,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    AppColors.primary),
                                            onChanged: (val) {
                                              e.selected = val!;
                                              if (val) {
                                                controller.answers.add(e.id);
                                              } else {
                                                controller.answers.remove(e.id);
                                              }
                                              controller.update();
                                            },
                                            shape: const CircleBorder(),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: 180,
                              height: 70,
                              child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff427CFC))),
                                  onPressed: () async {
                                    controller.submitAns(SubmitAns(
                                        assign_id: controller
                                            .lessonQuizDetails!
                                            .assign[controller.assignmentIndex]
                                            .id,
                                        quiz_test_id:
                                            controller.currentQuizTest!.id,
                                        ans: controller.answers));
                                  },
                                  child: Text(
                                    "next".tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
          Positioned(bottom: 100, right: 0, child: TimerButton())
        ]),
      ),
    );
  }
}
