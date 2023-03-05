import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/quiz.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/modules/courses/start_quiz.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz, required this.course});
  final CourseDetails course;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: Get.size.width,
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Text(
                quiz.instruction,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(StartQuizScreen(quiz: quiz, course: course));
                  },
                  child: Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                        color: const Color(0xff427CFC),
                        borderRadius: BorderRadius.circular(11)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "startQuiz".tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )),
          SvgPicture.asset("assets/svg/book.svg")
        ],
      ),
    );
  }
}
