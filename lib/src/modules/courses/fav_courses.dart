import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';

import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/widgets/course_card.dart';

class FavCoursesScreen extends GetView<CourseController> {
  const FavCoursesScreen({super.key});

  @override
  CourseController get controller => Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Stack(
          children: [
            const Background(),
            GetBuilder(
              init: controller,
              builder: (controller) {
                return Padding(
                  padding: AppPading.defaultPadding,
                  child: SizedBox(
                      width: Get.size.width,
                      child: ListView.builder(
                        itemCount: controller.fav.length,
                        itemBuilder: (context, index) {
                          return CourseCard(course: controller.fav[index]);
                        },
                      )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
