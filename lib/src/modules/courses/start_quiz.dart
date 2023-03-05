import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/quiz.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/quiz.dart';
import 'package:rs/src/global/models/courses/quiz_test_res.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/quiz_assignment.dart';
import 'package:rs/src/modules/courses/widgets/timer_button.dart';

class StartQuizScreen extends GetView<QuizController> {
  const StartQuizScreen({super.key, required this.quiz, required this.course});
  final CourseDetails course;
  final Quiz quiz;

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
            FutureBuilder(
              future: controller.getQuizDetails(quiz.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${course.title} /${quiz.title}"),
                      ),
                      const Spacer(),
                      Center(
                          child: SvgPicture.asset("assets/svg/startQuiz.svg")),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          width: 300,
                          height: 150,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: Container(
                                color: AppColors.primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "ready?".tr,
                                        style: TextStyle(
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
                                                      BorderRadius.circular(
                                                          14.0),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xff427CFC))),
                                            onPressed: () async {
                                              QuizTestResponse quisTest =
                                                  await controller.startQuiz(
                                                      snapshot.data!.data!,
                                                      course);
                                              if (quisTest.result) {
                                                controller.currentQuizTest =
                                                    quisTest.data!;
                                                print(snapshot
                                                    .data!.data!.question_time);
                                                controller.assignDuration =
                                                    Duration(
                                                        minutes: snapshot
                                                            .data!
                                                            .data!
                                                            .question_time);
                                                controller.progress =
                                                    (((controller.assignmentIndex +
                                                                    1) /
                                                                snapshot
                                                                    .data!
                                                                    .data!
                                                                    .assign
                                                                    .length) *
                                                            100)
                                                        .toString();
                                                controller.update();
                                                Get.to(QuizAssignmentScreen());
                                              } else {
                                                Get.to(QuizAssignmentScreen());
                                              }
                                            },
                                            child: Text(
                                              "startQuiz".tr,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
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
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Positioned(bottom: 100, right: 0, child: TimerButton())
          ],
        ),
      ),
    );
  }
}
