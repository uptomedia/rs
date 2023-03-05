import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
import 'package:rs/src/modules/courses/video_player.dart';

class CourseLessons extends StatelessWidget {
  const CourseLessons({super.key, required this.course});
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${course.title} / ${"lessons".tr}"),
                                  ),
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
                                                child:
                                                    Icon(Icons.favorite_border),
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
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "chapters".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: course.chapters.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: ExpansionTile(
                                                title: Text(course
                                                    .chapters[index].name),
                                                // subtitle: Text(course.lessons
                                                //     .firstWhere((element) =>
                                                //         element.chapter_id ==
                                                //         course
                                                //             .chapters[index].id)
                                                //     .name),
                                                leading: Container(
                                                    width: 5,
                                                    color:
                                                        AppColors.textFormFill),
                                                children: course.lessons
                                                        .where((element) =>
                                                            element
                                                                .chapter_id ==
                                                            course
                                                                .chapters[index]
                                                                .id)
                                                        .isNotEmpty
                                                    ? course.lessons
                                                        .where((element) =>
                                                            element
                                                                .chapter_id ==
                                                            course
                                                                .chapters[index]
                                                                .id)
                                                        .map((e) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: e.name !=
                                                                      "null"
                                                                  ? ListTile(
                                                                      onTap:
                                                                          () {
                                                                        controller.completeLesson(
                                                                            e,
                                                                            course);
                                                                        Get.to(VideoPlayerScreen(
                                                                            lesson:
                                                                                e));
                                                                      },
                                                                      title:
                                                                          Text(
                                                                        e.name,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      leading: Container(
                                                                          width:
                                                                              5,
                                                                          color:
                                                                              AppColors.primary),
                                                                      trailing:
                                                                          Container(
                                                                        height:
                                                                            44,
                                                                        width:
                                                                            44,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppColors.primary,
                                                                            borderRadius: BorderRadius.circular(12)),
                                                                        child: Center(
                                                                            child:
                                                                                SvgPicture.asset("assets/svg/start.svg")),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                            ))
                                                        .toList()
                                                    : []));
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
