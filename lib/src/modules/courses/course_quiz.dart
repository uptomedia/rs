import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/course_details_response.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/config.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/widgets/quiz_card.dart';

class CourseQuiz extends StatelessWidget {
  const CourseQuiz({super.key, required this.course});
  final CourseDetails course;
  CourseController get controller => Get.find<CourseController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Stack(
          children: [
            const Background(),
            Padding(
              padding: AppPading.defaultPadding,
              child: SizedBox(
                width: Get.size.width,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: controller.getCourseDetails(course.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CourseDetailsResponce data = snapshot.data!;
                          print(data.success);
                          if (data.data == null) {
                            return const Expanded(
                              child: Center(
                                child: Text("No Data"),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text("${course.title} /${"tests".tr}"),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: course.quiz.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: QuizCard(
                                            quiz: course.quiz[index],
                                            course: course,
                                          ),
                                        ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Expanded(
                            child: Center(
                              child: Text(snapshot.error!.toString()),
                            ),
                          );
                        } else {
                          return const Expanded(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
