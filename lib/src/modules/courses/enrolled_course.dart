import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/courseDetails.dart';
import 'package:rs/src/global/models/courses/course_details_response.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/config.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/course_details.dart';
import 'package:rs/src/modules/courses/course_files.dart';
import 'package:rs/src/modules/courses/course_lessons.dart';
import 'package:rs/src/modules/courses/course_quiz.dart';
import 'package:rs/src/modules/courses/widgets/timer_button.dart';
import 'package:rs/src/modules/login/login_view.dart';

class EnrolledCourseScreen extends StatelessWidget {
  const EnrolledCourseScreen({super.key, required this.course});

  final CourseDetails course;
  @override
  // TODO: implement controller
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
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.size.width,
                                      height: Get.size.width / 2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: course.image != null
                                                  ? NetworkImage(
                                                      "${AppConfig.baseUrl}/${course.image!}")
                                                  : const AssetImage(
                                                          "assets/imgs/Rectangle 8.png")
                                                      as ImageProvider,
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                  child: Icon(
                                                      Icons.favorite_border),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      data.data!.title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(CourseLessons(course: course));
                                        },
                                        child: Container(
                                          height: 65,
                                          width: 322,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: AppColors.primary),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/svg/lessons.svg"),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                Text(
                                                  "lessons".tr,
                                                  style: Get.theme.textTheme
                                                      .bodyText2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(CourseFiles(course: course));
                                        },
                                        child: Container(
                                          height: 65,
                                          width: 322,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: Color(0xffFB2558)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/svg/files.svg"),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                Text(
                                                  "files".tr,
                                                  style: Get.theme.textTheme
                                                      .bodyText2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    course.quiz.isNotEmpty
                                        ? Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                    CourseQuiz(course: course));
                                              },
                                              child: Container(
                                                height: 65,
                                                width: 322,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                    color: Color(0xff6327E4)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/svg/exam.svg"),
                                                      const SizedBox(
                                                        width: 25,
                                                      ),
                                                      Text(
                                                        "tests".tr,
                                                        style: Get
                                                            .theme
                                                            .textTheme
                                                            .bodyText2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
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
            ),
            Positioned(bottom: 100, right: 0, child: TimerButton())
          ],
        ),
      ),
    );
  }
}
