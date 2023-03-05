import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rs/src/global/controllers/courses.dart';
import 'package:rs/src/global/models/courses/course.dart';
import 'package:rs/src/global/utils/colors.dart';
import 'package:rs/src/global/utils/config.dart';
import 'package:rs/src/global/utils/padding.dart';
import 'package:rs/src/modules/courses/course_details.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  CourseCard({super.key, required this.course});
  final CourseController controller = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          Get.to(CourseDetailsScreen(course: course));
        },
        child: Container(
          width: Get.size.width,
          height: 260,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(22)),
          child: SizedBox(
              // width: Get.size.width,
              child: Column(
            children: [
              Container(
                padding: AppPading.defaultPadding,
                width: Get.size.width,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: DecorationImage(
                        image: course.image != null
                            ? NetworkImage(
                                "${AppConfig.baseUrl}/${course.image!}")
                            : AssetImage("assets/imgs/Rectangle 8.png")
                                as ImageProvider,
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          controller.addToFav(course);
                          print("ccccccccccccccccccc");
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Icon(Icons.favorite_border),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: Get.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "courseDuration".tr +
                                    course.duration.toString() +
                                    "days".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w100, fontSize: 11),
                              ),
                              Text(
                                "studentCount".tr +
                                    course.count.toString() +
                                    "student".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w100, fontSize: 11),
                              ),
                            ],
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Color(0xff214591),
                                borderRadius: BorderRadius.circular(22)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                "assets/svg/Group 8.svg",
                                fit: BoxFit.cover,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
