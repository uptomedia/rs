import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/course.dart';
import 'package:rs/src/global/models/courses/courses_responce.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/global/widgets/app_bar.dart';
import 'package:rs/src/global/widgets/background.dart';
import 'package:rs/src/modules/courses/widgets/course_card.dart';

class CoursesScreen extends GetView<CourseController> {
  const CoursesScreen({super.key});

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
            Padding(
              padding: AppPading.defaultPadding,
              child: SizedBox(
                width: Get.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "popularCourses".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FutureBuilder(
                      future: controller.getPopularCourses(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CoursesResponce data = snapshot.data!;
                          if (snapshot.data!.data!.length == 0)
                            return Expanded(
                                child: Center(
                              child: Text("No data"),
                            ));
                          return Expanded(
                              child: ListView.builder(
                            itemCount: data.data!.length,
                            itemBuilder: (context, index) {
                              return CourseCard(course: data.data![index]);
                            },
                          ));
                        }
                        if (snapshot.hasError) {
                          return Expanded(
                              child: Center(
                            child: Text(snapshot.error!.toString()),
                          ));
                        }
                        return Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      },
                    )
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
